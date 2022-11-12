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
                String typ = request.getParameter("t");
                String tlst = request.getParameter("tlst");
                if(typ == null || typ.trim().length() == 0){
                  typ = "a";
                }
                if(tlst == null || tlst.trim().length() == 0){
                  tlst = "a";
                }
                String user = "Admin";// Lb.getUser();  lvl=" + enrolled_stdnt_crc_yr + "&smts   tlst
                String uusr = request.getParameter("user");
                String lvl = request.getParameter("lvl");
                String smts = request.getParameter("smts");
                String crs_typ = request.getParameter("ctyp");
                if (uusr == null || uusr.trim().length() == 0) {
                } else if (uusr.equalsIgnoreCase("Duplicate")) {
                    user = lang.lng(current_lang, "duplicated");
                }
                String vd = "";
                String vp = "";
                String ref = "";
                String talao = "";
                String banco = "";
                String curso = "";
                String cod_est = "";
                String nivel = "";
                String nome = "";
                String pag_nr = "";
                int y = 2;//1;
                try {
                    con = SM_cdb.getConnection();
                    if (con == null) {
                    }
                    stmt = con.createStatement();
                    String qry = "select enrolled_students.student_name as nome,enrolled_students.course_id as curso, mthly_payments.id as id,"
                            + "mthly_payments.student_id as cod_est,mthly_payments.month_nmb,mthly_payments.amount_to_pay as vd,"
                            + "mthly_payments.amount_paid as vp,mthly_payments.ref_payment as ref,mthly_payments.course_level,"
                            + "mthly_payments.course_simest,mthly_payments.bank_name as banco,mthly_payments.deposit_nmb as talao,"
                            + "mthly_payments.user_datetime as user_datetime "
                            + " from mthly_payments left join enrolled_students on "
                            + " mthly_payments.student_id = enrolled_students.student_id "
                            + " where mthly_payments.student_id";
                    //System.out.println("QRY: " + qry);
                    ResultSet rs = stmt.executeQuery(qry);

                    while (rs.next()) {
                        sale_date = rs.getString("user_datetime");
                        y = y + 1;
                        vd = rs.getString("vd"); 
                        vp = rs.getString("vp");
                        ref = rs.getString("ref");
                        talao = rs.getString("talao");
                        banco = rs.getString("banco");
                        curso = rs.getString("curso");
                        cod_est = rs.getString("cod_est");
                        nome = rs.getString("nome");
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
                if (y > 1) {
                    try {
                        con = SM_cdb.getConnection();
                    } catch (Exception e) {
                    }
                    byte[] bytes = null;
                    try {
                        // carrega os arquivos jasper
                        String reportFileName = null;
                        if(typ.equalsIgnoreCase("stdnt")){
                             reportFileName = "pagamentos_por_estudante.jrxml";
                        } else{
                               if(tlst.equalsIgnoreCase("Estudantes")){
                                       reportFileName = "regist_estudantess.jrxml";
                               } else if(tlst.equalsIgnoreCase("Pagamentos")){
                                       reportFileName = "pagamentos.jrxml";
                               } else if(tlst.equalsIgnoreCase("Devedores")){
                                       reportFileName = "lista_devidores.jrxml";
                               }                              
                        }
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
                        prts.put("usuario", user);
                        prts.put("di", nome);
                        prts.put("df", vd);
                        prts.put("cod", cod);
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
        <div style="color: red; margin-top: 30%;"> <%=lang.lng(current_lang, "this_order_with_code")%> <strong style="color: blue;"><%=cod%></strong> <%=lang.lng(current_lang, "not_yet_registered")%>!</div>
        <%
            }
        } else {
        %>
        <span style="color: red;"><%=lang.lng(current_lang, "your_session_has_expired")%>!</span>  
        <%
            }
        %>
    </body>
</html>
