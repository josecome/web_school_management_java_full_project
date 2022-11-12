<%-- 
    Document   : insc_ren_pag
    Created on : Jan 8, 2022, 10:48:19 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true" import="a.*" %> 
<!DOCTYPE html>
<%
    String logo = "";
    SM_Values vls = new SM_Values();
    SM_get_lng_file glng = new SM_get_lng_file();
    SM_language lang = new SM_language(glng.getlngs());
    SM_client_session cssn = new SM_client_session();
    SM_PreferedLang plng = new SM_PreferedLang();
    String current_lang = plng.getPreferedLang();
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
            var tprck = "z";
            var prvk = "z";
            var gusrlgn = "<%=Lb.getUser()%>";
            var rf = "";
            var confirm_with_ok_to_continue_or_cancel_to_cancel = "<%=lang.lng(current_lang, "confirm_with_ok_to_continue_or_cancel_to_cancel")%>";
            var do_you_want_to_associate_with_a_customer = "<%=lang.lng(current_lang, "do_you_want_to_associate_with_a_customer")%>";
            var unloakbtn = "<%=lang.lng(current_lang, "processing...")%>";
            var unloakmsg = "<%=lang.lng(current_lang, "unloakmsg")%>";
            var passwordunlk = "<%=lang.lng(current_lang, "password")%>";
            var wrong_credentials = "<%=lang.lng(current_lang, "wrong_credentials")%>";
            var newpageloginagain = "<%=lang.lng(current_lang, "newpageloginagain")%>"; 
            var request;            

