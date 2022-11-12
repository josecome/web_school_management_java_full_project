/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package a;

import ed.encr;
import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.Format;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLSocketFactory;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import org.apache.commons.io.FileUtils;

/**
 *
 * @author Admin
 */
public class SM_Values {

    private Connection con = null;
    private Statement stmt = null;
    ArrayList<String> PAlst;
    HttpSession sessao;
    SM_directories_mngmnt dirmng;
    SM_language lang;
    String current_lang = "";
    SM_PreferedLang plng;
    encr ec;
    SM_Transformations trnsf;

    public SM_Values() {
        ec = new encr();
        dirmng = new SM_directories_mngmnt();
        PAlst = new ArrayList<String>();
        SM_get_lng_file glng = new SM_get_lng_file();
        trnsf = new SM_Transformations();
        try {
            lang = new SM_language(glng.getlngs());
        } catch (IOException ex) {

        }
        plng = new SM_PreferedLang();
        current_lang = plng.getPreferedLang();
    }

    public String insert_replace_desiglogloc(String n, String lg, String lc, String cdg, String clg, String clc, String lnk_download, int user_r) {
        String a = "";
        String q = "";

        try {
            con = SM_cdb.getConnection();
            if (con == null) {
            }
            con.setAutoCommit(false);
            DatabaseMetaData meta = con.getMetaData();
            if (meta.supportsTransactionIsolationLevel(con.TRANSACTION_REPEATABLE_READ)) {
                con.setTransactionIsolation(con.TRANSACTION_REPEATABLE_READ);
            }
            q = "insert into organization (org_name,org_logo,org_location,org_name_rprt,org_logo_rprt,org_location_rprt,lnk_download,user_datetime,iduser) "
                    + " values ('" + n + "','" + lg + "','" + lc + "','" + cdg + "','" + clg + "','" + clc + "','" + lnk_download + "',CURRENT_DATE," + user_r + ")";
            //System.out.println("img: " + q);
            stmt = con.createStatement();
            String r = "" + stmt.executeUpdate(q);
            con.setAutoCommit(true);
            if (meta.supportsTransactionIsolationLevel(con.TRANSACTION_READ_COMMITTED)) {
                con.setTransactionIsolation(con.TRANSACTION_READ_COMMITTED);
            }
            a = "<span style='color: green;'>Processado com sucesso: " + r + " linhas!</span>";
        } catch (Exception e) {
            a = "<span style='color: red;'>Erro ao processar!</span>";
            e.printStackTrace();
        } finally {
            try {
                SM_cdb.devolveConnection(con);
            } catch (SQLException e) {
                //System.out.println("" + e.getMessage());
            }
            try {
                stmt.close();
            } catch (Exception e) {
            };
        }
        return a;
    }

