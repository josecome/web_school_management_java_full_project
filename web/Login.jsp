<%-- 
    Document   : newjsp
    Created on : Nov 24, 2021, 12:38:19 AM
    Author     : Admin
--%>
<%@page session="true" import="a.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>SM</title>
        <link rel="icon" href="img/amora.png" type="image/x-icon" sizes="32x32">
        <link rel="icon" type="image/x-icon" href="img/amoraicon.ico" >
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
    </head>
    <body oncontextmenu="return false">
        <%
            SM_Values vls = new SM_Values();
            SM_client_session cssn = new SM_client_session();
            SM_directories_mngmnt dirmng = new SM_directories_mngmnt();
            
            SM_get_lng_file glng = new SM_get_lng_file();
            SM_language lang = new SM_language(glng.getlngs());           
            SM_PreferedLang plng = new SM_PreferedLang();
            String current_lang = plng.getPreferedLang();
           
            String logo = "";
            String logo2 = null;
            String nm = null;
            try{
                logo2 = cssn.getOrgInf()[1];
            }catch(Exception e){}   
            try{
                nm = cssn.getOrgInf()[0];
            }catch(Exception e){} 
            dirmng.creatDBFolder();
            SM_RestoreDB rdb = new SM_RestoreDB("");
            rdb.insert(); 
            //if(1 == 1){return;}
            //boolean rdbempty = rdb.dbIsEmpty(); 
            if(rdb.dbIsEmpty() && (nm == null || nm.trim().length() == 0 || nm.equalsIgnoreCase("null"))){
               try{
                   rdb.insert();
               }catch(Exception e){} 
               %>
                 <meta http-equiv = "refresh" content = "0; url =Page2.jsp"/>
               <% 
               return;  
            }  
            
            //rdb.insert(); 
            //if(1 == 1){return;}
            /*artcls = vls.Artcls();*/
            if(!cssn.atlestoneky()){
               %>
                <meta http-equiv = "refresh" content = "0; url =Page2.jsp"/>
               <% 
               return;  
            }
            logo = cssn.logo();
        %>
        <div style = "background-image: linear-gradient(#5499C7, white, #5499C7);"><img src="<%=cssn.getOrgInf()[1]%>" alt= "Logo" style="width: 140px; height: 70px;"/><strong><span id="title_of_proj" style="padding: 10px; font-size: 32px;"><%=lang.lng(current_lang, "school_management_system")%></span></strong></div><br>
                    
                    <%

                        cssn.updateDate();
                        cssn.appversion_update();
                        String er = request.getParameter("er");
                        String z = request.getParameter("z");
                        String d = "none";
                        String f = "none";
                        String k = "none";
                        if (er == null || er.trim().length() == 0) {
                            d = "none";
                        } else if (er.equalsIgnoreCase("y")) {
                            d = "block";
                        } else if (er.equalsIgnoreCase("op")) {
                            k = "block";
                        } else if (er.equalsIgnoreCase("s")) {
                            f = "block";
                        }
                        String sky = "";
                        if (sky == null || sky.trim().length() == 0) {
                        } else {
                            sky = "<div style='color: green; width: 100%;'>" + sky + "</div>";
                        }
                    %>
                    <%=sky%>     
        <script>
            

        </script>
        <style>
            input[type=text] {
                outline: 0;
                border-width: 0 0 2px;
                border-color: blue
            }
            input[type=text]:focus {
                border-color: green
            }
            input[type=password] {
                outline: 0;
                border-width: 0 0 2px;
                border-color: blue
            }
            input[type=password]:focus {
                border-color: green
            }
        </style>
        <span style="color: #50FF33; font-size: 12px; display: <%=f%>;"><%=lang.lng(current_lang, "successfully_logout")%>!</span>

        <div class="wrapper fadeInDown">
            <div id="formContent" style="border: 1px solid gray; width: 260px; height: 340px;margin: auto;">
                <!-- Login Form -->
                <form action='s' method='post' accept-charset='UTF-8' style="padding: 20px; background-color: #F2F3F4; background: linear-gradient(to bottom, #F2F3F4, white); ">
                    <br><br><br><br>
                    <input type="text" id="login" class="fadeIn second" name="login" placeholder="login"><br><br>
                    <input type="password" id="password" class="fadeIn third" name="password" placeholder="password"><br>
                    <span style="color: red; font-size: 12px; display: <%=d%>;"><%=lang.lng(current_lang, "wrong_credentials")%>!</span><br>
                    <span style="color: red; font-size: 12px; display: <%=k%>;"><%=lang.lng(current_lang, "choose_at_least_one_option")%>!</span>
                    <br>
                    <a href="#" onclick="this.closest('form').submit();return false;">
                        <img src="img/login.png" style="width: 32px; height: 32px;" title="<%=lang.lng(current_lang, "login")%>">
                    </a>                    
                    <!--<input type="submit" class="fadeIn fourth" value="Entrar">-->
                    <input type='hidden' name='t' value='0'>
                    <input type='hidden' id="tblmn" name='scrsz'>
                </form>

                <!-- Remind Passowrd  -->
                <div id="formFooter" style="padding-left: 20px;">
                    <a href="MngrPswds.jsp" style="text-decoration: none;"><%=lang.lng(current_lang, "change_my_password")%></a>
                    <br>
                    <a href="https://amoraservices.org/fqstns.php" style="text-decoration: none;"><%=lang.lng(current_lang, "doubts")%></a>
                    <br>
                </div>

            </div>
        </div>
        <div style="position: fixed; bottom: 2px; right: 2px;">
            <span style="font-size: 12px; background-color: white; color: black; padding-right: 10px;"><%=lang.lng(current_lang, "version")%>: <%=cssn.versionapp()%></span><span style="color: blue; background-color: #E67E22;">Powered by: </span><a href="http://www.amoraservices.org" style="text-decoration: none; color: white; background-color: #E67E22; color: white;"><strong>Amora</strong> Software & Services</a>
        </div>   
        <script>
            rjstmn();
        </script>
        <%
           boolean nd_cnt_serv = cssn.need_to_contact_server();
           if(nd_cnt_serv){
              String[] kary = null;
              kary = cssn.keystatus(); 
              cssn.last_status_of_user_system(kary[11], kary[6], "frmsystm");
           }
        %>
    </body>
</html>
