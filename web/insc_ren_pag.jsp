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
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>SM</title>
        <link rel="icon" href="img/amora.png" type="image/x-icon" sizes="32x32">
        <link rel="icon" type="image/x-icon" href="img/amoraicon.ico" >
        <script>

        </script>   
        <%
            String scrsz = request.getParameter("scrsz");
            SM_Session_Validation ss_vld = new SM_Session_Validation(scrsz);
            String logo = "";
            SM_Values vls = new SM_Values();
            String dsbld4 = ss_vld.getDsbld4();
            String sky = ss_vld.getSky();
            String sky2 = ss_vld.getSky2();
            if (dsbld4.equalsIgnoreCase("disabled") && !sky.contains("green")) {
        %>
        <meta http-equiv = "refresh" content = "10; url=Page2.jsp?z=<%=sky2%>"/>
        <%
            }
        %>
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
            var request;
            var tbl_sbjts = "";
            var sbjtsits = [];
            var gk = 0;
            var gk_str = "";
            var gsector = "";
            var gusrlgn = "<%=Lb.getUser()%>";
            var enrolled_stdnt_id = "";
            var enrolled_stdnt_crc_yr = "";
            var enrolled_stdnt_smstr = "";
            var ctyp = "";
            var confirm_with_ok_to_continue_or_cancel_to_cancel = "<%=lang.lng(current_lang, "confirm_with_ok_to_continue_or_cancel_to_cancel")%>";
            var do_you_want_to_associate_with_a_customer = "<%=lang.lng(current_lang, "do_you_want_to_associate_with_a_customer")%>";
            var unloakbtn = "<%=lang.lng(current_lang, "processing...")%>";
            var unloakmsg = "<%=lang.lng(current_lang, "unloakmsg")%>";
            var passwordunlk = "<%=lang.lng(current_lang, "password")%>";
            var wrong_credentials = "<%=lang.lng(current_lang, "wrong_credentials")%>";
            var newpageloginagain = "<%=lang.lng(current_lang, "newpageloginagain")%>";             

