<%-- 
    Document   : we
    Created on : Feb 17, 2022, 1:24:40 PM
    Author     : Admin
--%>

<%@page import="a.SM_PreferedLang"%>
<%@page import="a.SM_client_session"%>
<%@page import="a.SM_language"%>
<%@page import="a.SM_get_lng_file"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>SM</title>
        <link rel="icon" href="img/amora.png" type="image/x-icon" sizes="32x32">
        <link rel="icon" type="image/x-icon" href="img/amoraicon.ico" >
    </head>
    <script>
        function callLoginPage() {
            window.open("Login.jsp", "SM", "toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no, copyhistory=yes, top=0, left=0, width=" + screen.availWidth + ",height=" + screen.availHeight + "");
        }
    </script>   
    <body>
        <%           
           SM_get_lng_file glng = new SM_get_lng_file();
           SM_language lang = new SM_language(glng.getlngs());
           SM_PreferedLang plng;
           plng = new SM_PreferedLang();
           String  current_lang = plng.getPreferedLang();
        %>
        <a href="#" onclick="callLoginPage()" style="text-decoration: none;"><%=lang.lng(current_lang, "page_login")%></a>
    </body>
</html>
