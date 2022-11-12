<%-- 
    Document   : Page2
    Created on : Nov 24, 2021, 4:23:19 PM
    Author     : Admin
--%>

<%@page import="a.SM_PreferedLang"%>
<%@page import="a.SM_language"%>
<%@page import="a.SM_get_lng_file"%>
<%@page import="a.SM_client_session"%>
<%@page import="a.SM_computer_registration"%>
<%@page import="a.SM_Values"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="false" %>
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
        <title>SM</title>
        <link rel="icon" href="img/amora.png" type="image/x-icon" sizes="32x32">
        <link rel="icon" type="image/x-icon" href="img/amoraicon.ico" >
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%
            SM_Values vls = new SM_Values();
            String v = request.getParameter("v");
            String z = request.getParameter("z");
            SM_computer_registration crgt = new SM_computer_registration();
            String d = "";
            if (v == null || v.trim().length() == 0) {
                v = "a";
            }
            if (z == null || z.trim().length() == 0) {
                z = "a";
            } else {
                try{
                   String h = z.split("Clique")[0];
                   z = h; 
                }catch(Exception e){}
                z = "<div style='color: red; width: 100%;'>" + lang.lng(current_lang, "error") + ": " + z + "</div><br>";
            }
            String vlky = "0";
            vlky = cssn.keystatus()[2];
            //System.out.println("vlky: " + vlky);
            String dys = cssn.keystatus()[3];
            int dyss = 0;
            String crgtt = crgt.computer_name_mac_address();
            String cnmc = cssn.keystatus()[5];
            if (crgtt == null || crgtt.trim().length() == 0) {
                crgtt = "a";
            }
            if (cnmc == null || cnmc.trim().length() == 0) {
                cnmc = "a";
            }
            try {
                dyss = Integer.parseInt(dys);
            } catch (Exception e) {
                dyss = 0;
            }
            if (vlky.equalsIgnoreCase("0")) {
            } else if (dyss > 0) {
            } else if (!crgtt.equalsIgnoreCase(cnmc)) {
            } else if (z.trim().length() > 1) {
            } else if (vlky.equalsIgnoreCase("1") || v.contains("sada")) {
            } else{    
        %>
        <meta http-equiv = "refresh" content = "0; url =Login.jsp" />
        <%        
            }
            if (z.equalsIgnoreCase("a")) {
                z = "";
            }
        %>
        <title>SM</title>
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <script src="js/jquery.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
    </head>
    <body oncontextmenu="return false">
      <div style="position: absolute; top: 0px; left: 0px; height: 100%; width: 100%; margin-left: 10px;">  
        <%    
            if (v == null || v.trim().length() == 0 || v.equalsIgnoreCase("a")) {
            } else {
                try{
                   String h = v.split("Clique")[0];
                   v = h; 
                }catch(Exception e){}
                d = "<div style='color: red; width: 100%;'>" + v + "</div>";
            }
        %>
        <div><strong><span id="title_of_proj" style="padding: 10px; font-size: 32px;"><%=lang.lng(current_lang, "school_management_system")%></span></strong></div><br>
        <div><strong><span id="conf_page1"><%=lang.lng(current_lang, "setting_up_the_system")%></span></strong></div><br>
        <form action='s' method='post' accept-charset='UTF-8'>
            <%=d%><br>
            <%=z%>
            <span id="aa"><%=lang.lng(current_lang, "type_the_validation_key")%></span> (<%=lang.lng(current_lang, "ctrl_v_to_paste_text")%>)
            <br>
            <input type="text" class="form-control" id="keysys" name="keysys" aria-describedby="basic-addon3" style="width: 400px;">
            <input type='hidden' name='t' value='100'>
            <br>
            <button type="submit" class="btn btn-primary"><%=lang.lng(current_lang, "process")%></button>
        </form> 
        <br><br>
        <a href="https://amoraservices.org/fqstns.php" style="text-decoration: none;"><%=lang.lng(current_lang, "doubts")%></a>
        <div style="position: fixed; bottom: 2px; right: 2px;">
            <span style="font-size: 12px; background-color: white; color: black; padding-right: 10px;"><%=lang.lng(current_lang, "version")%>: <%=cssn.versionapp()%></span><span style="color: blue; background-color: #E67E22;">Powered by: </span><a href="http://www.amoraservices.org" style="text-decoration: none; color: white; background-color: #E67E22; color: white;"><strong>Amora</strong> Software & Services</a>
        </div>  
      </div>  
    </body>
</html>