function processar(a,b){try{document.getElementById("dvprcssr").style.display="block"}catch(c){}if("b"===b||"studentprofile"===b||"subject_c"===b||"unlckscrn"===b)processarb(a,b);else if(confirm("Confirma com OK para continuar ou CANCEL para cancelar"))processarb(a,b);else try{document.getElementById("dvprcssr").style.display="none"}catch(c){}}
function processarb(a,b){tprck=b;prvk=a;var c="";if("enrollstdnt"===a||"enrollstdnt"===b)c=studentsdata();else if("subjects_list"===a||"subjects_list"===b){c=document.getElementById("course_level").value;var g=document.getElementById("course_simest").value,f=document.getElementById("mth_price").value,d=document.getElementById("reg_price").value,e=document.getElementById("course_type").value;enrolled_stdnt_crc_yr=""+c;enrolled_stdnt_smstr=""+g;ctyp=""+e;c="&stdid="+enrolled_stdnt_id+":"+c+":"+g+"&sbjts="+
subjects_list()+"&mthpymt="+f+"&enrollpymnt="+d+"&ctyp="+ctyp}else"b"===b?"getcrs"===a?c="&c="+document.getElementById("seach_course_name").value:"studentprofile"===a?c="&c="+document.getElementById("student_id").value:"subject_c"===a?c="&cc="+document.getElementById("course_id").value:"other_subject"===a&&(c="&cc="+document.getElementById("course_id").value):"unlckscrn"===a&"unlckscrn"===b&&(c="&s="+document.getElementById("passwrdunlkscrn").value);a="s?t=2&di=&df=&cc="+document.getElementById("course_id").value+
"&user="+gusrlgn+"&acao="+b+"&prv="+a+c;window.ActiveXObject?request=new ActiveXObject("Microsoft.XMLHTTP"):window.XMLHttpRequest&&(request=new XMLHttpRequest);request.onreadystatechange=rspns;request.open("POST",a,!0);request.send()}
function rspns(){if(4===request.readyState){var a=request.responseText;if("b"===tprck)if("studentprofile"===prvk){try{var b=a.split(","),c=b[5];c=c.split(" ")[0];var g=b[11];g=g.split(" ")[0];document.getElementById("enroll_type").value=b[0];document.getElementById("student_id").value=b[1];document.getElementById("student_name").value=b[2];document.getElementById("stundent_surname").value=b[3];document.getElementById("course_id").value=b[4];document.getElementById("birth_date").value=c;document.getElementById("residence").value=
b[6];document.getElementById("phone_1").value=b[7];document.getElementById("phone_2").value=b[8];document.getElementById("email").value=b[9];document.getElementById("course_level").value=b[10];document.getElementById("enroll_date").value=g;var f=b[12],d="";"1"===f?d="Primeiro":"2"===f&&(d="Segundo");document.getElementById("course_simest").value=d;document.getElementById("student_id").disabled=!0;document.getElementById("student_name").disabled=!0;document.getElementById("stundent_surname").disabled=
!0;document.getElementById("birth_date").disabled=!0;document.getElementById("residence").disabled=!0;document.getElementById("phone_1").disabled=!0;document.getElementById("phone_2").disabled=!0;document.getElementById("email").disabled=!0;document.getElementById("enroll_date").disabled=!0;document.getElementById("btnenroll").disabled=!0}catch(h){}setTimeout(function(){processar("subject_c","b")},500)}else if("subject_c"===prvk){b=f="";a=a.split(",");c=document.getElementById("subject");try{for(d=
0;40>=d;d++){var e=a[d];if(null!==e&&"undefined"!==typeof e&&""!==e&&"undefined"!==e){var l=e.split(":");0===d&&(f=""+l[0],b=""+l[1]);var k=document.createElement("option");k.text=""+l[2];c.add(k)}}}catch(h){}document.getElementById("reg_price").value=f;document.getElementById("mth_price").value=b}else if("other_subject"===prvk){a=a.split(",");c=document.getElementById("other_subject");try{for(d=0;40>=d;d++)e=a[d],null!==e&&"undefined"!==typeof e&&""!==e&&"undefined"!==e&&(k=document.createElement("option"),
k.text=""+e,c.add(k))}catch(h){}}else document.getElementById("dvcs").innerHTML=a;else if("enrollstdnt"===prvk){try{document.getElementById("btnenroll").disabled=!0}catch(h){}try{document.getElementById("btnaddsubjct").disabled=!1}catch(h){}try{document.getElementById("addothersubjct").disabled=!1}catch(h){}enrolled_stdnt_id=a;a=a.includes("not_autorized")?"<div style='color: green;'>As inscricoes/renovacoes nao foram autorizdas para este periodo!</div>":a.startsWith("erro:")?"<div style='color: red;'>"+
a+"</div>":"<div style='color: green;'>Inserido com sucesso!</div>";document.getElementById("dvrst").innerHTML=a}else"subjects_list"===prvk?impestrcpt(""+enrolled_stdnt_id):"unlckscrn"===tprck?"yes"===a.replace(/\s+/g,"")?unlockscreenfnt(unloakbtn):alert(wrong_credentials):document.getElementById("dvrst").innerHTML=a;if("unlckscrn"!==tprck)try{document.getElementById("dvprcssr").style.display="none"}catch(h){}}}
function studentsdata(){var a=document.getElementById("enroll_type").value,b=document.getElementById("student_id").value,c=document.getElementById("student_name").value,g=document.getElementById("stundent_surname").value,f=document.getElementById("course_id").value,d=document.getElementById("birth_date").value,e=document.getElementById("residence").value,l=document.getElementById("phone_1").value,k=document.getElementById("phone_2").value,h=document.getElementById("email").value,m=document.getElementById("course_level").value,
n=document.getElementById("enroll_date").value,p=document.getElementById("course_simest").value,q=document.getElementById("course_type").value;return"&enroll_type="+a+"&student_id="+b+"&student_name="+c+"&stundent_surname="+g+"&course_id="+f+"&birth_date="+d+"&residence="+e+"&phone_1="+l+"&phone_2="+k+"&email="+h+"&course_level="+m+"&enroll_date="+n+"&course_simest="+p+"&course_type="+q}
function disableAllBtn(){try{document.getElementById("btnenroll").disabled=!0}catch(a){}try{document.getElementById("btnfinalizeenrnl").disabled=!0}catch(a){}try{document.getElementById("btnaddsubjct").disabled=!0}catch(a){}try{document.getElementById("addothersubjct").disabled=!0}catch(a){}}function unblockbtnenrl(){try{document.getElementById("btnenroll").disabled=!1}catch(a){}}
function rfrsh_sbjts(){tbl_sbjts="<table border='1' id='tbdvrv'><tr style='height: 46px; background-color:  #9B00FF;background: linear-gradient(to bottom, #9B00FF, white);'><th>Ordem</th><th>Cadeira</th></tr>";sbjtsits.forEach(rfshtbl);tbl_sbjts+="</table>";document.getElementById("tblcs").innerHTML=tbl_sbjts}function rfshtbl(a,b,c){if("NA"!==a){a=a.replace(":","");b="<td>"+b+"</td>";a=a.split(",");for(c=1;c<a.length;c++)b+="<td>"+a[c]+"</td>";tbl_sbjts+="<tr>"+b+"</tr>"}}
function addSubject(a){gk+=1;gk_str.includes(a)?alert("Ja adicionou esta cadeira!"):(gk_str=gk_str+","+a,sbjtsits[gk]=""+gk+","+a,rfrsh_sbjts());try{document.getElementById("btnfinalizeenrnl").disabled=!1}catch(b){}}function subjects_list(){var a="";try{for(var b=0;40>=b;b++)a+=""+sbjtsits[b]+":"}catch(c){}return a}
function impestrcpt(a){window.open("enrollment_report.jsp?cod="+a+"&user="+gusrlgn+"&lvl="+enrolled_stdnt_crc_yr+"&smts="+enrolled_stdnt_smstr+"&ctyp="+ctyp,"popUpWindow","height=600,width=600,left=10,top=10,,scrollbars=yes,menubar=no");return!1}
function new_record(){try{document.getElementById("student_id").value="",document.getElementById("student_name").value="",document.getElementById("stundent_surname").value="",document.getElementById("course_id").value="",document.getElementById("birth_date").value="",document.getElementById("residence").value="",document.getElementById("phone_1").value="",document.getElementById("phone_2").value="",document.getElementById("email").value="",document.getElementById("course_level").value="",document.getElementById("enroll_date").value=
"",document.getElementById("course_simest").value="",document.getElementById("course_type").value="DiurnoNoturno",document.getElementById("enroll_type").value=""}catch(a){}try{document.getElementById("student_id").disabled=!1,document.getElementById("student_name").disabled=!1,document.getElementById("stundent_surname").disabled=!1,document.getElementById("birth_date").disabled=!1,document.getElementById("residence").disabled=!1,document.getElementById("phone_1").disabled=!1,document.getElementById("phone_2").disabled=
!1,document.getElementById("email").disabled=!1,document.getElementById("enroll_date").disabled=!1,document.getElementById("btnenroll").disabled=!1,document.getElementById("course_level").disabled=!1,document.getElementById("enroll_date").disabled=!1,document.getElementById("course_simest").disabled=!1,document.getElementById("course_type").disabled=!1,document.getElementById("enroll_type").disabled=!1}catch(a){}}
function lockscreenfnt(a){try{document.getElementById("dvprcssr").style.display="block"}catch(b){}try{document.getElementById("closeprocessstatus").innerHTML=""+a+" "+passwordunlk+"<input type='password' id='passwrdunlkscrn' style = 'width: 120px;'/><a href='#' onclick=\"processar('unlckscrn','unlckscrn')\">"+unloakmsg+"</a>"}catch(b){}}
function unlockscreenfnt(a){try{document.getElementById("closeprocessstatus").innerHTML=a}catch(b){}try{document.getElementById("dvprcssr").style.display="none"}catch(b){}};


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
            <button onclick="new_record()"><%=lang.lng(current_lang, "new_registration")%></button><br>
            <table>
                <tr>
                    <td>
                        <table>
                            <tr>
                                <td><%=lang.lng(current_lang, "student_code")%>:</td><td><input type="text" id="student_id"></td>

                                <td><%=lang.lng(current_lang, "birth_date")%></td><td><input type="date" id="birth_date"></td>
                            </tr>
                            <tr>
                                <td><%=lang.lng(current_lang, "registration_and_renewal")%>:</td><td>
                                    <select type="text" id="enroll_type" onchange="unblockbtnenrl()">
                                        <option value=""></option>
                                        <option value="Inscricao"><%=lang.lng(current_lang, "enrollment")%></option>
                                        <option value="Renovacao"><%=lang.lng(current_lang, "renovation")%></option>
                                        <option value="Cancelamento"><%=lang.lng(current_lang, "cancellation")%></option>
                                    </select>

                                </td>
                                <td><%=lang.lng(current_lang, "place_of_residence")%>:</td><td><input type="text" id="residence"></td>
                            </tr>
                            <tr>
                                <td><%=lang.lng(current_lang, "name")%>:</td><td><input type="text" id="student_name"></td>
                                <td><%=lang.lng(current_lang, "telephone")%> 1:</td><td><input type="number" id="phone_1"></td>
                            </tr>
                            <tr>
                                <td><%=lang.lng(current_lang, "surname")%>:</td><td><input type="text" id="stundent_surname"></td>
                                <td><%=lang.lng(current_lang, "telephone")%> 2:</td><td><input type="number" id="phone_2"></td>
                            </tr>
                            <tr>
                                <td><%=lang.lng(current_lang, "registration_date")%>:</td><td><input type="date" id="enroll_date"></td>
                                <td>Email:</td><td><input type="text" id="email"></td>
                            </tr>
                            <tr>
                                <td><%=lang.lng(current_lang, "course")%>:</td><td>
                                    <input type="text" id="course_id"  list='lst_courses' onchange="processar('subject_c', 'b')" >
                                </td>
                                <td><%=lang.lng(current_lang, "semester")%>:</td><td>
                                    <select type="text" id="course_simest">
                                        <option value=""></option>
                                        <option value="Primeiro"><%=lang.lng(current_lang, "first")%></option>
                                        <option value="Segundo"><%=lang.lng(current_lang, "second")%></option>
                                    </select>
                                    <select type="text" id="course_type" style="padding-left: 12px;">
                                        <option value="DiurnoNoturno"><%=lang.lng(current_lang, "daytime")%>/<%=lang.lng(current_lang, "nocturnal")%></option>
                                        <option value="Diurno"><%=lang.lng(current_lang, "daytime")%></option>
                                        <option value="Noturno"><%=lang.lng(current_lang, "nocturnal")%></option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td><%=lang.lng(current_lang, "year")%>:</td>
                                <td><input type="number" id='course_level' min='1' max='5'></td>
                                <td style="background-color: #D7DBDD;"><%=lang.lng(current_lang, "subjects")%>:</td>
                                <td style="background-color: #D7DBDD;">
                                    <select id="subject" style="width: 100%;">
                                        <option></option>
                                    </select>
                                </td>
                                <td style="background-color: #D7DBDD;">
                                    <!--<button id="btnaddsubjct" onclick="addSubject(document.getElementById('subject').value)">Adicionar</button>-->
                                    <%=vls.dinmcbtn(lang.lng(current_lang, "insert"), "addSubject(document.getElementById('subject').value)", "img/insertp.png", "", "float: right;")%>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td style="width: 100px;">

                    </td>
                    <td>
                        <table style="float: top; padding: 20px; background-color: #ABEBC6;">
                            <tr>
                                <td><%=lang.lng(current_lang, "registration_value")%></td><td><input type="text" id="reg_price"></td>
                            </tr>
                            <tr>
                                <td><%=lang.lng(current_lang, "monthly_value")%></td><td><input type="text" id="mth_price"></td>
                            </tr>
                            <!--<tr>
                                <td>Inscricao</td><td><input type="text" id=""></td>
                            </tr>-->
                        </table><br>
                        <div>
                            <%=lang.lng(current_lang, "other_subjects")%>:  
                            <select id="other_subject">
                                <option></option>
                            </select>
                            <button onclick="processar('other_subject', 'b')"><%=lang.lng(current_lang, "list")%></button>
                            <br><br>
                            <table>
                                <tr>
                                    <td><%=lang.lng(current_lang, "add_other_subjects")%> <br>(ex: <%=lang.lng(current_lang, "delayed_subjects")%>)</td>
                                    <td>
                                        <%=vls.dinmcbtn(lang.lng(current_lang, "register"), "addSubject(document.getElementById('other_subject').value)", "img/insertp.png", "", "float: right;")%>
                                        <!--<button id="addothersubjct" onclick="addSubject(document.getElementById('other_subject').value)">Adicionar outras cadeiras (ex: Cadeiras atrasadas)</button>-->
                                    </td>
                                </tr>
                            </table>   
                        </div>
                    </td>
                </tr>
            </table>
            <table>
                <td>
                    <table>
                        <tr>
                            <td>Registar</td>
                            <td>
                                <!--<button id='btnenroll' onclick="processar('enrollstdnt', 'enrollstdnt')">Registar</button>-->
                                <%=vls.dinmcbtn(lang.lng(current_lang, "register"), "processar('enrollstdnt', 'enrollstdnt')", "img/insertptb.png", "", "float: right;")%>
                            </td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table>
                        <tr>
                            <td><%=lang.lng(current_lang, "finalize_and")%><br><%=lang.lng(current_lang, "enrollment")%></td>
                            <td>
                                <%=vls.dinmcbtn(lang.lng(current_lang, "insert"), "processar('subjects_list', 'subjects_list')", "img/insertp4.png", "", "float: right;")%>
                            </td>
                        </tr>
                    </table>
                    <!--<button id="btnfinalizeenrnl" onclick="processar('subjects_list', 'subjects_list')">Finalizar e Inscricao</button>-->                    
                </td>
            </table><br>
            <strong><%=lang.lng(current_lang, "subjects")%></strong><br>
            <div style="width: 80%; height: 260px; background-color: #EAF2F8;">            
                <table id="tblcs" border="1">
                    <tr style="height: 46px; background-color:  #9B00FF;background: linear-gradient(to bottom, #9B00FF, white);">
                        <th><%=lang.lng(current_lang, "nr")%></th><th><%=lang.lng(current_lang, "subject")%></th><th><%=lang.lng(current_lang, "description")%></th>
                    </tr>
                    <!--<tr>
                        <td></td><td></td><td></td>
                    </tr>-->
                </table>
            </div>
            <!--<br>
            <a href="/SM/s?t=1" style="text-decoration: none;">&lt;&lt; Voltar</a>-->
        </div>
        <div style="position: fixed; bottom: 2px; right: 2px; background-color: #E67E22; color: white;">
            <span style="color: blue;">Powered by: </span><a href="http://www.amoraservices.org/" style="text-decoration: none; color: white;"><strong>Amora</strong> Software & Services</a>
        </div>              
        <div style="position: fixed; bottom: 2px; right: 2px;">
            <span style="font-size: 12px; background-color: white; color: black; padding-right: 10px;"><%=lang.lng(current_lang, "version")%>: <%=cssn.versionapp()%></span><span style="color: blue; background-color: #E67E22;">Powered by: </span><a href="amoraservices.org" style="text-decoration: none; color: white; background-color: #E67E22; color: white;"><strong>Amora</strong> Software & Services</a>
        </div> 
        <div id="dvprcssr" style="position: absolute; top: 0px; left: 0px; display: none; z-index: 100; width: 100%; height: 100%; background-color: #EBF5FB; text-align: center;">
            <span id="closeprocessstatus" style="position: absolute; top: 46%;"><%=lang.lng(current_lang, "processing...")%></span>
        </div> 
        <datalist id='lst_courses'>
            <option>NA</option>
            <%=vls.courseslst()%>
        </datalist> 
        <script>

var stdntidk=document.getElementById("student_id");stdntidk.addEventListener("keyup",function(a){13===a.keyCode&&(a.preventDefault(),processar("studentprofile","b"))});document.getElementById("reg_price").disabled=!0;document.getElementById("mth_price").disabled=!0;disableAllBtn();window.onload=function(){document.body.style.display="block"};
    
    
        </script> 
        <%
            if (dsbld4.equalsIgnoreCase("disabled")) {
                try {
                    session.invalidate();
                } catch (Exception e) {
                }
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
