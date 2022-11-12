<%-- 
    Document   : insc_ren_pag
    Created on : Jan 8, 2022, 10:48:19 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true" import="a.*" %> 
<!DOCTYPE html>
        <%           
           SM_get_lng_file glng = new SM_get_lng_file();
           SM_language lang = new SM_language(glng.getlngs());
           SM_client_session cssn = new SM_client_session();
           SM_PreferedLang plng = new SM_PreferedLang();
           String current_lang = plng.getPreferedLang(); 
        %>
        <%
            String logo = "";
            SM_Values vls = new SM_Values();
            String scrsz = request.getParameter("scrsz");
            SM_Session_Validation ss_vld = new SM_Session_Validation(scrsz);
            String dsbld4 = ss_vld.getDsbld4();
            String sky = ss_vld.getSky();
            String sky2 = ss_vld.getSky2();
            if (dsbld4.equalsIgnoreCase("disabled") && !sky.contains("green")) {
            %>
              <meta http-equiv = "refresh" content = "10; url=Page2.jsp?z=<%=sky2%>"/>
            <%
            }
        %>        
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>SM</title>
        <link rel="icon" href="img/amora.png" type="image/x-icon" sizes="32x32">
        <link rel="icon" type="image/x-icon" href="img/amoraicon.ico" >
        <%       
            /*dsbld = "disabled";*/            
            a.SM_lb Lb = (a.SM_lb) session.getAttribute("SM_lb");
            a.SM_aw Ab = (a.SM_aw) request.getAttribute("SM_aw");
            if (Lb != null && Lb.getStatus()) {
            /*artcls = vls.Artcls();*/
            //logo = vls.logo();
        %>        
        <script>
            var vndits = [];
            var tprck = "z";
            var prvk = "z";
            var gusrlgn = "<%=Lb.getUser()%>"; 
            var confirm_with_ok_to_continue_or_cancel_to_cancel = "<%=lang.lng(current_lang, "confirm_with_ok_to_continue_or_cancel_to_cancel")%>";
            var do_you_want_to_associate_with_a_customer = "<%=lang.lng(current_lang, "do_you_want_to_associate_with_a_customer")%>";
            var unloakbtn = "<%=lang.lng(current_lang, "processing...")%>";
            var unloakmsg = "<%=lang.lng(current_lang, "unloakmsg")%>";
            var passwordunlk = "<%=lang.lng(current_lang, "password")%>";
            var wrong_credentials = "<%=lang.lng(current_lang, "wrong_credentials")%>";
            var newpageloginagain = "<%=lang.lng(current_lang, "newpageloginagain")%>";             
            
var request;function processar(b,a){try{document.getElementById("dvprcssr").style.display="block"}catch(c){}if("b"===a||"unlckscrn"===a)processarb(b,a);else if(confirm("Confirma com OK para continuar ou CANCEL para cancelar"))processarb(b,a);else try{document.getElementById("dvprcssr").style.display="none"}catch(c){}}
function processarb(b,a){tprck=a;prvk=b;var c="";"course"===b||"coursei"===a?c=coursedata():"subject"===b||"subjecti"===a?c=subjectdata():"b"===a?"getcrs"===b?c="&c="+document.getElementById("seach_course_name").value:"getsubjecttoedit"===b?c=currentsubject():(document.getElementById("course_id").disabled=!0,c="&c="+document.getElementById("course_id").value,document.getElementById("course_id").disabled=!1):"unlckscrn"===b&"unlckscrn"===a&&(c="&s="+document.getElementById("passwrdunlkscrn").value);
b="/SM/s?t=2&di=&df=&cc="+document.getElementById("course_id").value+"&user=Admin&acao="+a+"&prv="+b+c;window.ActiveXObject?request=new ActiveXObject("Microsoft.XMLHTTP"):window.XMLHttpRequest&&(request=new XMLHttpRequest);request.onreadystatechange=rspns;request.open("POST",b,!0);request.send()}
function rspns(){if(4===request.readyState){var b=request.responseText;if("b"===tprck)if("getcrs"===prvk)try{var a=b.split(",");document.getElementById("course_id").value=a[0];document.getElementById("course_name").value=a[1];document.getElementById("reg_price").value=a[2];document.getElementById("mth_price").value=a[3];document.getElementById("course_descr").value=a[4];document.getElementById("rd_crs").checked=!1;document.getElementById("course_id").disabled=!0;document.getElementById("course_name").disabled=
!0;document.getElementById("reg_price").disabled=!0;document.getElementById("mth_price").disabled=!0;document.getElementById("course_descr").disabled=!0;document.getElementById("btncoursei").disabled=!0}catch(c){}else if("getsubjecttoedit"===prvk)try{a=b.split(","),document.getElementById("subj_course_simester").value=a[4],document.getElementById("subj_course_level").value=a[3],document.getElementById("subj_subject_name").value=a[1],document.getElementById("subj_subject_desc").value=a[2],document.getElementById("subj_subject_id").value=
a[0],document.getElementById("subj_course_level").disabled=!0,document.getElementById("subj_subject_name").disabled=!0,document.getElementById("subj_subject_desc").disabled=!0,document.getElementById("subj_subject_id").disabled=!0,document.getElementById("subj_course_simester").disabled=!0,document.getElementById("btnsubjecti").disabled=!0,document.getElementById("btnsubjecte").disabled=!1}catch(c){}else document.getElementById("dvcs").innerHTML=b;else"unlckscrn"===tprck?"yes"===b.replace(/\s+/g,
"")?unlockscreenfnt(unloakbtn):alert(wrong_credentials):document.getElementById("dvrst").innerHTML=b;if("unlckscrn"!==tprck)try{document.getElementById("dvprcssr").style.display="none"}catch(c){}}}
function coursedata(){var b=document.getElementById("course_id").value,a=document.getElementById("course_name").value,c=document.getElementById("reg_price").value,d=document.getElementById("mth_price").value,e=document.getElementById("course_descr").value;return"&courseid="+b+"&coursename="+a+"&regprice="+c+"&mthprice="+d+"&coursedescr="+e}
function subjectdata(){var b=document.getElementById("course_id").value,a=document.getElementById("subj_subject_id").value,c=document.getElementById("subj_course_simester").value,d=document.getElementById("subj_course_level").value,e=document.getElementById("subj_subject_name").value,f=document.getElementById("subj_subject_desc").value;return"&courseid="+b+"&subj_subject_id="+a+"&subj_course_simester="+c+"&subj_course_level="+d+"&subj_subject_name="+e+"&subject_descr="+f}
function checkcourse(){document.getElementById("rd_sbjct").checked=!1;document.getElementById("course_id").disabled=!1;document.getElementById("course_name").disabled=!1;document.getElementById("reg_price").disabled=!1;document.getElementById("mth_price").disabled=!1;document.getElementById("course_descr").disabled=!1;document.getElementById("btncoursei").disabled=!1;document.getElementById("btncoursee").disabled=!1;document.getElementById("seach_course_name").disabled=!1;document.getElementById("subj_course_simester").disabled=
!0;document.getElementById("subj_course_level").disabled=!0;document.getElementById("subj_subject_name").disabled=!0;document.getElementById("subj_subject_id").disabled=!0;document.getElementById("subj_subject_desc").disabled=!0;document.getElementById("btnsubjecti").disabled=!0;document.getElementById("btnsubjecte").disabled=!0}
function checksubject(){document.getElementById("rd_crs").checked=!1;document.getElementById("course_id").disabled=!0;document.getElementById("course_name").disabled=!0;document.getElementById("reg_price").disabled=!0;document.getElementById("mth_price").disabled=!0;document.getElementById("course_descr").disabled=!0;document.getElementById("btncoursei").disabled=!0;document.getElementById("btncoursee").disabled=!0;document.getElementById("seach_course_name").disabled=!0;document.getElementById("subj_course_simester").disabled=
!1;document.getElementById("subj_course_level").disabled=!1;document.getElementById("subj_subject_name").disabled=!1;document.getElementById("subj_subject_desc").disabled=!1;document.getElementById("subj_subject_id").disabled=!1;document.getElementById("btnsubjecti").disabled=!1;document.getElementById("btnsubjecte").disabled=!1}
function dsblcrsatrib(){document.getElementById("course_name").disabled=!1;document.getElementById("reg_price").disabled=!1;document.getElementById("mth_price").disabled=!1;document.getElementById("subj_subject_id").disabled=!1;document.getElementById("course_descr").disabled=!1;document.getElementById("btncoursei").disabled=!1}crtsbjct="a";function getSubjects(b){crtsbjct=b;processar("getsubjecttoedit","b")}function currentsubject(){return"&sbjt="+crtsbjct}
function lockscreenfnt(b){try{document.getElementById("dvprcssr").style.display="block"}catch(a){}try{document.getElementById("closeprocessstatus").innerHTML=""+b+" "+passwordunlk+"<input type='password' id='passwrdunlkscrn' style = 'width: 120px;'/><a href='#' onclick=\"processar('unlckscrn','unlckscrn')\">"+unloakmsg+"</a>"}catch(a){}}
function unlockscreenfnt(b){try{document.getElementById("closeprocessstatus").innerHTML=b}catch(a){}try{document.getElementById("dvprcssr").style.display="none"}catch(a){}};


        </script>
        <style>
            #tblcs {
                border: 1px solid black;
                border-collapse: collapse;
            }
            select {
                outline: 0;
                border-width: 0 0 2px;
                border-color: blue
            }
            select:focus {
                border-color: green
            }
            input[type=date] {
                outline: 0;
                border-width: 0 0 2px;
                border-color: blue
            }
            input[type=date]:focus {
                border-color: green
            }
            input[type=text] {
                outline: 0;
                border-width: 0 0 2px;
                border-color: blue
            }
            input[type=text]:focus {
                border-color: green
            }
            input[type=number] {
                outline: 0;
                border-width: 0 0 2px;
                border-color: blue
            }
            input[type=password] {
                outline: 0;
                border-width: 0 0 2px;
                border-color: blue;
            }
            input[type=number]:focus {
                border-color: green;
            }
            input[type=password]:focus { 
                border-color: green;
            }
        </style>
    </head>
    <body oncontextmenu="return false" style="display: none;">
        <%@page session="true" import="a.*" %>
        <div style = "background-image: linear-gradient(#5499C7, white, #5499C7);"><img src="<%=cssn.getOrgInf()[1]%>" alt= "Logo" style="width: 140px; height: 70px;"/><strong><span id="title_of_proj" style="padding: 10px; font-size: 32px;">Sistema de Gest&atilde;o Escolar</span></strong><div style="float: right;font-size: 12px; padding-right: 6px;">Lingua: <select disabled="disabled"><option value="Portugues">Portugues</option> <option value="Ingles">Ingles</option> </select>
        <a href="#" onclick="lockscreenfnt('<%=lang.lng(current_lang, "lockscreen_message")%>')" title="<%=lang.lng(current_lang, "lockscreen")%>"><%=lang.lng(current_lang, "lockscreen")%></a>        
        Usu&aacute;rio: <span style="color: blue;"><%=""%></span><a href="/SM/s?t=3" style="text-decoration: none; color: grey;"><img src="img/close.png" style="width: 32px; height: 32px;" title="Sair"></a></div></div><br>
        <div class="divtbs" id="dvrst" style="width: 100%;"></div>
        <div style="width: 100%;">
            <a href="s?t=1"><img src="img/menu.png" style="float: right; width: 40px; height: 26px;"/></a>
        </div>
        <div>
            <table>
                <tr>
                    <td>
                        <table>
                            <tr>
                                <td></td><td></td><td colspan="2" style="background-color: #D4E6F1;"><%=lang.lng(current_lang, "search_course")%>:<input id="seach_course_name" type="text" list='lst_crs' onchange="processar('getcrs', 'b')"></td>
                            </tr>
                            <tr>
                                <td><input type="radio" id="rd_crs" name="rd_crs" value="Curso" onclick="checkcourse()"><label for="rd_crs" style="font-weight: bold;"><%=lang.lng(current_lang, "course")%></label></td>
                                <td><%=lang.lng(current_lang, "course_id")%>:</td><td><input type="text" id="course_id"></td><td><%=lang.lng(current_lang, "name_course")%>:</td>
                                <td><input type="text" id="course_name"></td>
                                <td><%=lang.lng(current_lang, "description")%>:</td>
                                <td><input type="text" id="course_descr"></td>   
                            </tr>

                            <tr>
                                <td></td><td><%=lang.lng(current_lang, "registration_value")%>:</td><td><input type="text" id="reg_price"></td>
                                <td><%=lang.lng(current_lang, "monthly_fee_amount")%>:</td><td><input type="text" id="mth_price"></td>
                                <td></td>    
                                <td>
                                    <%=vls.dinmcbtn(lang.lng(current_lang, "insert"), "processar('course', 'coursei')", "img/insertp4.png", "", "float: left;")%>
                                    <%=vls.dinmcbtn(lang.lng(current_lang, "edit"), "dsblcrsatrib()", "img/editp.png", "", "float: right;")%>
                                </td>
                            </tr>
                            <tr>
                                <td style="height: 14px;"></td>
                            </tr>             
                            <tr>
                                <td><input type="radio" id="rd_sbjct" name="rd_sbjct" value="Cadeira" onclick="checksubject()"><label for="rd_sbjct" style="font-weight: bold;">Cadeiras</label></td>
                                <td><%=lang.lng(current_lang, "subject_id")%>:</td>
                                <td><input id="subj_subject_id" type="text"></td><td><%=lang.lng(current_lang, "subject")%>:</td>
                                <td><input id="subj_subject_name" type="text"></td>
                            </tr>
                            <tr>
                                <td></td><td><%=lang.lng(current_lang, "desc_of_subject")%>:</td>
                                <td><input id="subj_subject_desc" type="text"></td><td><%=lang.lng(current_lang, "semester")%>:</td>
                                <td>
                                    <input id="subj_course_simester" min="1" max="6" style="width: 50px;">
                                </td>
                                <td><%=lang.lng(current_lang, "level")%>:<input id="subj_course_level" min="1" max="6" style="width: 50px;">
                                </td>
                                <td colspan="3">
                                    <%=vls.dinmcbtn(lang.lng(current_lang, "insert"), "processar('subject', 'subjecti')", "img/insertp4.png", "", "float: left;")%>
                                    <%=vls.dinmcbtn(lang.lng(current_lang, "edit"), "processar('subject', 'subjecte')", "img/editp.png", "", "float: right;")%>
                                </td>
                            </tr>
                            <tr>
                                <td style="height: 6px;"></td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <table>
                                        <tr>
                                            <td>
                                                <%=lang.lng(current_lang, "list")%><br><%=lang.lng(current_lang, "course")%>
                                            </td>
                                            <td>
                                                <%=vls.dinmcbtn(lang.lng(current_lang, "insert"), "processar('course', 'b')", "img/reports2.png", "", "float: right;")%>
                                            </td>                                            
                                        </tr>
                                    </table> 
                                </td>
                                <td colspan="2">                                    
                                    <table>
                                        <tr>
                                            <td>
                                               <%=lang.lng(current_lang, "list")%><br><%=lang.lng(current_lang, "subjects")%> 
                                            </td>
                                            <td>
                                                <%=vls.dinmcbtn(lang.lng(current_lang, "insert"), "processar('subject', 'b')", "img/reports2.png", "", "float: right;")%>
                                            </td>                                            
                                        </tr>
                                    </table>                                     
                                </td>
                            </tr>

                        </table>
                    </td>
                </tr>
            </table>
            <br>
            <div id="dvcs" style="width: 80%; height: 260px; background-color: #EAF2F8;">            
                <table id="tblcs" border="1" style="width: 100%;">
                    <tr style="height: 46px; background-color:  #9B00FF;background: linear-gradient(to bottom, #9B00FF, white);">
                        <th style="width: 400px;"><%=lang.lng(current_lang, "item")%> 1</th><th style="width: 400px;"><%=lang.lng(current_lang, "item")%> 2</th>
                    </tr>
                    <!--<tr>
                        <td></td><td></td><td></td>
                    </tr>-->
                </table>
            </div>
            <br>
            <a href="/SM/s?t=1" style="text-decoration: none;">&lt;&lt; <%=lang.lng(current_lang, "come_back")%></a>
        </div>
        <div style="position: fixed; bottom: 2px; right: 2px; background-color: #E67E22; color: white;">
            <span style="color: blue;">Powered by: </span><a href="amoraservices.org" style="text-decoration: none; color: white;"><strong>Amora</strong> Software & Services</a>
        </div>              
        <div style="position: fixed; bottom: 2px; right: 2px;">
            <span style="font-size: 12px; background-color: white; color: black; padding-right: 10px;"><%=lang.lng(current_lang, "version")%>: <%=cssn.versionapp()%></span><span style="color: blue; background-color: #E67E22;">Powered by: </span><a href="amoraservices.org" style="text-decoration: none; color: white; background-color: #E67E22; color: white;"><strong>Amora</strong> Software & Services</a>
        </div>
        <div id="dvprcssr" style="position: absolute; top: 0px; left: 0px; display: none; z-index: 100; width: 100%; height: 100%; background-color: #EBF5FB; text-align: center;">
            <span id="closeprocessstatus" style="position: absolute; top: 46%;"><%=lang.lng(current_lang, "processing...")%></span>
        </div>
        <datalist id='lst_crs'>
            <option></option>
            <%=vls.courseslst()%>
        </datalist> 
        <script>
            window.onload = function () {
                document.body.style.display = "block";
            };    
        </script>        
       <%
        if (dsbld4.equalsIgnoreCase("disabled")) {
                try{
                    session.invalidate(); 
                } catch (Exception e) {}        
        }
        } else {
        %>
        <script>
            location.replace("Login.jsp?er=y");
        </script>    
        <%
            }
        %>    
    </body>
</html>
