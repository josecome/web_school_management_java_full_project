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
            var tprck = "";
            var prvk = "";
            var di = "";
            var df = "";
            var gusrlgn = "<%=Lb.getUser()%>";
            var confirm_with_ok_to_continue_or_cancel_to_cancel = "<%=lang.lng(current_lang, "confirm_with_ok_to_continue_or_cancel_to_cancel")%>";
            var do_you_want_to_associate_with_a_customer = "<%=lang.lng(current_lang, "do_you_want_to_associate_with_a_customer")%>";
            var unloakbtn = "<%=lang.lng(current_lang, "processing...")%>";
            var unloakmsg = "<%=lang.lng(current_lang, "unloakmsg")%>";
            var passwordunlk = "<%=lang.lng(current_lang, "password")%>";
            var wrong_credentials = "<%=lang.lng(current_lang, "wrong_credentials")%>";
            var newpageloginagain = "<%=lang.lng(current_lang, "newpageloginagain")%>";             

function processar(a,b){try{document.getElementById("dvprcssr").style.display="block"}catch(c){}tprck=b;prvk=a;var e=df=di="",d=document.getElementById("typlst").value;"b"===b?"lists"===a&&(e="&tp=a&dc="+document.getElementById("talref").value+"&c="+document.getElementById("txttalref").value):"unlckscrn"===a&"unlckscrn"===b&&(e="&s="+document.getElementById("passwrdunlkscrn").value);a="s?t=2&di="+di+"&df="+df+"&user="+gusrlgn+"&acao="+b+"&prv="+a+e+"&tlst="+d;window.ActiveXObject?request=new ActiveXObject("Microsoft.XMLHTTP"):
window.XMLHttpRequest&&(request=new XMLHttpRequest);request.onreadystatechange=rspns;request.open("POST",a,!0);request.send()}function rspns(){if(4===request.readyState){var a=request.responseText;"b"===tprck?call_fill_tbl(a):"unlckscrn"===tprck&&("yes"===a.replace(/\s+/g,"")?unlockscreenfnt(unloakbtn):alert(wrong_credentials));if("unlckscrn"!==tprck)try{document.getElementById("dvprcssr").style.display="none"}catch(b){}}}
function call_fill_tbl(a){var b=0,e=0,d="",c=document.getElementById("typlst").value;"Estudantes"===c?d="<table id='tblcs' border='1' style='width: 100%;'>  <tr style='height: 46px; background-color:  #9B00FF;background: linear-gradient(to bottom, #9B00FF, white);'><th style='width: 16%;'>Ordem</th> <th style='width: 16%;'>Nr do Est</th><th style='width: 16%;'>Nome Completo</th><th style='width: 16%;'>C level</th><th style='width: 16%;'>Sim.</th><th style='width: 16%;'>Data Nasc</th><th style='width: 16%;'>Residencia</th><th style='width: 16%;'>Telefone 1</th><th style='width: 16%;'>Telefone 2</th><th style='width: 16%;'>Tipo</th><th style='width: 16%;'>Email</th><th style='width: 16%;'>Primeira Insc</th><th style='width: 16%;'>Ultima Insc</th><th style='width: 16%;'>Estado</th><th style='width: 16%;'>Data e Hora</th><th style='width: 16%;'>Usuario</th></tr>":
"Pagamentos"===c?d="<table id='tblcs' border='1' style='width: 100%;'>  <tr style='height: 46px; background-color:  #9B00FF;background: linear-gradient(to bottom, #9B00FF, white);'><th style='width: 16%;'>Ordem</th> <th style='width: 16%;'>Nr do Est</th><th style='width: 16%;'>Nome Completo</th><th style='width: 16%;'>C level</th><th style='width: 16%;'>Sim.</th><th style='width: 16%;'>Mes</th><th style='width: 16%;'>Referencia</th><th style='width: 16%;'>Banco</th><th style='width: 16%;'>Talao</th><th style='width: 16%;'>V a pagar</th><th style='width: 16%;'>V a pago</th><th style='width: 16%;'>Data e Hora</th><th style='width: 16%;'>Usuario</th></tr>":
"Devedores"===c&&(d="<table id='tblcs' border='1' style='width: 100%;'>  <tr style='height: 46px; background-color:  #9B00FF;background: linear-gradient(to bottom, #9B00FF, white);'><th style='width: 16%;'>Ordem</th> <th style='width: 16%;'>Nr do Est</th><th style='width: 16%;'>Nome Completo</th><th style='width: 16%;'>C level</th><th style='width: 16%;'>Sim.</th><th style='width: 16%;'>Mes</th><th style='width: 16%;'>Referencia</th><th style='width: 16%;'>Banco</th><th style='width: 16%;'>Talao</th><th style='width: 16%;'>V a pagar</th><th style='width: 16%;'>V a pago</th><th style='width: 16%;'>Data e Hora</th><th style='width: 16%;'>Usuario</th></tr>");
a=a.split("::");try{for(c=0;c<a.length;c++){var f=a[c].split(","),h="<tr>";try{for(var g=0;g<f.length;g++)h+="<td>"+f[g]+"</td>",4===g&&(b+=parseFloat(f[4])),5===g&&(e+=parseFloat(f[5]))}catch(k){}h+="<tr>";d+=h}}catch(k){}d+="</table>";f=e-b;document.getElementById("pymtstbl").innerHTML=""+d;document.getElementById("balancet").value=""+f;document.getElementById("balance").value=""+f;document.getElementById("debt").value=""+b;document.getElementById("paid").value=""+e}
function imppag(){var a=document.getElementById("typlst").value;window.open("payments_list.jsp?cod=0&user="+gusrlgn+"&lvl=0&smts=0&ctyp=0&t=lststdnt&di="+di+"&df="+df+"&tlst="+a,"popUpWindow","height=600,width=600,left=10,top=10,,scrollbars=yes,menubar=no");return!1}
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
        </style>    
    </head>
    <body oncontextmenu="return false" style="display: none;">
        <%@page session="true" import="a.*" %>
        <div style = "background-image: linear-gradient(#5499C7, white, #5499C7);"><img src="<%=cssn.getOrgInf()[1]%>" alt= "Logo" style="width: 140px; height: 70px;"/><strong><span id="title_of_proj" style="padding: 10px; font-size: 32px;">Sistema de Gest&atilde;o Escolar</span></strong><div style="float: right;font-size: 12px; padding-right: 6px;">Lingua: <select disabled="disabled"><option value="Portugues">Portugues</option> <option value="Ingles">Ingles</option> </select>
        <a href="#" onclick="lockscreenfnt('<%=lang.lng(current_lang, "lockscreen_message")%>')" title="<%=lang.lng(current_lang, "lockscreen")%>"><%=lang.lng(current_lang, "lockscreen")%></a>
        Usu&aacute;rio: <span style="color: blue;"><%=""%></span><a href="/SM/s?t=3" style="text-decoration: none; color: grey;"><img src="img/close.png" style="width: 32px; height: 32px;" title="Sair"></a></div></div><br>
        <div style="width: 100%;">
            <a href="s?t=1"><img src="img/menu.png" style="float: right; width: 40px; height: 26px;"/></a>
        </div>    
        <div>
            <fieldset style="width: 1050px;">
                <legend><%=lang.lng(current_lang, "individual_statement")%></legend>    
                <table>
                    <tr>
                        <td>
                            <table>
                                <tr>
                                    <td><%=lang.lng(current_lang, "list_of")%> :</td>
                                    <td></td><td>
                                        <select id="typlst">
                                            <option value="Pagamentos"><%=lang.lng(current_lang, "payments")%></option>
                                            <option value="Estudantes"><%=lang.lng(current_lang, "students")%></option>
                                            <option value="Devedores"><%=lang.lng(current_lang, "debtors")%></option>
                                        </select>                                    
                                    </td>
                                </tr>
                                <tr><td style="height: 6px;"></td></tr>
                                <tr>
                                    <td><%=lang.lng(current_lang, "since")%>:</td>
                                    <td></td><td><input type="date"></td>
                                    <td><%=lang.lng(current_lang, "to")%></td><td><input type="date"></td>
                                </tr>
                                <tr><td style="height: 6px;"></td></tr>
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
                                <tr><td style="height: 6px;"></td></tr>
                                <tr>
                                    <td></td>
                                    <td></td><td></td><td></td><td></td><td>
                                        <!--<button onclick="processar('lists', 'b')">Listar</button>-->
                                        <%=vls.dinmcbtn(lang.lng(current_lang, "insert"), "processar('lists', 'b')", "img/reports2.png", "", "float: right;")%>
                                    </td>
                                    <td>
                                        <!--<button onclick="imppag()">Imprimir</button>-->
                                        <%=vls.dinmcbtn(lang.lng(current_lang, "print"), "imppag()", "img/printp.png", "", "float: right;")%>                                    
                                    </td>                                
                                </tr>
                            </table>
                        </td>
                        <td>
                            <fieldset style="background-color: #ABEBC6;">
                                <legend><%=lang.lng(current_lang, "general_situation")%></legend>
                                <table>
                                    <tr>
                                        <td><strong><%=lang.lng(current_lang, "total")%> <%=lang.lng(current_lang, "balance")%>:</strong></td><td>
                                        <td><input type="text" id="balancet" disabled></td>
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
                        <tr style='height: 46px; background-color:  #9B00FF;background: linear-gradient(to bottom, #9B00FF, white);'>
                            <th style='width: 16%;'><%=lang.lng(current_lang, "order")%></th> 
                            <th style='width: 16%;'><%=lang.lng(current_lang, "student_code")%></th>
                            <th style='width: 16%;'><%=lang.lng(current_lang, "level")%></th>
                            <th style='width: 16%;'><%=lang.lng(current_lang, "class_simester")%></th>
                            <th style='width: 16%;'><%=lang.lng(current_lang, "month")%></th>
                            <th style='width: 16%;'><%=lang.lng(current_lang, "reference")%></th>
                            <th style='width: 16%;'><%=lang.lng(current_lang, "bank")%></th>
                            <th style='width: 16%;'><%=lang.lng(current_lang, "splint")%></th>
                            <th style='width: 16%;'><%=lang.lng(current_lang, "amount_debt")%></th>
                            <th style='width: 16%;'><%=lang.lng(current_lang, "amount_paid")%></th>
                            <th style='width: 16%;'><%=lang.lng(current_lang, "date_and_time")%></th>
                            <th style='width: 16%;'><%=lang.lng(current_lang, "user")%></th>
                        </tr>
                    <!--<tr>
                        <td></td><td></td><td></td>
                    </tr>-->
                </table>
            </div>
        </div>
        <div style="position: fixed; bottom: 2px; right: 2px; background-color: #E67E22; color: white;">
            <span style="color: blue;">Powered by: </span><a href="/" style="text-decoration: none; color: white;"><strong>/</strong>/</a>
        </div>
        <div id="dvprcssr" style="position: absolute; top: 0px; left: 0px; display: none; z-index: 100; width: 100%; height: 100%; background-color: #EBF5FB; text-align: center;">
            <span id="closeprocessstatus" style="position: absolute; top: 46%;"><%=lang.lng(current_lang, "processing...")%></span>
        </div>  
        <script>
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
