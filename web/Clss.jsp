<%-- 
    Document   : enrollment_report
    Created on : Jul 23, 2022, 10:04:52 PM
    Author     : Admin
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.Format"%>
<%@page import="a.SM_Values"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="a.SM_cdb"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
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
        <script src="js/jquery.min.js"></script>
        <script>
            $(document).ready(function () {
                $("#shwtbl").click(function () {
                    $("#stdntenrd").show();
                });
            });
            $(document).ready(function () {
                $("#hdtbl").click(function () {
                    $("#stdntenrd").hide();
                });
            });
        </script>
        <style>
            table {
                border-collapse: collapse;
                text-align: center;
            }
            th, td {
                padding: 6px;                
            }
        </style>
    </head>
    <body oncontextmenu="return false" style="display: none;">
        <%@page session="true" import="a.*" %> 
        <%
            a.SM_lb Lb = (a.SM_lb) session.getAttribute("SM_lb");
            a.SM_aw Ab = (a.SM_aw) request.getAttribute("SM_aw");
            if (Lb != null && Lb.getStatus()) {
                Connection con = null;
                Statement stmt = null;
                SM_Values vls = new SM_Values();
                /*artcls = vls.Artcls();*/
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

                String id = request.getParameter("a");
                //Class header data
                String class_id = "";
                String resp_person_id = "";
                String resp_person_name = "";
                String number_of_students = "";
                String class_level = "";
                String class_year = "";
                String description = "";

                String class_header = "";

                try {

                    con = SM_cdb.getConnection();
                    if (con == null) {
                    }
                    stmt = con.createStatement();
                    String qry = "select * from classes where id = '" + id + "'";
                    System.out.println("QRY: " + qry);
                    ResultSet rs = stmt.executeQuery(qry);

                    while (rs.next()) {
                        class_id = rs.getString("class_id");
                        resp_person_id = rs.getString("resp_person_id");
                        resp_person_name = rs.getString("resp_person_name");
                        number_of_students = rs.getString("number_of_students");
                        class_level = rs.getString("class_level");
                        class_year = rs.getString("class_year");
                        description = rs.getString("description");
                        System.out.println(rs.getString("class_id"));
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
                class_header = "<div style='width: 100%; font-size: 20px;'>class_id: <strong style='font-size: 26px; color: blue;'>" + class_id
                        + "</strong> " + "resp_person_id: <strong style='font-size: 26px; color: blue;'>" + resp_person_id
                        + "</strong> " + "resp_person_name: <strong style='font-size: 26px; color: blue;'>" + resp_person_name
                        + "</strong> " + "number_of_students: <strong style='font-size: 26px; color: blue;'>" + number_of_students
                        + "</strong> " + "class_level: <strong style='font-size: 26px; color: blue;'>" + class_level + "</strong> "
                        + "class_year: <strong style='font-size: 26px; color: blue;'>" + class_year
                        + "</strong> " + "description: <strong style='font-size: 26px; color: blue;'>" + description
                        + "</strong></div>";

                //Students data
                String student_id = "";
                String student_name = "";
                String description2 = "";
                String user_datetime = "";
                String iduser = "";
                String student_id_in_class = "";
                String lst_of_students_in_class = "<table id='stdntincls' border='1'>"
                        + "<tr style='height: 46px; background-color:  #9B00FF;background: linear-gradient(to bottom, #9B00FF, white);'>"
                        + "<th>" + lang.lng(current_lang, "student_code") + "</th><th>" + lang.lng(current_lang, "name_of_the_student") + "</th>"
                        + "<th>" + lang.lng(current_lang, "description") + "</th><th>" + lang.lng(current_lang, "registered_in") + "</th>"
                        + "<th>" + lang.lng(current_lang, "registered_by") + "</th>"
                        + "</tr>";;
                String enrolled_students = "<table id='stdntenrd' border='1' style='display: none;'>"
                        + "<tr style='height: 46px; background-color:  #9B00FF;background: linear-gradient(to bottom, #9B00FF, white);'>"
                        + "<th>" + lang.lng(current_lang, "student_code") + "</th><th>" + lang.lng(current_lang, "name_of_the_student") + "</th>"
                        + "<th>" + lang.lng(current_lang, "description") + "</th><th>" + lang.lng(current_lang, "registered_in") + "</th>"
                        + "<th>" + lang.lng(current_lang, "registered_by") + "</th><th>" + lang.lng(current_lang, "action") + "</th></tr>";
                int lst_of_students_in_class_count = 0;
                int enrolled_students_count = 0;
                try {

                    con = SM_cdb.getConnection();
                    if (con == null) {
                    }
                    stmt = con.createStatement();
                    class_year = "2022"; //To be removed after test
                    String qry = "SELECT enrolled_students.student_id as student_id, enrolled_students.student_name as student_name, "
                            + "students_by_classes.description as description, enrolled_students.user_datetime as user_datetime, "
                            + "enrolled_students.iduser as iduser, students_by_classes.student_id as student_id_in_class "
                            + "FROM enrolled_students left join students_by_classes on "
                            + "enrolled_students.student_id = students_by_classes.student_id "
                            + "WHERE enrolled_students.course_level = '" + class_level + "' and "
                            + "enrolled_students.class_year = '" + class_year + "'";
                    //System.out.println("QRY: " + qry);
                    ResultSet rs = stmt.executeQuery(qry);
                    while (rs.next()) {
                        student_id = rs.getString("student_id");
                        student_name = rs.getString("student_name");
                        description2 = rs.getString("description");
                        user_datetime = vls.getDateFromString(rs.getString("user_datetime"));
                        iduser = rs.getString("iduser");
                        student_id_in_class = rs.getString("student_id_in_class");
                        if (student_id_in_class == null || student_id_in_class.equalsIgnoreCase("null")) {
                            student_id_in_class = "a";
                        }
                        if (student_id_in_class.equalsIgnoreCase("a")) {
                            enrolled_students += "<tr><td>" + student_id + "</td><td>" + student_name + "</td><td>" + description2
                                    + "</td><td>" + user_datetime + "</td><td>" + iduser + "</td>"
                                    + "<td><a href='#' onclick=\"processar('" + student_id + "','" + class_id + "','" + student_name + "'"
                                    + ",'" + class_level + "','" + class_year + "','assigclass')\" style='text-decoration: none;'>Colocar nesta turma</a></td></tr>";
                            enrolled_students_count = enrolled_students_count + 1;
                        } else {
                            lst_of_students_in_class += "<tr><td>" + student_id + "</td><td>" + student_name + "</td><td>" + description2
                                    + "</td><td>" + user_datetime + "</td><td>" + iduser + "</td></tr>";
                            lst_of_students_in_class_count = lst_of_students_in_class_count + 1;
                        }
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
                enrolled_students += "</table>";
                lst_of_students_in_class += "</table>";
                String enrolled_s = lang.lng(current_lang, "students_without_class") + " (" + enrolled_students_count + ")";
                String in_class_s = lang.lng(current_lang, "student_list") + " (" + lst_of_students_in_class_count + ")";
        %>
        <div style="position: absolute; top: 0px; left: 0px; display: block; z-index: 0; width: 100%; height: 100%; background-color: white; text-align: left;">
            <a href="#" onclick="lockscreenfnt('<%=lang.lng(current_lang, "lockscreen_message")%>')" title="<%=lang.lng(current_lang, "lockscreen")%>" style="float: right; margin-right: 4px;"><%=lang.lng(current_lang, "lockscreen")%></a><br>			 
            <%=class_header%>
            <hr style="width: 100%;"><br> 
            <strong style="font-size: 20px; color: blue;"><%=enrolled_s%></strong> 
            <a id="shwtbl" href="#" style="text-decoration: none;"><%=lang.lng(current_lang, "show")%></a> 
            <a id="hdtbl" href="#" style="text-decoration: none;"><%=lang.lng(current_lang, "hide")%></a>
            <%=enrolled_students%><br><br>
            <strong style="font-size: 20px; color: blue;"><%=in_class_s%></strong>
            <%=lst_of_students_in_class%>
        </div>
        <div id="dvprcssr" style="position: absolute; top: 0px; left: 0px; display: none; z-index: 100; width: 100%; height: 100%; background-color: #EBF5FB; text-align: center;">
            <span id="closeprocessstatus" style="position: absolute; top: 46%;"><%=lang.lng(current_lang, "processing...")%></span>
        </div>
        <script>
            var gusrlgn = '<%=Lb.getUser()%>';
            var confirm_with_ok_to_continue_or_cancel_to_cancel = "<%=lang.lng(current_lang, "confirm_with_ok_to_continue_or_cancel_to_cancel")%>";
            var do_you_want_to_associate_with_a_customer = "<%=lang.lng(current_lang, "do_you_want_to_associate_with_a_customer")%>";
            var unloakbtn = "<%=lang.lng(current_lang, "processing...")%>";
            var unloakmsg = "<%=lang.lng(current_lang, "unloakmsg")%>";
            var passwordunlk = "<%=lang.lng(current_lang, "password")%>";
            var wrong_credentials = "<%=lang.lng(current_lang, "wrong_credentials")%>";
            var newpageloginagain = "<%=lang.lng(current_lang, "newpageloginagain")%>";

var tprck="";
function processar(a,b,e,f,g,c){tprck=c;var d="";try{document.getElementById("dvprcssr").style.display="block"}catch(h){}"unlckscrn"===tprck&&(d="&s="+document.getElementById("passwrdunlkscrn").value);if("unlckscrn"!==tprck&&!confirm(confirm_with_ok_to_continue_or_cancel_to_cancel)){try{document.getElementById("dvprcssr").style.display="none"}catch(h){}return!1}a="s?t=2&stnd="+a+"&clsid="+b+"&stndname="+e+"&classlevel="+f+"&classyear="+g+"&description=&user="+gusrlgn+"&acao="+c+d;window.ActiveXObject?request=
new ActiveXObject("Microsoft.XMLHTTP"):window.XMLHttpRequest&&(request=new XMLHttpRequest);request.onreadystatechange=rspns;request.open("POST",a,!0);request.send()}
function rspns(){if(4===request.readyState){var a=request.responseText;if(a.includes("sucesso"))location.reload();else if("unlckscrn"===tprck)"yes"===a.replace(/\s+/g,"")?unlockscreenfnt(unloakbtn):alert(wrong_credentials);else try{document.getElementById("dvprcssr").style.display="none"}catch(b){}if("unlckscrn"!==tprck)try{document.getElementById("dvprcssr").style.display="none"}catch(b){}tprck="a"}}
function lockscreenfnt(a){try{document.getElementById("dvprcssr").style.display="block"}catch(b){}try{document.getElementById("closeprocessstatus").innerHTML=""+a+" "+passwordunlk+"<input type='password' id='passwrdunlkscrn' style = 'width: 120px;'/><a href='#' onclick=\"processar('a','a','a','a','unlckscrn','unlckscrn')\">"+unloakmsg+"</a>"}catch(b){}}
function unlockscreenfnt(a){try{document.getElementById("closeprocessstatus").innerHTML=a}catch(b){}try{document.getElementById("dvprcssr").style.display="none"}catch(b){}}window.onload=function(){document.body.style.display="block"};


        </script>
        <%
        } else {
        %>
        <span style="color: red;"><%=lang.lng(current_lang, "your_session_has_expired")%>!</span>  
        <%
            }
        %>
    </body>
</html>