function processar(a,b){try{document.getElementById("dvprcssr").style.display="block"}catch(c){}if("b"===b||"studentprofile_mth"===b||"unlckscrn"===b)processarb(a,b);else if(confirm("Confirma com OK para continuar ou CANCEL para cancelar"))processarb(a,b);else try{document.getElementById("dvprcssr").style.display="none"}catch(c){}}
function processarb(a,b){tprck=b;prvk=a;var c="";if("b"===b)if("studentprofile_mth"===a)c="&c="+document.getElementById("student_id").value;else if("ref_cod"===a){c=document.getElementById("pymntinf").value;if(null===c||"0"===c||0===c.trim().length)return!1;c="&stdntid="+document.getElementById("student_id").value+"&c="+c}else if("lists"===a){c=document.getElementById("student_id").value;if(null===c||""===c||0===c.trim().length)return alert("Sem dados de estudante!"),!1;c="&tp=ind&dc="+document.getElementById("talref").value+
"&c="+document.getElementById("txttalref").value+"&stdntid="+c}else"confirmdepnmr"===a&&(c="&c="+document.getElementById("deposit_nr").value);else if("pymnt_inf"===a)c="&c="+document.getElementById("pymntinf").value+"&depositnr="+document.getElementById("deposit_nr").value+"&bnkname="+document.getElementById("bnk_accnt").value,rf=document.getElementById("pymntinf").value;else if("pymnt_inf_special"===a){try{var d=new Date,g=""+d.getSeconds(),h=""+d.getMinutes(),e=""+d.getHours(),k=""+d.getDate();
rf="WREF"+d.getFullYear()+k+e+h+g}catch(f){}c="&stdntid="+document.getElementById("student_id").value+"&amountpaid="+document.getElementById("amountpaid").value+"&bnkname="+document.getElementById("bnk_accnt").value+"&depositnr="+document.getElementById("deposit_nr").value+"&ref="+rf}else"unlckscrn"===a&"unlckscrn"===b&&(c="&s="+document.getElementById("passwrdunlkscrn").value);a="s?t=2&di=&df=&cc="+document.getElementById("course_id").value+"&user="+gusrlgn+"&acao="+b+"&prv="+a+c;window.ActiveXObject?
request=new ActiveXObject("Microsoft.XMLHTTP"):window.XMLHttpRequest&&(request=new XMLHttpRequest);request.onreadystatechange=rspns;request.open("POST",a,!0);request.send()}
function rspns(){if(4===request.readyState){var a=request.responseText;if("b"===tprck)if("studentprofile_mth"===prvk)try{var b=a.split(",");document.getElementById("student_id").value=b[1];document.getElementById("student_name").value=b[2];document.getElementById("stundent_surname").value=b[3];document.getElementById("course_id").value=b[4];document.getElementById("course_level").value=b[10];document.getElementById("student_id").disabled=!0;document.getElementById("student_name").disabled=!0;document.getElementById("stundent_surname").disabled=
!0;document.getElementById("course_id").disabled=!0;document.getElementById("course_level").disabled=!0}catch(c){}else if("ref_cod"===prvk)try{b=a.split(","),document.getElementById("amountpaid").value=b[0],document.getElementById("mth").value=b[1],document.getElementById("amountpaid").disabled=!0,document.getElementById("mth").disabled=!0,document.getElementById("pymntinf").disabled=!0}catch(c){}else"lists"===prvk?call_fill_tbl(a):"confirmdepnmr"===prvk?alert(a):document.getElementById("dvrst").innerHTML=
a;else"pymnt_inf"===prvk||"pymnt_inf_special"===prvk?(b=""+document.getElementById("student_id").value,a.includes("sucesso")&&imppag(b,rf)):"unlckscrn"===tprck?"yes"===a.replace(/\s+/g,"")?unlockscreenfnt(unloakbtn):alert(wrong_credentials):document.getElementById("dvrst").innerHTML=a;if("unlckscrn"!==tprck)try{document.getElementById("dvprcssr").style.display="none"}catch(c){}}}
function clnPymntFlds(){document.getElementById("amountpaid").value="";document.getElementById("mth").value="";document.getElementById("bnk_accnt").value="";document.getElementById("pymntinf").value="";document.getElementById("pymntinf").disabled=!1}
function call_fill_tbl(a){var b=0,c=0,d=0,g="<table id='tblcs' border='1' style='width: 100%;'>  <tr style='height: 46px; background-color:  #9B00FF;background: linear-gradient(to bottom, #9B00FF, white);'><th style='width: 16%;'>Ordem</th> <th style='width: 16%;'>Mes</th><th style='width: 16%;'>Referencia</th><th style='width: 16%;'>Talao</th><th style='width: 16%;'>Valor a Pagar</th><th style='width: 16%;'>Valor Pago</th></tr>";a=a.split("::");try{for(var h=0;h<a.length;h++){var e=a[h].split(","),
k="<tr>";try{for(var f=0;f<e.length-1;f++)k+="<td>"+e[f]+"</td>",4===f&&(b+=parseFloat(e[4]),"y"===e[6]&&(c+=parseFloat(e[4]))),5===f&&(d+=parseFloat(e[5]))}catch(l){}k+="<tr>";g+=k}}catch(l){}g+="</table>";c=d-c;e=d-b;document.getElementById("pymtstbl").innerHTML=""+g;document.getElementById("balancet").value=""+e;document.getElementById("balance").value=""+c;document.getElementById("debt").value=""+b;document.getElementById("paid").value=""+d}
function imppag(a,b){window.open("monthly_paymnt_report.jsp?cod="+a+"&rf="+b+"&user="+gusrlgn+"&lvl=0&smts=0&ctyp=0","popUpWindow","height=600,width=600,left=10,top=10,,scrollbars=yes,menubar=no");return!1}function implistpymnts(a){window.open("payments_list.jsp?cod="+a+"&user="+gusrlgn+"&lvl=0&smts=0&ctyp=0&t=stdnt","popUpWindow","height=600,width=600,left=10,top=10,,scrollbars=yes,menubar=no");return!1}
function new_record(){try{document.getElementById("student_id").value="",document.getElementById("student_name").value="",document.getElementById("stundent_surname").value="",document.getElementById("course_id").value="",document.getElementById("course_level").value="",document.getElementById("amountpaid").value="",document.getElementById("mth").value="",document.getElementById("pymntinf").value="",document.getElementById("bnk_accnt").value="",document.getElementById("deposit_nr").value="",document.getElementById("course_id").value=
""}catch(a){alert(a.message)}try{document.getElementById("student_id").disabled=!1,document.getElementById("student_name").disabled=!0,document.getElementById("stundent_surname").disabled=!0,document.getElementById("course_level").disabled=!0,document.getElementById("course_id").disabled=!0,document.getElementById("amountpaid").disabled=!1,document.getElementById("mth").disabled=!1,document.getElementById("pymntinf").disabled=!1,document.getElementById("bnk_accnt").disabled=!1,document.getElementById("deposit_nr").disabled=
!1}catch(a){alert(a.message)}document.getElementById("pymtstbl").innerHTML="<table id='tblcs' border='1' style='width: 100%;'>  <tr style='height: 46px; background-color:  #9B00FF;background: linear-gradient(to bottom, #9B00FF, white);'><th style='width: 16%;'>Ordem</th> <th style='width: 16%;'>Mes</th><th style='width: 16%;'>Referencia</th><th style='width: 16%;'>Talao</th><th style='width: 16%;'>Valor a Pagar</th><th style='width: 16%;'>Valor Pago</th></tr></table>";document.getElementById("balancet").value=
"";document.getElementById("balance").value="";document.getElementById("debt").value="";document.getElementById("paid").value=""}function lockscreenfnt(a){try{document.getElementById("dvprcssr").style.display="block"}catch(b){}try{document.getElementById("closeprocessstatus").innerHTML=""+a+" "+passwordunlk+"<input type='password' id='passwrdunlkscrn' style = 'width: 120px;'/><a href='#' onclick=\"processar('unlckscrn','unlckscrn')\">"+unloakmsg+"</a>"}catch(b){}}
function unlockscreenfnt(a){try{document.getElementById("closeprocessstatus").innerHTML=a}catch(b){}try{document.getElementById("dvprcssr").style.display="none"}catch(b){}};


        </script>   
        <style>
            #tblcs {
                border: 1px solid black;
                border-collapse: collapse;
            }
            table {
                border-collapse: collapse;
                text-align: center;
            }
            th, td {
                padding: 6px;                
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
                            </tr>
                            <tr>
                                <td><%=lang.lng(current_lang, "name")%>:</td><td><input type="text" id="student_name"></td>
                            </tr>
                            <tr>
                                <td><%=lang.lng(current_lang, "surname")%>:</td><td><input type="text" id="stundent_surname"></td>
                            </tr>
                            <tr>
                                <td><%=lang.lng(current_lang, "course")%>:</td><td><input type="text" id="course_id"></td>
                            </tr>
                            <tr>
                                <td><%=lang.lng(current_lang, "year")%>:</td><td><input type="text" id="course_level"></td>
                            </tr>
                            <tr>
                                <td><%=lang.lng(current_lang, "splint_nr")%>:</td><td><input type="text" id="deposit_nr"></td>
                                <td><button onclick="processar('confirmdepnmr', 'b')"><%=lang.lng(current_lang, "validate")%></button></td>
                            </tr>
                        </table>
                    </td>
                    <td style="width: 100px;">

                    </td>
                    <td>
                        <fieldset style="background-color: #ABEBC6;">
                            <legend><%=lang.lng(current_lang, "payments")%></legend>
                            <table style="float: top; padding: 20px;">
                                <tr>
                                    <td><%=lang.lng(current_lang, "value")%>:</td><td><input id="amountpaid" type="text"></td>
                                    <td style="width: 12px;"></td>
                                    <td><%=lang.lng(current_lang, "for_the_month")%>: </td><td><input type="text" id="mth"></td>
                                </tr>
                                <tr>
                                    <td><%=lang.lng(current_lang, "bank")%>:</td><td><input type="text" id="bnk_accnt"></td>
                                    <td style="width: 12px;"></td>
                                    <td>Ref.</td><td><input id="pymntinf" type="text" onblur = "processar('ref_cod', 'b')"></td>
                                </tr>
                                <tr>
                                    <td></td><td></td>
                                    <td style="width: 12px;"></td>
                                    <td></td><td><button onclick="processar('pymnt_inf', 'pymnt_inf')"><%=lang.lng(current_lang, "register_payment")%></button></td>
                                </tr>
                                <tr>
                                    <td></td><td><button onclick="clnPymntFlds()"><%=lang.lng(current_lang, "new")%></button></td>
                                    <td style="width: 12px;"></td>
                                    <td></td><td><button onclick="processar('pymnt_inf_special', 'pymnt_inf_special')"><%=lang.lng(current_lang, "special_payment")%></button></td>
                                </tr>
                            </table>
                        </fieldset>
                        <br>
                    </td>
                </tr>
            </table>
            <fieldset style="width: 1050px;">
                <legend><%=lang.lng(current_lang, "individual_statement")%></legend>    
                <table>
                    <tr>
                        <td>
                            <table>
                                <tr>
                                    <td><%=lang.lng(current_lang, "since")%>:</td>
                                    <td></td><td><input type="date"></td>
                                    <td>a<%=lang.lng(current_lang, "to")%></td><td><input type="date"></td>
                                </tr>
                                <tr>                                    
                                    <td><%=lang.lng(current_lang, "talao_or_reference")%></td>
                                    <td></td>
                                    <td>
                                        <select id="talref">
                                            <option value="Todos"><%=lang.lng(current_lang, "all")%></option>
                                            <option value="depdoc"><%=lang.lng(current_lang, "splint")%></option>
                                            <option value="ref"><%=lang.lng(current_lang, "reference")%></option>
                                        </select>
                                    </td><td><%=lang.lng(current_lang, "code")%>:</td><td><input type="text" id="txttalref"></td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td></td><td></td><td></td><td></td><td>
                                        <!--<button onclick="processar('lists', 'b')">Listar</button>-->
                                        <%=vls.dinmcbtn(lang.lng(current_lang, "list"), "processar('lists', 'b')", "img/reports2.png", "", "float: right;")%>
                                    </td>
                                    <td>
                                        <%=vls.dinmcbtn(lang.lng(current_lang, "print"), "implistpymnts(document.getElementById('student_id').value)", "img/printp.png", "", "float: right;")%>
                                    </td>                                
                                </tr>
                            </table>
                        </td>
                        <td>
                            <fieldset style="background-color: #ABEBC6;">
                                <legend><%=lang.lng(current_lang, "general_situation")%></legend>
                                <table>
                                    <tr>
                                        <td><strong><%=lang.lng(current_lang, "total")%> <%=lang.lng(current_lang, "balance")%>:</strong></td><td><td><input type="text" id="balancet" disabled></td>
                                    </tr>
                                    <tr>
                                        <td colspan="2"><hr style="width: 100%;"></td>
                                    </tr>
                                    <tr>
                                        <td><%=lang.lng(current_lang, "amount_debt")%>:</td><td><td><input type="text" id="debt" disabled></td>
                                    </tr>
                                    <tr>
                                        <td><%=lang.lng(current_lang, "amount_paid")%>:</td><td><td><input type="text" id="paid" disabled></td>
                                    </tr> 
                                    <tr>
                                        <td><%=lang.lng(current_lang, "balance")%>:</td><td><td><input type="text" id="balance" disabled></td>
                                    </tr>   
                                </table>
                            </fieldset>    
                        </td>
                    </tr>
                </table>
            </fieldset>
            <br>
            <div id="pymtstbl" style="width: 80%; height: 260px;">            
                <table id="tblcs" border="1" style="width: 100%;">
                    <tr style="height: 46px; background-color:  #9B00FF;background: linear-gradient(to bottom, #9B00FF, white);">
                        <th style="width: 16%;"><%=lang.lng(current_lang, "month")%></th><th style="width: 16%;"><%=lang.lng(current_lang, "reference")%></th>
                        <th style="width: 16%;"><%=lang.lng(current_lang, "splint")%></th><th style="width: 16%;"><%=lang.lng(current_lang, "amount_debt")%></th>
                        <th style="width: 16%;"><%=lang.lng(current_lang, "amount_paid")%></th><th style="width: 16%;"><%=lang.lng(current_lang, "payment_receipt")%></th>
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
            <span style="color: blue;">Powered by: </span><a href="/" style="text-decoration: none; color: white;"><strong>/</strong>/</a>
        </div>              
        <div style="position: fixed; bottom: 2px; right: 2px;">
            <span style="font-size: 12px; background-color: white; color: black; padding-right: 10px;"><%=lang.lng(current_lang, "version")%>: <%=cssn.versionapp()%></span><span style="color: blue; background-color: #E67E22;">Powered by: </span><a href="amoraservices.org" style="text-decoration: none; color: white; background-color: #E67E22; color: white;"><strong>Amora</strong> Software & Services</a>
        </div>
        <div id="dvprcssr" style="position: absolute; top: 0px; left: 0px; display: none; z-index: 100; width: 100%; height: 100%; background-color: #EBF5FB; text-align: center;">
            <span id="closeprocessstatus" style="position: absolute; top: 46%;"><%=lang.lng(current_lang, "processing...")%></span>
        </div>
        <script>
            var stdntidk = document.getElementById("student_id");
            var pymntinfk = document.getElementById("pymntinf");
            stdntidk.addEventListener("keyup", function (event) {
                if (event.keyCode === 13) {
                    event.preventDefault();
                    processar('studentprofile_mth', 'b');
                    /* document.getElementById("Btn").click(); */
                }
            });
            pymntinfk.addEventListener("keyup", function (event) {
                if (event.keyCode === 13) {
                    event.preventDefault();
                    processar('ref_cod', 'b');
                    /* document.getElementById("Btn").click(); */
                }
            });
            try {
                document.getElementById("student_name").disabled = true;
                document.getElementById("stundent_surname").disabled = true;
                document.getElementById("course_level").disabled = true;
                document.getElementById("course_id").disabled = true;
            } catch (e) {
                alert(e.message);
            }
            window.onload = function () {
                document.body.style.display = "block";
            };  
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