    public boolean insertClient(String sq) {
        boolean rs = false;
        try {
            con = SM_cdb.getConnection();
            if (con == null) {
            }
            con.setAutoCommit(false);
            DatabaseMetaData meta = con.getMetaData();
            if (meta.supportsTransactionIsolationLevel(con.TRANSACTION_REPEATABLE_READ)) {
                con.setTransactionIsolation(con.TRANSACTION_REPEATABLE_READ);
            }
            stmt = con.createStatement();
            String r = "" + stmt.executeUpdate(sq);
            con.setAutoCommit(true);
            if (meta.supportsTransactionIsolationLevel(con.TRANSACTION_READ_COMMITTED)) {
                con.setTransactionIsolation(con.TRANSACTION_READ_COMMITTED);
            }
            rs = true;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                SM_cdb.devolveConnection(con);
            } catch (SQLException e) {
                //System.out.println("" + e.getMessage());
            }
            try {
                stmt.close();
            } catch (Exception e) {
            };
        }
        return rs;
    }

    public ArrayList getProdPrz() {
        ArrayList<String> Alst = new ArrayList<String>();
        String q = "select article as article,comp_prz as comp_prz,(sum(quantity)-sum(quant_saled)) as qnty from purchases group by article,comp_prz";
        try {
            con = SM_cdb.getConnection();
            if (con == null) {
            }
            String art = "";
            String prz = "";
            String qnty = "";
            stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery(q);
            while (rs.next()) {
                art = rs.getString("article");
                prz = rs.getString("comp_prz");
                qnty = rs.getString("qnty");
                try {
                    String z = art.replaceAll(",", "");
                    art = z;
                } catch (Exception e) {

                }
                try {
                    String z = art.replaceAll(":", "");
                    art = z;
                } catch (Exception e) {

                }
                try {
                    String z = art.replaceAll(";", "");
                    art = z;
                } catch (Exception e) {

                }
                Alst.add("" + art + "," + prz + "," + qnty);
            }
        } catch (Exception e) {
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
        return Alst;
    }

    private String getVlsFrmPAlst(String art_prz) {
        String a = "";
        String fprz = "";
        String fprz10 = "";
        String fprz25 = "";
        String fprz60 = "";

        java.util.Date date_current = new java.util.Date();
        java.util.Date date_current_plus_10 = new java.util.Date();
        java.util.Date date_current_plus_25 = new java.util.Date();
        java.util.Date date_current_plus_60 = new java.util.Date();

        Calendar c10 = Calendar.getInstance();
        c10.setTime(date_current_plus_10);
        c10.add(Calendar.DATE, 10);
        date_current_plus_10 = c10.getTime();

        Calendar c25 = Calendar.getInstance();
        c10.setTime(date_current_plus_25);
        c10.add(Calendar.DATE, 25);
        date_current_plus_25 = c25.getTime();

        Calendar c60 = Calendar.getInstance();
        c10.setTime(date_current_plus_60);
        c10.add(Calendar.DATE, 60);
        date_current_plus_60 = c60.getTime();

        SimpleDateFormat frmt_string_to_date = new SimpleDateFormat("yyyy-MM-dd");

        try {
            for (int i = 0; i < PAlst.size(); i++) {
                try {
                    String v = PAlst.get(i);
                    String[] av = v.split(",");
                    String art = av[0];
                    String prz = av[1];
                    String qnty = av[2];
                    if (prz == null || prz.trim().length() == 0) {
                        prz = "a";
                    } else {
                        try {
                            String[] b = prz.split(" ");
                            prz = b[0];
                        } catch (Exception e) {
                        }
                    }
                    Date przd = prz.equals("a") ? frmt_string_to_date.parse("2100-12-20") : frmt_string_to_date.parse(prz);
                    if (art_prz.equalsIgnoreCase(art)) {
                        if (przd.before(date_current)) {
                            fprz = fprz + qnty;
                        }
                        if (przd.after(date_current) && (przd.before(date_current_plus_10) || przd.equals(date_current_plus_10))) {
                            fprz10 = fprz10 + qnty;
                        }
                        if (przd.after(date_current_plus_10) && (przd.before(date_current_plus_25) || przd.equals(date_current_plus_25))) {
                            fprz25 = fprz25 + qnty;
                        }
                        if (przd.after(date_current_plus_25) && (przd.before(date_current_plus_60) || przd.equals(date_current_plus_60))) {
                            fprz60 = fprz60 + qnty;
                        }
                    }
                } catch (ParseException ex) {
                    //System.out.println("prze: " + ex.getMessage());
                }
            }
        } catch (Exception e) {
        }
        a = fprz + "<td>" + fprz10 + "</td><td>" + fprz25 + "</td><td>" + fprz60 + "</td>";
        return a;
    }

    public String minIntV(String a, String b) {
        int aa = 0;
        int bb = 0;
        try {
            int y = Integer.parseInt(a);
            aa = y;
        } catch (Exception e) {
        }
        try {
            int y = Integer.parseInt(b);
            bb = y;
        } catch (Exception e) {
        }
        return aa < bb ? "" + aa : "" + bb;
    }

    public String minIntV2(String a, String b) {
        java.util.Date aa = new java.util.Date();
        java.util.Date bb = new java.util.Date();
        DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        try {
            aa = formatter.parse("" + a);
        } catch (ParseException ex) {
            try {
                aa = formatter.parse("2020-01-01");
            } catch (Exception e) {
            }
            //System.out.println("ex1: " + ex.getMessage());
        }
        try {
            bb = formatter.parse("" + b);
        } catch (ParseException ex) {
            try {
                bb = formatter.parse("2020-01-01");
            } catch (Exception e) {
            }
            //System.out.println("ex2: " + ex.getMessage());
        }
        return "" + (aa.before(bb) ? aa : bb);
    }

    public String rmvSpcChar(String v) {
        if (v == null || v.trim().length() == 0) {
            return v;
        }
        try {
            String a = v.replaceAll(",", "_");
            v = a;
        } catch (Exception e) {
        }
        try {
            String a = v.replaceAll(";", "_");
            v = a;
        } catch (Exception e) {
        }
        try {
            String a = v.replaceAll("\\.", "_");
            v = a;
        } catch (Exception e) {
        }
        try {
            String a = v.replaceAll(":", "_");
            v = a;
        } catch (Exception e) {
        }
        try {
            String a = v.replaceAll("\"", "");
            v = a;
        } catch (Exception e) {
        }
        try {
            String a = v.replaceAll("'", "");
            v = a;
        } catch (Exception e) {
        }
        try {
            String a = v.replace("\n", "").replace("\r", "");
            v = a;
        } catch (Exception e) {
        }
        return v;
    }
    public String getDateFromString(String v) {
        if (v == null || v.trim().length() == 0) {
            return v;
        }
        try {
            String a = v.split(" ")[0];
            v = a;
        } catch (Exception e) {
        }
        return v;
    }
    public boolean isNmbr(String str) {
        if (str == null || str.trim().length() == 0 || str.equalsIgnoreCase("NA") || str.equalsIgnoreCase("null")) {
            return false;
        }
        try {
            Integer.parseInt(str);
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    public String date_from_days(String d) {
        //System.out.println("d: " + d);
        String s = "";
        if (d == null || d.trim().length() == 0 || d.equalsIgnoreCase("null") || d.equalsIgnoreCase("0")) {
            return "NA";
        }
        int j = 0;
        try {
            int z = Integer.parseInt(d);
            j = z;
        } catch (Exception e) {
        }
        j = (-1) * j;
        Date dtsb = new Date();
        Calendar datesub = Calendar.getInstance();
        datesub.setTime(dtsb);
        datesub.add(Calendar.DATE, j);
        SimpleDateFormat frmt = new SimpleDateFormat("dd/MM/yyyy");
        s = "" + frmt.format(datesub.getTime());
        return s;
    }

    public String list_of_enrolled_client(String sctr) {
        String r = "<table id='' border='1'>"
                + "<tr style=\"height: 46px; background-color:  #9B00FF;background: linear-gradient(to bottom, #9B00FF, white);\">"
                + "<th>" + lang.lng(current_lang, "order") + "</th><th>" + lang.lng(current_lang, "full_name") + "</th>"
                + "<th>" + lang.lng(current_lang, "place_of_residence") + "</th><th>" + lang.lng(current_lang, "bi") + "</th>"
                + "<th>" + lang.lng(current_lang, "telephone") + "</th>"
                + "</tr>";
        try {
            con = SM_cdb.getConnection();
            if (con == null) {
            }
            String q = "select id,clientname,residenty,id_number,phone from deposits";
            //System.out.println("qq: " + q);
            stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery(q);
            while (rs.next()) {
                r += "<tr>";
                r += "<td>" + rs.getString("id") + "</td>"
                        + "<td>" + "<a href='#' onclick=\"setClient('" + rs.getString("id") + "." + rs.getString("clientname") + "')\" style='text-decoration: none;'>"
                        + rs.getString("clientname") + "</a>"
                        + "</td>"
                        + "<td>" + rs.getString("residenty") + "</td>"
                        + "<td>" + rs.getString("id_number") + "</td>"
                        + "<td>" + rs.getString("phone") + "</td>";
                r += "</tr>";
            }
        } catch (Exception e) {
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
        r += "</table>";
        return r;
    }

    public String trnslt(String lng, String a) {
        String b = "";
        if (lng.equalsIgnoreCase("english")) {
            if (a.startsWith("Ferragens")) {
                b = "Hardware";
            } else if (a.startsWith("Farmacia")) {
                b = "Drugstore";
            } else if (a.startsWith("Venda de Pe")) {
                b = "Sale of Parts";
            } else if (a.startsWith("Mercearia")) {
                b = "Grocery store";
            } else if (a.startsWith("Restaurant")) {
                b = "Restaurante";
            } else if (a.startsWith("Bar")) {
                b = "Pub";
            }
        } else if (lng.equalsIgnoreCase("portuguese")) {
            b = a;
        } else if (lng.equalsIgnoreCase("spanish")) {
            if (a.startsWith("Ferragens")) {
                b = "Hardware";
            } else if (a.equalsIgnoreCase("Farmacia")) {
                b = "Drugstore";
            } else if (a.startsWith("Venda de P")) {
                b = "Venta de Repuestos";
            } else if (a.startsWith("Mercearia")) {
                b = "Tienda de comestibles";
            } else if (a.equalsIgnoreCase("Restaurant")) {
                b = "Restaurante";
            } else if (a.startsWith("Bar")) {
                b = "Pub";
            }
        } else if (lng.equalsIgnoreCase("french")) {
            if (a.startsWith("Ferragens")) {
                b = "Material";
            } else if (a.startsWith("Farmacia")) {
                b = "Pharmacie";
            } else if (a.startsWith("Venda de Pe")) {
                b = "Vente de pices";
            } else if (a.startsWith("Mercearia")) {
                b = "Picerie";
            } else if (a.startsWith("Restaurant")) {
                b = "Le Restaurant";
            } else if (a.startsWith("Bar")) {
                b = "Pub";
            }
        } else {
            b = a;
        }
        return b;
    }

    public String removeDuplicateById(String a) {
        String b = "";
        String indxa = "a;";
        try {
            for (String c : a.split(":")) {
                String f = "" + c.split(";")[0] + ";";
                if (!indxa.contains(f)) {
                    b += "" + c + ":";
                }
                indxa += f;
            }
        } catch (Exception e) {
        }

        return b == null || b.trim().length() == 0 ? a : b;
    }

    public String dtfrmt(String clnmnr) {
        //String b = "mysql";  
        String b = "hsqldb";
        if (b.equalsIgnoreCase("mysql")) {
            return "DATE_FORMAT(" + clnmnr + ",'%Y-%m-%d')";
        } else {
            return "CAST(" + clnmnr + " AS DATE)";
        }
    }

    public String courseslst() {
        String a = "";
        try {
            con = SM_cdb.getConnection();
            if (con == null) {
            }
            String q = "select course_id from courses";
            //System.out.println("qq: " + q);
            stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery(q);
            while (rs.next()) {
                a += "<option>" + rs.getString("course_id") + "</option>";
            }
        } catch (Exception e) {
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
        return a;
    }

    public String getStndId(String enroll_type, String student_name, String stundent_surname, String birth_date,
        String enroll_date, int user_register, String phone_1, String course_level) {
        String a = "";
        try {
            con = SM_cdb.getConnection();
            if (con == null) {
            }
            String q = "select student_id from enrolled_students where "
                    + " enroll_type = '" + enroll_type + "' and student_name = '" + student_name + "' and stundent_surname = '" 
                    + stundent_surname + "' and " + " birth_date  = '" + birth_date + "' and enroll_date = '" + enroll_date 
                    + "' and " + " phone_1 = '" + phone_1 
                    + "' and course_level = '" + course_level + "'";            
            stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery(q);
            while (rs.next()) {
                a = rs.getString("student_id");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                SM_cdb.devolveConnection(con);
            } catch (SQLException eb) {
            }
            try {
                stmt.close();
            } catch (Exception e) {
            };
        }
        return a;
    }
    public String dinmcbtn(String nm, String prc, String imgg, String idd, String fltrl) {
        String a = "                                <div style=\"" + fltrl + " background-color: white; display: inline-block; width: 40px; height: 40px; border-radius: 50%;\">\n"
                + "                                    <a href=\"#\" " + idd + " onclick=\"" + prc + "\" style=\"text-decoration: none; float: none; display: inline;\">\n"
                + "                                        <img src=\"" + imgg + "\" style=\"width: 32px; height: 32px;\" title=\"" + nm + "\">\n"
                + "                                    </a>\n"
                + "                                </div>";
        return a;
    }
    public String autorized_enrolmnt_dates() {
        String a = "n:n";
        try {
            con = SM_cdb.getConnection();
            if (con == null) {
            }
            String q = "select id,class_year from enrollment_authorizations where status = '1' and "
                    + " CAST(start_date AS DATE) <= CURRENT_DATE and CAST(end_date AS DATE) >= CURRENT_DATE order by id desc limit 1";
            stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery(q);
            while (rs.next()) {
                a = "a:" + rs.getString("class_year");
            }
        } catch (Exception e) {
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
        return a;
    }
    public String dshtbls(String tbl, String vl) {
        String a = "";
        if (tbl.equalsIgnoreCase("purchases")) {
            tbl = "Compras";
        } else if (tbl.equalsIgnoreCase("expenses")) {
            tbl = "Despesas";
        } else if (tbl.equalsIgnoreCase("sales")) {
            tbl = "Vendas";
        }
        a = "<td style='width: 10px;'></td><td>"
                + "<table style='border-radius: 16px;'>"
                + "<tr>"
                + "<td style='background-color: #A9CCE3;font-size: 16px; color: white;'>" + tbl + "</td>"
                + "<td style='font-size: 28px;'>" + vl + "</td>"
                + "</tr>"
                + "</table>"
                + "</td>";
        return a;
    }
}
