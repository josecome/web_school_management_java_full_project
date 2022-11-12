<%-- 
    Document   : enrollment_report
    Created on : Jul 23, 2022, 10:04:52 PM
    Author     : Admin
--%>

<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="net.sf.jasperreports.engine.JRResultSetDataSource"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="net.sf.jasperreports.engine.design.JasperDesign"%>
<%@page import="net.sf.jasperreports.engine.JasperPrint"%>
<%@page import="net.sf.jasperreports.engine.JasperReport"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.Format"%>
<%@page import="a.SM_Values"%>
<%@page import="net.sf.jasperreports.engine.JasperRunManager"%>
<%@page import="net.sf.jasperreports.engine.util.JRLoader"%>
<%@page import="net.sf.jasperreports.engine.export.JRPdfExporter"%>
<%@page import="net.sf.jasperreports.export.SimpleExporterInput"%>
<%@page import="net.sf.jasperreports.export.SimpleOutputStreamExporterOutput"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.ByteArrayOutputStream"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="a.SM_cdb"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="net.sf.jasperreports.engine.JasperPrint"%>
<%@page import="net.sf.jasperreports.engine.design.JasperDesign"%>
<%@page import="net.sf.jasperreports.engine.xml.JRXmlLoader"%>
<%@page import="net.sf.jasperreports.engine.JasperReport"%>
<%@page import="net.sf.jasperreports.engine.JasperFillManager"%>
<%@page import="net.sf.jasperreports.engine.JasperExportManager"%>
<%@page import="net.sf.jasperreports.engine.JasperCompileManager"%>
<%@page import="net.sf.jasperreports.engine.JRResultSetDataSource"%>
<%@page import="net.sf.jasperreports.engine.JRException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    SM_get_lng_file glng = new SM_get_lng_file();
    SM_language lang = new SM_language(glng.getlngs());
    SM_client_session cssn = new SM_client_session();
    SM_PreferedLang plng = new SM_PreferedLang();
    String current_lang = plng.getPreferedLang();
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>SM</title>
        <link rel="icon" href="img/amora.png" type="image/x-icon" sizes="32x32">
        <link rel="icon" type="image/x-icon" href="img/amoraicon.ico" >
    </head>
    <body oncontextmenu="return false">
        <%@page session="true" import="a.*" %> 
        <%
            a.SM_lb Lb = (a.SM_lb) session.getAttribute("SM_lb");
            a.SM_aw Ab = (a.SM_aw) request.getAttribute("SM_aw");
            if (Lb != null && Lb.getStatus()) {
                Connection con = null;
                Statement stmt = null;
                SM_Values vls = new SM_Values();
                String b = "";
                String s = "";
                String sale_date = "";
                String pname = cssn.getOrgInf()[0];

                String artcls = "";
                String logo = "";
                String sky = "";
                String dsbld = "";
                /*artcls = vls.Artcls();*/
                logo = cssn.logo();
                String vlky = cssn.keystatus()[2];
                String dys = cssn.keystatus()[3];
                int dyss = 0;
                try {
                    dyss = Integer.parseInt(dys);
                } catch (Exception e) {
                    dyss = 0;
                }
                int sclnt = 1;
                try {
                    sclnt = Integer.parseInt(cssn.keystatus()[9]);
                } catch (Exception e) {
                    sclnt = 1;
                }
                dyss = -10;
                sclnt = -10; //Only for text purpose
                if (dyss > 0 && sclnt > 0) {
                    out.println("<span style='color: red;'>" + lang.lng(current_lang, "the_key_has_expired") + "!</span>");
                    out.close();
                    return;
                }

                String cod = request.getParameter("cod");

                String user = "Admin";// Lb.getUser();  lvl=" + enrolled_stdnt_crc_yr + "&smts
                String uusr = request.getParameter("user");
                String lvl = request.getParameter("lvl");
                String smts = request.getParameter("smts");
                String crs_typ = request.getParameter("ctyp");
                if (smts.equalsIgnoreCase("Primeiro")) {
                    smts = "1";
                } else if (smts.equalsIgnoreCase("Segundo")) {
                    smts = "2";
                }
                if (uusr == null || uusr.trim().length() == 0) {
                } else if (uusr.equalsIgnoreCase("Duplicate")) {
                    user = lang.lng(current_lang, "duplicated");
                }
                String subjects = "";
                try {

                    con = SM_cdb.getConnection();
                    if (con == null) {
                    }
                    stmt = con.createStatement();
                    String qry = "select subject from student_subjects where student_id = '" + cod + "' "
                            + " and course_level = '" + lvl + "' and course_simest = '" + smts + "'";
                    System.out.println("QRY: " + qry);
                    ResultSet rs = stmt.executeQuery(qry);
                    while (rs.next()) {
                        subjects += rs.getString("subject") + ",";
                    }
                } catch (Exception e) {
                    //retorno = new StringBuffer("<div style='color: red;'>Falhou 1 , " + e.getMessage() + "tente novamente</div>");
                    e.printStackTrace();
                } finally {
                    try {
                        SM_cdb.devolveConnection(con);
                    } catch (SQLException eb) {
                        //System.out.println("" + eb.getMessage());
                    }
                    try {
                        stmt.close();
                    } catch (Exception e) {
                    };
                }

                try {
                    con = SM_cdb.getConnection();
                } catch (Exception e) {
                }
                byte[] bytes = null;
                try {
                    // carrega os arquivos jasper
                    String reportFileName = "inscricao.jrxml";
                    String pthfl = SM_Strngs.pth_current_irprt_sgrb_local;
                    if (!(cssn.getPathIrprt()).contains("Apache Tomcat 8.0.27")) {
                        pthfl = cssn.getPathIrprt() + "\\webapps\\SM\\SM";
                    }
                    String reportPath = "" + pthfl + "\\" + reportFileName;
                    //System.out.println("reportPath: " + reportPath);
                    String targetFileName = reportFileName.replace(".jrxml", ".pdf");
                    JasperReport jasperReport = JasperCompileManager.compileReport(reportPath);
                    // parâmetros, se houverem
                    // recebo o valor do formulario e converte-o para inteiro
                    Map prts = new HashMap();
                    prts.put("user", user);
                    prts.put("pname", pname);
                    prts.put("data_venda", sale_date);
                    prts.put("pgtitle", lang.lng(current_lang, "requestforpayment"));
                    prts.put("pgnotice", lang.lng(current_lang, "doesnotserveasaninvoice"));
                    prts.put("pgarticle", lang.lng(current_lang, "article"));
                    prts.put("payment", lang.lng(current_lang, "amountpayable"));
                    prts.put("usertitle", lang.lng(current_lang, "user"));
                    prts.put("totaltitle", lang.lng(current_lang, "total"));
                    prts.put("tipo_curso", lang.lng(current_lang, crs_typ));
                    prts.put("lvl", lvl);
                    prts.put("smt", smts);
                    prts.put("tipo_curso", "Teste");
                    prts.put("c1", "Teste");
                    prts.put("cod", cod);
                    String[] subjectsary = subjects.split(",");
                    int i = 0;
                    String subj = null;
                    try {
                        for (String str : "c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12".split(",")) {                            
                            try{
                                subj = subjectsary[i];
                            }catch(Exception ex){
                                subj = "";
                            }
                            prts.put(str, subj);
                            i = i + 1;
                        }
                    } catch (Exception e) {
                    }
                    //prts.put("sale_date", sale_date);
                    // direcciona a saída do relatório para um stream
                    bytes = JasperRunManager.runReportToPdf(jasperReport, prts, con);
                    //System.out.println("Certo");
                    if (bytes != null && bytes.length > 0) {
                        // envia o relatório no formato PDF para o browser
                        response.setContentType("application/pdf");
                        response.addHeader("Content-disposition", "filename=Enrollment" + cod + ".pdf");
                        //response.addHeader("Content-disposition", "filename=Invoice" + Lb.getUser() + clt + ".pdf");
                        response.setContentLength(bytes.length);
                        ServletOutputStream ouputStream = response.getOutputStream();
                        ouputStream.write(bytes, 0, bytes.length);
                        ouputStream.flush();
                        ouputStream.close();
                    }
                } catch (JRException e) {
                    System.err.println("Erro: " + e);
                }
            } else {
        %>
        <span style="color: red;"><%=lang.lng(current_lang, "your_session_has_expired")%>!</span>  
        <%
            }
        %>
    </body>
</html>
