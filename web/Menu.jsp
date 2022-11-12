<%-- 
    Document   : Menu
    Created on : Jan 8, 2022, 9:53:16 PM
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
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <script src="js/jquery.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/Chart.min.js"></script>
        <title>SM</title>
        <link rel="icon" href="img/amora.png" type="image/x-icon" sizes="32x32">
        <link rel="icon" type="image/x-icon" href="img/amoraicon.ico" >

        <%
            SM_directories_mngmnt dirmng = new SM_directories_mngmnt();
            dirmng.checkIfDrctyExistandCreateIt(cssn.getPathIrprt());
            /*Start of Validation Session*/
            String scrsz = request.getParameter("scrsz");
            SM_Session_Validation ss_vld = new SM_Session_Validation(scrsz);
            String artcls = ss_vld.getArtcls();
            String logo = ss_vld.getLogo();
            String sector2 = ss_vld.getSector2();
            String lnk_disabled = ss_vld.getLnk_disabled();
            String sky = ss_vld.getSky();
            String dsbld = ss_vld.getDsbld();
            String dsbld4 = ss_vld.getDsbld4();
            String version_status = ss_vld.getVersion_status();
            String subsrs_nr = ss_vld.getSubsrs_nr();
            String sky2 = ss_vld.getSky2();
            /*End of Validation Session*/
            SM_Values vls = new SM_Values();

            if (dsbld4.equalsIgnoreCase("disabled") && !sky.contains("green")) {

        %>
        <meta http-equiv = "refresh" content = "10; url=Page2.jsp?z=<%=sky2%>"/>
        <%
            }
            /*dsbld = "disabled";*/
            a.SM_lb Lb = (a.SM_lb) session.getAttribute("SM_lb");
            a.SM_aw Ab = (a.SM_aw) request.getAttribute("SM_aw");
            if (Lb != null && Lb.getStatus()) {
                /*artcls = vls.Artcls();*/
                //logo = vls.logo();
            String cfusr = request.getParameter("cfusr");
            if (cfusr == null || cfusr.trim().length() == 0) {
                cfusr = "a";
            } 
%>
        <script>
            function processar(v) {
                window.open("/SM/s?t=" + v);
            }
            var languag = "<%=lang.lng(current_lang, "lang_option")%>";
            var groles = "<%=Lb.getRoles()%>";
            var gusrlgn = "<%=Lb.getUser()%>";
            var lsturl = "";
            var aa = "";
            var cfusr = "<%=cfusr%>";
            var class_id = "<%=lang.lng(current_lang, "class_id")%>";
            var resp_person_id = "<%=lang.lng(current_lang, "resp_person_id")%>";
            var resp_person_name = "<%=lang.lng(current_lang, "resp_person_name")%>";
            var number_of_students = "<%=lang.lng(current_lang, "number_of_students")%>";
            var class_level = "<%=lang.lng(current_lang, "class_level")%>";
            var class_year = "<%=lang.lng(current_lang, "class_year")%>";
            var description = "<%=lang.lng(current_lang, "description")%>";
            var topen = "<%=lang.lng(current_lang, "open")%>";
            var tedit = "<%=lang.lng(current_lang, "edit")%>";
            var you_dont_have_enough_privileges_to_see_this_part = "<%=lang.lng(current_lang, "you_dont_have_enough_privileges_to_see_this_part")%>";
            var confirm_with_ok_to_continue_or_cancel_to_cancel = "<%=lang.lng(current_lang, "confirm_with_ok_to_continue_or_cancel_to_cancel")%>";
            var do_you_want_to_associate_with_a_customer = "<%=lang.lng(current_lang, "do_you_want_to_associate_with_a_customer")%>";
            var unloakbtn = "<%=lang.lng(current_lang, "processing...")%>";
            var unloakmsg = "<%=lang.lng(current_lang, "unloakmsg")%>";
            var passwordunlk = "<%=lang.lng(current_lang, "password")%>";
            var wrong_credentials = "<%=lang.lng(current_lang, "wrong_credentials")%>";
            var newpageloginagain = "<%=lang.lng(current_lang, "newpageloginagain")%>";

            var gmngmnt = "0";
            var gclss = "0";
            function chstb(a) {
                if (a === "gst" && !groles.includes("g")) {
                    alert(you_dont_have_enough_privileges_to_see_this_part + "!");
                    return false;
                }
                if (a === "mn") {
                    try {
                        document.getElementById("gotToMn").style.display = "none";
                    } catch (e) {
                    }
                } else {
                    try {
                        document.getElementById("gotToMn").style.display = "block";
                    } catch (e) {
                    }
                }
                var vdhs = document.getElementById(a);
                const array = ["mn", "gst", "hlpdsk", "bckr", "snos", "rpts", "dshb", "clss", "ttrl"];
                array.forEach(function (i, index) {
                    try {
                        document.getElementById(i).style.display = 'none';
                    } catch (e) {
                    }
                });
                vdhs.style.display = 'block';
                if (a === "gst" || a === "hlpdsk") {
                    try {
                        document.getElementById("dvrst").style.display = "block";
                    } catch (e) {
                    }
                } else {
                    try {
                        document.getElementById("dvrst").style.display = "none";
                    } catch (e) {
                    }
                }
                try {
                    document.getElementById("dvrst").innerHTML = "";
                } catch (e) {
                }
                if (a === "bckr") {
                    try {
                        document.getElementById("lnkdwnld").innerHTML = "";
                    } catch (e) {

                    }
                }
                if (gmngmnt === "0" && a === "gst") {
                    setTimeout(function () {
                        processar('gu', 'b');
                    }, 500);
                }
                if (gclss === "0" && a === "clss") {
                    gclss = "1";
                    setTimeout(function () {
                        processar('classes_list', 'b');
                    }, 500);
                }
                if(a === "gst"){
                    if (cfusr === "g") {
                        history.replaceState("SM", "SM", "SM/s");
                    }
                    cfusr = "a";
                }
            }
            function processar(rgm, tprc) {
                try {
                    document.getElementById("dvprcssr").style.display = "block";
                } catch (e) {
                }
                if (tprc === "b" || tprc === "studentprofile_mth" || tprc === "unlckscrn") {
                    processarb(rgm, tprc);
                } else {
                    if (confirm('Confirma com OK para continuar ou CANCEL para cancelar')) {
                        processarb(rgm, tprc);
                    } else {
                        try {
                            document.getElementById("dvprcssr").style.display = "none";
                        } catch (e) {
                        }
                    }
                }
            }
            function processarb(rgm, tprc) {
                tprck = tprc;
                prvk = rgm;
                var di = "";
                var df = "";
                var actn = "";
                if (rgm === "g" & tprc === "u") {
                    actn = usuar_nv();
                } else if (rgm === "sysssn" & tprc === "sysssn") {
                    actn = getsysidpwd();
                } else if (tprc === "b") {
                    if (rgm === "studentprofile_mth") {
                        actn = "&c=" + document.getElementById("student_id").value;
                    } else if (rgm === "classes_list") {
                        var dflt_year = "2022";//present year
                        actn = "&yr=" + dflt_year;
                    }
                } else if (rgm === "pymnt_inf") {
                    actn = "&c=" + document.getElementById("pymntinf").value;
                } else if (rgm === "class") {
                    actn = "&class_id=" + document.getElementById("class_id").value
                            + "&resp_person_id=" + document.getElementById("resp_person_id").value
                            + "&resp_person_name=" + document.getElementById("resp_person_name").value
                            + "&description=" + document.getElementById("description").value;
                } else if (rgm === "aut") {
                    actn = "&class_level=" + document.getElementById("aut_class_level").value
                            + "&class_simester=" + document.getElementById("aut_class_simester").value
                            + "&class_year=" + document.getElementById("aut_class_year").value
                            + "&start_date=" + document.getElementById("aut_start_date").value
                            + "&end_date=" + document.getElementById("aut_end_date").value;
                } else if (rgm === "unlckscrn" & tprc === "unlckscrn") {
                    actn = "&s=" + document.getElementById("passwrdunlkscrn").value;
                } else if (tprc === "edc") {
                    actn = csedit(rgm);
                }
                var url = "s?t=2&di=" + di + "&df=" + df + "&cc=" + aa + "&user=" + gusrlgn + "&acao=" + tprc + "&prv=" + rgm + actn;
                lsturl = "/SM/s?t=1&di=" + di + "&df=" + df + "&user=" + gusrlgn;
                if (window.ActiveXObject) {
                    request = new ActiveXObject("Microsoft.XMLHTTP");
                } else if (window.XMLHttpRequest) {
                    request = new XMLHttpRequest();
                }
                request.onreadystatechange = rspns;
                request.open("POST", url, true);
                request.send();
            }
            function rspns() {
                if (request.readyState === 4) {
                    var rsp = request.responseText;
                    if (tprck === "edc" && rsp.includes("rocessado com sucesso")) {
                        window.open(lsturl + "&cfusr=g", "_self");
                    } else if (tprck === "b") {
						if (prvk === 'dhs') {
                                document.getElementById("dshtp").innerHTML = rsp.split("::")[0];
                                var rspvls = rsp.split("::")[1];
                                var aryd = [];
                                var aryd2 = [];
                                var aryd3 = [];
                                var aryd4 = [];
                                var aryd5 = [];
                                var rspvlss = rspvls.split(",");
                                aryd[0] = Math.abs(parseFloat(rspvlss[0])) || 0;
                                aryd[1] = Math.abs(parseFloat(rspvlss[1])) || 0;
                                aryd[2] = Math.abs(parseFloat(rspvlss[2])) || 0;
                                var rspvls2 = rsp.split("::")[2];
                                var rspvls22 = rspvls2.split(":")[0];
                                var rspvls22j = rspvls22.split(",");
                                try {
                                    for (var i = 0; i < rspvls22j.length; i++) {
                                        aryd2[i] = Math.abs(parseFloat(rspvls22j[i])) || 0;
                                    }
                                } catch (e) {
                                }
                                var rspvls23 = rspvls2.split(":")[1];
                                var rspvls23j = rspvls23.split(",");
                                try {
                                    for (var i = 0; i < rspvls23j.length; i++) {
                                        aryd3[i] = Math.abs(parseFloat(rspvls23j[i])) || 0;
                                    }
                                } catch (e) {
                                }
                                var rspvls24 = rspvls2.split(":")[2];
                                var rspvls24j = rspvls24.split(",");
                                try {
                                    for (var i = 0; i < rspvls24j.length; i++) {
                                        aryd4[i] = Math.abs(parseFloat(rspvls24j[i])) || 0;
                                    }
                                } catch (e) {
                                }
                                var rspvls25 = rspvls2.split(":")[3];
                                var rspvls25j = rspvls25.split(",");
                                try {
                                    for (var i = 0; i < rspvls25j.length; i++) {
                                        aryd5[i] = Math.abs(parseFloat(rspvls25j[i])) || 0;
                                    }
                                } catch (e) {
                                }
                                dhschrts(aryd, aryd2, aryd3, aryd4, aryd5);
                                /*alert(""+aryd+"::::"+aryd2+"::::"+aryd3+"::::"+aryd4+"::::"+aryd5);*/
                                glbdshb = "1";
                        } else if (prvk === "classes_list") {
                            list_of_classes(rsp);
                        } else if (prvk === "enroll_aut" || prvk === "gu") {
                            try {
                                filltbl(rsp, prvk);
                            } catch (e) {
                                /*alert(e.message);*/
                            }
                            if (gmngmnt === "0" && prvk === "gu") {
                                gmngmnt = "1";
                                setTimeout(function () {
                                    processar('enroll_aut', 'b');
                                }, 500);
                            }
                        }
                    } else if (tprck === "lnkdwn") {
                        try {
                            document.getElementById("lnkdwnld").innerHTML = rsp;
                        } catch (e) {
                        }
                    } else if (tprck === "unlckscrn") {
                        if ((rsp.replace(/\s+/g, "")) === "yes") {
                            unlockscreenfnt(unloakbtn);
                        } else {
                            alert(wrong_credentials);
                        }
                    } else {
                        try {
                            document.getElementById("dvrst").style.display = "block";
                        } catch (e) {
                        }
                        document.getElementById("dvrst").innerHTML = rsp;
                    }
                    if (tprck !== "unlckscrn") {
                        try {
                            document.getElementById("dvprcssr").style.display = "none";
                        } catch (e) {
                        }
                    }
                }
            }
            function enablesysidpwd() {
                try {
                    document.getElementById("txtsysid").disabled = false;
                } catch (e) {
                }
                try {
                    document.getElementById("txtsyspwd").disabled = false;
                } catch (e) {
                }
            }
            function aborginf() {
                try {
                    document.getElementById("chcklogt").disabled = false;
                } catch (e) {
                }
                try {
                    document.getElementById("txtdesig").disabled = false;
                } catch (e) {
                }
                try {
                    document.getElementById("chckdesig").disabled = false;
                } catch (e) {
                }
                try {
                    document.getElementById("txtlocz").disabled = false;
                } catch (e) {
                }
                try {
                    document.getElementById("chcklocz").disabled = false;
                } catch (e) {
                }
                try {
                    document.getElementById("btndesloc").disabled = false;
                } catch (e) {
                }
                try {
                    document.getElementById("fllogt").disabled = false;
                } catch (e) {
                }
                try {
                    document.getElementById("txtblnk").disabled = false;
                } catch (e) {
                }
            }
            function enablesysidpwd() {
                try {
                    document.getElementById("txtsysid").disabled = false;
                } catch (e) {
                }
                try {
                    document.getElementById("txtsyspwd").disabled = false;
                } catch (e) {
                }
            }
            function desaborginf() {
                try {
                    document.getElementById("chcklogt").disabled = true;
                } catch (e) {
                }
                try {
                    document.getElementById("txtdesig").disabled = true;
                } catch (e) {
                }
                try {
                    document.getElementById("chckdesig").disabled = true;
                } catch (e) {
                }
                try {
                    document.getElementById("txtlocz").disabled = true;
                } catch (e) {
                }
                try {
                    document.getElementById("chcklocz").disabled = true;
                } catch (e) {
                }
                try {
                    document.getElementById("btndesloc").disabled = true;
                } catch (e) {
                }
                try {
                    document.getElementById("fllogt").disabled = true;
                } catch (e) {
                }
                try {
                    document.getElementById("txtblnk").disabled = true;
                } catch (e) {
                }
            }
            function getsysidpwd() {
                var idsys = document.getElementById("txtsysid").value;
                var pwdsys = document.getElementById("txtsyspwd").value;
                return "&idsys=" + idsys + "&pwdsys=" + pwdsys;
            }
            function getSetP(d) {
                try {
                    setTimeout(function () {
                        var elmntd = document.getElementById(d);
                        elmntd.scrollIntoView();
                    }, 500);
                } catch (e) {
                    alert(e.message);
                }
            }
            function nvc(a) {
                if (a === "usnv") {
                    try {
                        document.getElementById("btnnvusr").disabled = true;
                    } catch (e) {
                    }
                }
                try {
                    document.getElementById(a).style.display = "block";
                } catch (e) {
                }
            }
            function usuar_nv() {
                var usu_us = bsccaresp(document.getElementById("usu_us").value);
                var usu_nms = bsccaresp(document.getElementById("usu_nms").value);
                var usu_ap = bsccaresp(document.getElementById("usu_ap").value);
                var usu_cat = document.getElementById("usu_cat").value;
                var usu_priv = bsccaresp(document.getElementById("usu_priv").value);
                return "&usu=" + usu_us + "&usn=" + usu_nms + "&usa=" + usu_ap + "&usc=" + usu_cat + "&usp=" + usu_priv;
            }
            function getsysidpwd() {
                var idsys = document.getElementById("txtsysid").value;
                var pwdsys = document.getElementById("txtsyspwd").value;
                return "&idsys=" + idsys + "&pwdsys=" + pwdsys;
            }
            function callUpldPg() {
                var url = "UpldPg.jsp?user=" + gusrlgn;
                window.open(url, 'popUpWindow', 'height=800,width=700,left=10,top=10,,scrollbars=yes,menubar=no');
                return false;
            }
            function verpvlgs() {
                var url = "Prvlgs.jsp";
                window.open(url, 'popUpWindow', 'height=1000,width=700,left=10,top=10,,scrollbars=yes,menubar=no');
                return false;
            }
            function checkstatestutus() {
                var lnkc = "/SM/r?t=2&acao=b&user=" + gusrlgn + "&sector=" + gsector + "&prv=msst";
                /*alert(lnkc);*/
                if (window.ActiveXObject) {
                    requestc = new ActiveXObject("Microsoft.XMLHTTP");
                } else if (window.XMLHttpRequest) {
                    requestc = new XMLHttpRequest();
                }
                requestc.onreadystatechange = rstc;
                requestc.open("POST", lnkc, true);
                requestc.send();
            }
            $(document).ready(function () {
                $("#btndesloc").click(function () {
                    $.ajax({
                        url: "s",
                        type: "POST",
                        dataType: "text",
                        data: {
                            dg: $("#txtdesig").val(),
                            lc: $("#txtlocz").val(),
                            lnk_download: $("#txtblnk").val(),
                            lg: lgtostr,
                            clg: $("#chcklogt").is(":checked") ? "1" : "0",
                            cdg: $("#chckdesig").is(":checked") ? "1" : "0",
                            clc: $("#chcklocz").is(":checked") ? "1" : "0",
                            t: "2",
                            acao: "orgdt",
                            user: gusrlgn,
                            sector: "SM"
                        },
                        success: function (data) {
                            document.getElementById("dvrst").style.display = "block";
                            document.getElementById("dvrst").innerHTML = data;
                            desaborginf();
                            window.open(lsturl + "&cfusr=g", "_self");
                        }
                    });
                    return;
                });
                $("#btnhelpdesk").click(function () {
                    $.ajax({
                        url: "s",
                        type: "POST",
                        dataType: "text",
                        data: {
                            t: "2",
                            acao: "cmmnts",
                            hlpid: $("#hlpid").val(),
                            hlpnm: $("#hlpnm").val(),
                            hlptxt: $("#hlptxt").val(),
                            user: gusrlgn,
                            sector: "SM"
                        },
                        success: function (data) {
                            alert(data);
                        },
                        error: function (e) {
                            alert(e.message);
                        }
                    });
                    return;
                });
            });
            function list_of_classes(r) {
                /*alert(r);*/
                var dvlstcls = document.getElementById("dvlstclss");
                var rr = r.split("::");
                var ss = "";
                try {
                    for (var i = 0; i < rr.length; i++) {
                        try {
                            //classes
                            var zz = "";
                            var ww = rr[i].split(",");
                            if (ww[0] === null || ww[0] === "" || ww[0] === "undefined" || (typeof ww[0] === 'undefined') || ww[0].trim().length === 0) {
                            } else {
                                zz = "<div class='inline' onclick=\"prcclass('" + ww[0] + "')\" style = 'width: 300px; height: 240px; padding: 8px; border: 1px solid gray'>"
                                        + "<div style='width: 100%; padding: 4px; background-color: grey; color: white; font-weight: bold;'>"
                                        + class_id + ": " + ww[1] + "</div>"
                                        + resp_person_id + ": <strong>" + ww[2] + "</strong><br>"
                                        + resp_person_name + ": <strong>" + ww[3] + "</strong><br>"
                                        + number_of_students + ": <strong>" + ww[4] + "</strong><br>"
                                        + class_level + ": <strong>" + ww[5] + "</strong><br>"
                                        + class_year + ": <strong>" + ww[6] + "</strong><br>"
                                        + description + ": <strong>" + ww[7] + "</strong><br>"
                                        + "</div>";
                                ss += zz;
                            }
                        } catch (e) {
                        }
                    }
                } catch (e) {
                }
                dvlstcls.innerHTML = ss;
            }
            function prcclass(a) {
                var url = "Clss.jsp?user=" + gusrlgn + "&a=" + a;
                window.open(url, 'popUpWindow', 'height=800,width=700,left=10,top=10,,scrollbars=yes,menubar=no');
                return false;
            }

            function crtbtnopn(indxy) {
                var ky = "                                <div style=\"padding-left: 10px; background-color: white; display: inline-block; width: 40px; height: 40px; border-radius: 50%;\">\n"
                        + "                                    <a href=\"#\" onclick=\"" + indxy + "\" style=\"text-decoration: none; float: none; display: inline;\">\n"
                        + "                                        <img src=\"img/openp.png\" style=\"width: 32px; height: 32px;\" title=\"" + topen + "\">\n"
                        + "                                    </a>\n"
                        + "                                </div>";
                return ky;
            }
            function crtbtnedt(indxy) {
                var ky = "                                <div style=\"padding-left: 10px; background-color: white; display: inline-block; width: 40px; height: 40px; border-radius: 50%;\">\n"
                        + "                                    <a href=\"#\" onclick=\"" + indxy + "\" style=\"text-decoration: none; float: none; display: inline;\">\n"
                        + "                                        <img src=\"img/editp.png\" style=\"width: 32px; height: 32px;\" title=\"" + tedit + "\">\n"
                        + "                                    </a>\n"
                        + "                                </div>";
                return ky;
            }
            function alwupdt(h) {
                document.getElementById("guid" + h + "4").innerHTML = "<select id=\"ipt" + h + "4\" style=\"width: 90px;\"><option value=\"" + document.getElementById("guid" + h + "4").innerHTML + "\">" + document.getElementById("guid" + h + "4").innerHTML + "</option><option value=\"Gestor\">Gestor</option><option value=\"Caixa\">Caixa</option><option value=\"Visualizador\">Visualizador</option></select>";
                document.getElementById("guid" + h + "5").innerHTML = "<input type=\"text\" id=\"ipt" + h + "5\" value=\"" + document.getElementById("guid" + h + "5").innerHTML + "\" style=\"width: 180px;\">";
                document.getElementById("guid" + h + "6").innerHTML = "<input type=\"text\" id=\"ipt" + h + "6\" value=\"" + document.getElementById("guid" + h + "6").innerHTML + "\" style=\"width: 40px;\">";
                try {
                    document.getElementById("btnusredit" + h).disabled = true;
                } catch (e) {
                }
            }
            function filltbl(vtb, p) {
                var g = p;
                /*alert(p);   
                 alert(vtb); 
                 p = document.getElementById("dvr" + p).innerHTML;*/
                if (p === "gu") {
                    p = hus;
                } else if (p === "enroll_aut") {
                    p = haut;
                }
                /*alert("p: " + p);*/
                var pp = "";
                try {
                    pp = p.replace("</table>", "");
                } catch (e) {
                }
                var tdj = "";
                var ftb = vtb.split(":");
                /*alert("p: " + ftb[0]);*/
                /*alert("p: " + ftb[1]);*/
                for (var i = 0; i < ftb.length; i++) {
                    var fftt = ftb[i];
                    var fft = fftt.split(";");

                    if (fft[1] === null || fft[1] === "" || fft[1] === "undefined" || (typeof fft[1] === 'undefined')) {
                        /*alert(fft[1]); */
                    } else {
                        /*alert(fft[i]);*/
                        var sry = ftb[i];
                        var srya = sry.split(";");
                        tdj += "<tr>";
                        for (var j = 0; j < srya.length; j++) {
                            var sry2 = srya[j];
                            tdj += "<td id='guid" + srya[0] + j + "'>" + sry2 + "</td>";
                        }
                        if (g === "gu") {
                            sry2 = "" + crtbtnopn("alwupdt(\'" + srya[0] + "\')") + ""
                                    + "" + crtbtnedt("processar(\'" + srya[0] + "\',\'edc\')") + "";
                            tdj += "<td id = 'guid" + srya[0] + "'>" + sry2 + "</td>";
                        }
                        tdj += "</tr>";

                    }

                }
                /*alert(pp);
                 alert(tdj);*/
                try {
                    var bb = pp.replace("<tbody>", "");
                    pp = bb;
                } catch (e) {
                }
                try {
                    var bb = pp.replace("</tbody>", "");
                    pp = bb;
                } catch (e) {
                }
                try {
                    var bb = pp.replace("</table>", "");
                    pp = bb;
                } catch (e) {
                }
                var cpp = pp + tdj + "</table>";
                /*alert(cpp);*/
                document.getElementById("dvr" + g).innerHTML = "";
                document.getElementById("dvr" + g).innerHTML = cpp;
                /*if (g === "prodl") {
                 if (glbfctry === "0") {
                 glbfctry = "1";
                 setTimeout(function () {
                 processar('fctry', 'b');
                 }, 500);
                 }
                 }*/
            }
            function lockscreenfnt(v) {
                try {
                    document.getElementById("dvprcssr").style.display = "block";
                } catch (e) {
                }
                try {
                    document.getElementById("closeprocessstatus").innerHTML = "" + v + " " + passwordunlk
                            + "<input type='password' id='passwrdunlkscrn' style = 'width: 120px;'/><a href='#' onclick=\"processar('unlckscrn','unlckscrn')\">" + unloakmsg + "</a>";
                } catch (e) {
                }
            }
            function unlockscreenfnt(v) {
                try {
                    document.getElementById("closeprocessstatus").innerHTML = v;
                } catch (e) {
                }
                try {
                    document.getElementById("dvprcssr").style.display = "none";
                } catch (e) {
                }
            }
            function bsccaresp(wrdstxt) {
                var tdwrdstxt = "";
                if (wrdstxt !== null && (wrdstxt === '&' || tdwrdstxt.includes('&'))) {
                    try {
                        var rpctxt = wrdstxt.replace('&', '_');
                        tdwrdstxt = rpctxt;
                    } catch (e) {
                    }
                    return tdwrdstxt;
                } else if (wrdstxt !== null && (wrdstxt === ':' || tdwrdstxt.includes('&'))) {
                    try {
                        var rpctxt = wrdstxt.replace(':', '_');
                        tdwrdstxt = rpctxt;
                    } catch (e) {
                    }
                    return tdwrdstxt;
                } else {
                    return wrdstxt;
                }
            }
            function csedit(m) {
                /*alert(document.getElementById("guid" + m + "4").value);*/
                return "&id=" + m + "&c=" + document.getElementById("ipt" + m + "4").value + "&p=" + document.getElementById("ipt" + m + "5").value + "&e=" + document.getElementById("ipt" + m + "6").value;
            }
			function dhschrts(aryd, aryd2, aryd3, aryd4, aryd5) {
                new Chart(document.getElementById("brchrt"), {
                    type: 'bar',
                    data: {
                        labels: ["Despesas", "Compras", "Vendas"],
                        datasets: [
                            {
                                label: "Mts",
                                backgroundColor: ["#8e5ea2", "#3cba9f", "#e8c3b9"],
                                data: aryd
                            }
                        ]
                    },
                    options: {
                        legend: {display: false},
                        title: {
                            display: true,
                            text: 'Valores por Categoria'
                        }
                    }
                });
                new Chart(document.getElementById("lnchrt"), {
                    type: 'line',
                    data: {
                        labels: aryd5,
                        datasets: [{
                                data: aryd2,
                                label: "Despesas",
                                borderColor: "#3e95cd",
                                fill: false
                            }, {
                                data: aryd3,
                                label: "Compras",
                                borderColor: "#8e5ea2",
                                fill: false
                            }, {
                                data: aryd4,
                                label: "Vendas",
                                borderColor: "#3cba9f",
                                fill: false
                            }
                        ]
                    },
                    options: {
                        title: {
                            display: true,
                            text: 'Valores por Categoria e Tempo'
                        }
                    }
                });
            }			

        </script> 
        <style>            
            /*td:hover {
                background: #5499C7;
                cursor: pointer;
            }*/
            .center {
                margin: auto;
                width: 50%;
                padding: 10px;
            }
            div.inline { float:left; }
            .clearBoth { clear:both; }
            .center {
                margin: auto;
                width: 50%;
                padding: 10px;
                text-align: center;
            }
            table {
                border-collapse: collapse;
                text-align: center;
            }
            th, td {
                padding: 6px;                
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
        <%=version_status%>
        <%=sky%>
        <div style = "background-image: linear-gradient(#5499C7, white, #5499C7);"><img src="<%=cssn.getOrgInf()[1]%>" alt= "<%=lang.lng(current_lang, "logo")%>" style="width: 140px; height: 70px;"/> <strong><span id="title_of_proj" style="padding: 10px; font-size: 32px;"><%=lang.lng(current_lang, "school_management_system")%></span></strong><div style="float: right;font-size: 12px; padding-right: 6px;">
                <%=lang.lng(current_lang, "language")%>: <select onchange="change_lng(this.value)">
                    <%
                        String optnslng = current_lang;
                        /*if(current_lang.equalsIgnoreCase("english")){
                          optnslng = "portuguese";
                       } else{
                          optnslng = "english";
                       }*/
                    %>
                    <option value="<%=optnslng%>"><%=lang.lng(current_lang, optnslng)%></option> 
                    <option value="portuguese"><%=lang.lng(current_lang, "portuguese")%></option> 
                    <option value="english"><%=lang.lng(current_lang, "english")%></option>
                    <option value="spanish"><%=lang.lng(current_lang, "spanish")%></option>
                    <option value="french"><%=lang.lng(current_lang, "french")%></option> 
                </select>
                <a href="#" onclick="lockscreenfnt('<%=lang.lng(current_lang, "lockscreen_message")%>')" title="<%=lang.lng(current_lang, "lockscreen")%>"><%=lang.lng(current_lang, "lockscreen")%></a>	
                <%=lang.lng(current_lang, "username")%>: <span style="color: blue;"><%=Lb.getNome()%></span><a href="/SM/r?t=3" style="text-decoration: none; color: grey;"><img src="img/close.png" style="width: 32px; height: 32px;" title="Sair"></a></div></div>
        <div id="gotToMn" style="width: 100%; display: none;">
            <table style="float: right;">
                <tr>
                    <td>
                        <a href="s?t=1"><img src="img/menu.png" style="width: 40px; height: 26px;"/></a>                        
                    </td>                    
                </tr>
            </table>
        </div> 
        <div id="dvrst" style="width: 100%; display: none;"></div>
        <div class="divtbs" id="mn" style="display: block; width: 100%">
            <table class="center">
                <tr>
                    <td style="width: 200px; height: 200px; background-color: #EAF2F8;">
                        <a href="/SM/s?t=5" style="text-decoration: none;">
                            <img src="img/enrollment.png" style="width: 160px; height: 160px;" title="<%=lang.lng(current_lang, "subscriptions_renewals_and_cancellations")%>">   
                        </a>                        
                    </td>
                    <td style="width: 200px; height: 200px; background-color: #EAF2F8;">
                        <a href="/SM/s?t=6" style="text-decoration: none;">
                            <img src="img/propinas.png" style="width: 160px; height: 160px;" title="<%=lang.lng(current_lang, "tuition_fees")%>">   
                        </a>                         
                    </td>
                    <td style="width: 200px; height: 200px; background-color: #EAF2F8;">
                        <a href="/SM/s?t=7" style="text-decoration: none;">
                            <img src="img/courses.png" style="width: 160px; height: 160px;" title="<%=lang.lng(current_lang, "registration_of_courses_and_subjects")%>">   
                        </a>                               
                    </td>
                    <td style="width: 200px; height: 200px; background-color: #EAF2F8;">
                        <a href="#" onclick="chstb('clss')" style="text-decoration: none;">
                            <img src="img/classes.png" style="width: 160px; height: 160px;" title="<%=lang.lng(current_lang, "classes")%>">   
                        </a>     
                    </td>
                </tr>
                <tr>
                    <td style="width: 200px; height: 200px; background-color: #EAF2F8;">
                        <a href="#" onclick="chstb('dshb')" style="text-decoration: none;">
                            <img src="img/dashboards.png" style="width: 160px; height: 160px;" title="Dashboard">   
                        </a>
                    </td>                    
                    <td style="width: 200px; height: 200px; background-color: #EAF2F8;">
                        <a href="#" onclick="chstb('gst')" style="text-decoration: none;">
                            <img src="img/gestao.png" style="width: 160px; height: 160px;" title="<%=lang.lng(current_lang, "management")%>">   
                        </a>
                    </td>
                    <td style="width: 200px; height: 200px; background-color: #EAF2F8;">
                        <a href="/SM/s?t=8" style="text-decoration: none;">
                            <img src="img/reports2.png" style="width: 160px; height: 160px;" title="<%=lang.lng(current_lang, "reports")%>">   
                        </a>  
                    </td>
                    <td style="width: 200px; height: 200px; background-color: #EAF2F8;">
                        <a href="#" onclick="chstb('bckr')" style="text-decoration: none;">
                            <img src="img/bkcp.png" style="width: 160px; height: 160px;" title="<%=lang.lng(current_lang, "restoration")%>">   
                        </a>
                    </td>
                </tr>
                <tr>
                    <td style="width: 200px; height: 200px; background-color: #EAF2F8;">
                        <a href="#" onclick="chstb('hlpdsk')" style="text-decoration: none;">
                            <img src="img/helpdesk.png" style="width: 160px; height: 160px;" title="HelpDesk">   
                        </a>  
                    </td>
                    <td style="width: 200px; height: 200px; background-color: #EAF2F8;">
                        <a href="#" onclick="chstb('snos')" style="text-decoration: none;">
                            <img src="img/web.png" style="width: 160px; height: 160px;" title="<%=lang.lng(current_lang, "about_us")%>">   
                        </a> 
                    </td>
                    <td style="width: 20%; height: 180px; background-color: #EAF2F8; border-color: #BFC9CA;">
                        <a href="#" onclick="chstb('ttrl')" style="text-decoration: none;">
                            <img src="img/manual.png" style="width: 160px; height: 160px;" title="<%=lang.lng(current_lang, "manual")%>">   
                        </a>
                    </td>   
                    <td style="width: 20%; height: 180px; background-color: #EAF2F8; border-color: #BFC9CA;">

                    </td>
                </tr>
            </table>
        </div>
        <div class="divtbs" id="gst" style="display: none; width: 100%">
            <div style="width: 100%;"><%=lang.lng(current_lang, "navigate_to")%>: <a href="#usrttlid"><%=lang.lng(current_lang, "users")%></a>, 
                <a href="#auth"><%=lang.lng(current_lang, "authorization_for_registration_renewal_dates")%></a>.</div>
            <br>
            <div>
                <table>
                    <tr>
                        <td colspan="8">
                            <strong><%=lang.lng(current_lang, "unique_installation_number")%>: <%=cssn.keystatus()[6]%>, <%=lang.lng(current_lang, "status")%>: <%=cssn.keystatus()[7]%></strong>
                        </td>
                    </tr>
                    <tr>
                        <td><%=lang.lng(current_lang, "system_id")%>:</td><td><input type="text" id="txtsysid"  disabled="disabled"></td>
                        <td><%=lang.lng(current_lang, "password")%>:</td><td><input type="password" id="txtsyspwd"  disabled="disabled"></td><td style="width: 4px;"></td>
                        <td>
                            <%=vls.dinmcbtn(lang.lng(current_lang, "open"), "enablesysidpwd()", "img/openp.png", "", "")%>
                        </td><td style="width: 4px;"></td>
                        <td>
                            <%=vls.dinmcbtn(lang.lng(current_lang, "validate"), "processar('sysssn', 'sysssn')", "img/editp.png", "", "")%>
                        </td>
                    </tr>
                </table><br>
                <strong id="deslocid" style="font-size: 30px;"><%=lang.lng(current_lang, "designation_and_location")%></strong><br>
                <div>
                    <%=vls.dinmcbtn(lang.lng(current_lang, "enable_fields"), "aborginf(),getSetP('deslocid')", "img/openp.png", "", "")%>
                    <br>
                    <table>
                        <tr>
                            <td><%=lang.lng(current_lang, "logo")%>:</td><td><img id="lgimg" src="<%=cssn.getOrgInf()[1]%>" style="width: 120px; height: 50px;"><input type="file" name="fllogt" id="fllogt" disabled="disabled"></td><td>
                                <%=lang.lng(current_lang, "show_in_the_report")%><input type="checkbox" id="chcklogt" value="1" disabled="disabled" <%=cssn.getOrgInf()[3]%>>
                            </td>
                        </tr>
                        <tr><td style="height: 6px;"></td></tr>
                        <tr>
                            <td><%=lang.lng(current_lang, "designation")%>:</td><td><input type="text" id="txtdesig" value="<%=cssn.getOrgInf()[0]%>" disabled="disabled"></td><td>
                                <%=lang.lng(current_lang, "show_in_the_report")%><input type="checkbox" id="chckdesig" value="1" <%=cssn.getOrgInf()[4]%> disabled="disabled">
                            </td>
                        </tr>
                        <tr><td style="height: 6px;"></td></tr>
                        <tr>
                            <td><%=lang.lng(current_lang, "location")%>:</td><td><input type="text" id="txtlocz" value="<%=cssn.getOrgInf()[2]%>" disabled="disabled"></td><td>
                                <%=lang.lng(current_lang, "show_in_the_report")%><input type="checkbox" id="chcklocz" value="1" <%=cssn.getOrgInf()[5]%> disabled="disabled">
                            </td>
                        </tr>
                        <tr>
                            <td>Backup(link):</td><td><input type="text" id="txtblnk" value="<%=cssn.getOrgInf()[6]%>" disabled="disabled"></td><td>
                            </td>
                        </tr>
                    </table><br>
                    <%=vls.dinmcbtn(lang.lng(current_lang, "add_or_update"), "", "img/editp.png", "id=\"btndesloc\"", "float: none;")%>
                </div>                                    
            </div>
            <br>        
            <div>
                <strong id="usrttlid" style="font-size: 30px;"><%=lang.lng(current_lang, "users")%></strong><br>
                <%=vls.dinmcbtn(lang.lng(current_lang, "new"), "nvc('usnv'),getSetP('usrttlid')", "img/usr.png", "id=\"btnnvusr\"", "float: left;")%>
                <br>
                <div id="usnv" style="display: none; background-color: #D6EAF8; padding: 12px;">
                    <table>
                        <tr>
                            <td><%=lang.lng(current_lang, "user")%>:</td>
                            <td><input type="text" id="usu_us"></td>
                            <td><%=lang.lng(current_lang, "first_names")%>:</td>
                            <td><input type="text" id="usu_nms"></td>
                            <td><%=lang.lng(current_lang, "surname")%>:</td>
                            <td><input type="text" id="usu_ap"></td>
                            <td><%=lang.lng(current_lang, "category")%>:</td>
                            <td>
                                <select  id="usu_cat">
                                    <option value="NA">NA</option> 
                                </select>  
                            </td>
                        </tr>
                        <tr><td style="height: 6px;"></td></tr>
                        <tr>
                            <td><%=lang.lng(current_lang, "privileges")%>:</td>
                            <td><input type="text" id="usu_priv" style="width: 60px;"></td>
                            <td colspan="6">
                                <%=vls.dinmcbtn(lang.lng(current_lang, "insert"), "processar('g', 'u')", "img/insertp4.png", "", "float: right;")%>
                            </td>
                        </tr>
                    </table>                     
                    <!--<select  id="usu_priv">
                        <option value="NA">NA</option> 
                        <option value="A">A</option> 
                        <option value="B">B</option> 
                        <option value="C">C</option> 
                        <option value="D">D</option> 
                    </select>-->                                
                </div>
                <div>
                    <%=subsrs_nr%>
                    <a href="#" style="font-size: 11px;" onclick="processar('gu', 'b')" <%=dsbld%>><%=lang.lng(current_lang, "refresh")%></a>
                </div>
                <div id="dvrgu">
                    <table border="1">
                        <tr style="height: 46px; background-color:  #9B00FF;background: linear-gradient(to bottom, #9B00FF, white);">
                            <th><%=lang.lng(current_lang, "order")%></th><th><%=lang.lng(current_lang, "username")%></th>
                            <th><%=lang.lng(current_lang, "first_names")%></th><th><%=lang.lng(current_lang, "surname")%></th>
                            <th><%=lang.lng(current_lang, "category")%></th><th><%=lang.lng(current_lang, "privileges")%><br>
                                <a href="#" style="font-size: 10px; text-decoration: none;" onclick="verpvlgs()"><%=lang.lng(current_lang, "interpret")%></a></th>
                            <th><%=lang.lng(current_lang, "state")%></th><th><%=lang.lng(current_lang, "editing")%></th>
                        </tr>
                    </table>
                </div> 
                <br><br>
                <div>
                    <strong id="auth" style="font-size: 30px;"><%=lang.lng(current_lang, "authorization_for_registration_renewal_dates")%></strong><br>
                    <%=vls.dinmcbtn(lang.lng(current_lang, "new"), "nvc('authrz')", "img/newclass.png", "id=\"btnnvusr\"", "float: left;")%>
                    <br>
                    <div id="authrz" style="display: none; background-color: #D6EAF8; padding: 12px;">
                        <table>
                            <tr>
                                <td><%=lang.lng(current_lang, "class_level")%>:</td>
                                <td><input type="text" id="aut_class_level"></td>
                                <td><%=lang.lng(current_lang, "class_simester")%>:</td>
                                <td><input type="text" id="aut_class_simester"></td>
                                <td><%=lang.lng(current_lang, "class_year")%>:</td>
                                <td><input type="text" id="aut_class_year"></td>
                                <td><%=lang.lng(current_lang, "start_date")%>:</td>
                                <td><input type="date" id="aut_start_date"></td>
                                <td><%=lang.lng(current_lang, "end_date")%>:</td>
                                <td><input type="date" id="aut_end_date"></td>                                
                            </tr>
                            <tr><td style="height: 6px;"></td></tr>
                            <tr>
                                <td colspan="10">
                                    <%=vls.dinmcbtn(lang.lng(current_lang, "insert"), "processar('aut', 'aut')", "img/insertp4.png", "", "float: right;")%>
                                </td>
                            </tr>
                        </table>                                   
                    </div><br>
                    <a href="#" style="font-size: 11px;" onclick="processar('enroll_aut', 'b')" <%=dsbld%>><%=lang.lng(current_lang, "refresh")%></a>
                </div>
                <div id="dvrenroll_aut">
                    <table border="1">
                        <tr style="height: 46px; background-color:  #9B00FF;background: linear-gradient(to bottom, #9B00FF, white);">
                            <th><%=lang.lng(current_lang, "order")%></th><th><%=lang.lng(current_lang, "class_level")%></th>
                            <th><%=lang.lng(current_lang, "class_simester")%></th><th><%=lang.lng(current_lang, "class_year")%></th>
                            <th><%=lang.lng(current_lang, "start_date")%></th><th><%=lang.lng(current_lang, "end_date")%></th>
                            <th><%=lang.lng(current_lang, "status")%></th><th><%=lang.lng(current_lang, "user_datetime")%></th>
                            <th><%=lang.lng(current_lang, "iduser")%></th>
                        </tr>
                    </table>
                </div> 
            </div>
            <br><br>            
        </div>
        <div class="divtbs" id="ttrl" style="display: none; width: 100%">
            <div>
                <object data="ManualUSUARIOSM.pdf" type="application/pdf" width="1130" height="900">
                    <a href="ManualUSUARIOSM.pdf"><%=lang.lng(current_lang, "manual")%></a>
                </object>
            </div>                 
        </div>                  
        <div class="divtbs" id="bckr" style="display: none; width: 100%">     
            <strong style="font-size: 30px;">Backup/Restore</strong><br><br>
            <%=lang.lng(current_lang, "click")%> <a href="#" onclick="processar('lnkdwn', 'lnkdwn')" style="text-decoration: none;"><%=lang.lng(current_lang, "here")%></a> para <strong>gerar backup</strong><br>
            <span id="lnkdwnld"></span><br>
            <%=lang.lng(current_lang, "click")%> <a href="#" onclick="callUpldPg()" style="text-decoration: none;"><%=lang.lng(current_lang, "here")%></a> <%=lang.lng(current_lang, "for")%> 
            <strong><%=lang.lng(current_lang, "restore_database")%>*</strong><br><br>
            <br><br>
            *<span style="font-size: 11px;"><%=lang.lng(current_lang, "the_database_will_be&aacute;_only_restored_if_done")%>!</span>
        </div>
        <div class="divtbs" id="clss" style="display: none; width: 100%">
            <strong style="font-size: 30px;"><%=lang.lng(current_lang, "classes")%></strong><br><br>
            <span style="font-size: 11px;"><%=lang.lng(current_lang, "can_add_and_edit_classes")%></span><br><br>
            <%=vls.dinmcbtn(lang.lng(current_lang, "new"), "nvc('classes')", "img/newclass.png", "id=\"btnnewclass\"", "float: left;")%>
            <br>
            <div id="classes" style="display: none; background-color: #D6EAF8; padding: 12px;">
                <table>
                    <tr>
                        <td><%=lang.lng(current_lang, "class_id")%>:</td>
                        <td><input type="text" id="class_id"></td>
                        <td><%=lang.lng(current_lang, "resp_person_id")%>:</td>
                        <td><input type="text" id="resp_person_id"></td>
                        <td><%=lang.lng(current_lang, "resp_person_name")%>:</td>
                        <td><input type="text" id="resp_person_name"></td>
                        <td><%=lang.lng(current_lang, "description")%>:</td>
                        <td>
                            <input type="text" id="description">  
                        </td>
                        <td>
                            <%=vls.dinmcbtn(lang.lng(current_lang, "insert"), "processar('class', 'class')", "img/insertp4.png", "", "float: right;")%>
                        </td>
                    </tr>
                </table>                     
                <!--<select  id="usu_priv">
                    <option value="NA">NA</option> 
                    <option value="A">A</option> 
                    <option value="B">B</option> 
                    <option value="C">C</option> 
                    <option value="D">D</option> 
                </select>-->                                
            </div>
            <br>   
            <div style="width: 100%;">
                <a href="#" style="font-size: 11px;" onclick="processar('classes_list', 'b')" <%=dsbld%>><%=lang.lng(current_lang, "refresh")%></a>
            </div>
            <br>
            <div id="dvlstclss" style="padding: 8px;">

            </div>
        </div>
        <div class="divtbs" id="hlpdsk" style="display: none; width: 100%">  
            <strong style="font-size: 30px;"><%=lang.lng(current_lang, "help_or_report_bug")%></strong><br>
            <%=lang.lng(current_lang, "customer_id")%>: <input type="text" id="hlpid"> <%=lang.lng(current_lang, "name")%>: <input type="text" id="hlpnm"><br>
            <%=lang.lng(current_lang, "content")%>:<br>
            <textarea id="hlptxt" rows="10" cols="80">
                                 
            </textarea><br>
            <input type="button" id="btnhelpdesk" value="<%=lang.lng(current_lang, "submit")%>">
        </div>  
        <div class="divtbs" id="dshb" style="display: none; width: 100%;height: 90%;">

            <table style="width: 100%;height: 100%;">
                <tr>
                    <!--<td style="width: 12px; background-color: gainsboro;">
                        <a href="#" onclick="chstb2('s')">Sumario</a><br>
                        <a href="#" onclick="chstb2('v')">Vendas</a><br>
                        <a href="#" onclick="chstb2('c')">Compras</a><br>
                        <a href="#" onclick="chstb2('d')">Despesas</a><br>  
                    </td>-->
                    <td>
                        <div style="width: 100%;height: 100%;"> 
                            <div style="width: 100%;">
                                <a href="#" style="font-size: 11px;" onclick="processar('dhs', 'b')" <%=dsbld%>><%=lang.lng(current_lang, "refresh")%></a>
                            </div>
                            <div id="dshtp" style="width: 100%;">

                            </div>
                            <div style="width: 900px; height: 300px;"> 
                                <table style="width: 100%; height: 100%; float: top;">
                                    <tr>
                                        <td>
                                            <canvas id="brchrt" width="300" height="300"></canvas>
                                        </td>
                                        <td>
                                            <canvas id="lnchrt" width="600" height="300"></canvas>
                                        </td>
                                    </tr>
                                </table>                                       

                            </div>

                        </div>   
                    </td>
                </tr>
            </table>                     
        </div>
        <div class="divtbs" id="rpts" style="display: none; width: 100%">
            <div>
                <object data="ManualUSUARIOSM.pdf" type="application/pdf" width="1130" height="900">
                    <a href="ManualUSUARIOSM.pdf"><%=lang.lng(current_lang, "manual")%></a>
                </object>
            </div>                 
        </div> 
        <div class="divtbs" id="snos" style="display: none; width: 100%">   
            <strong style="font-size: 30px;"><%=lang.lng(current_lang, "about_us")%></strong><br>
            <span style="font-size: 11px;"><%=lang.lng(current_lang, "this_page_only_works_with_internet")%>!</span><br>
            <div id="dvsnos" style="width: 100%; height: 80%;">
                <object type="text/html" data="http://amoraservices.org/" width="800px" height="700px" style="overflow:auto;border:2px blue">
                </object>
            </div>
        </div>  
        <div style="position: fixed; bottom: 2px; right: 2px; background-color: #E67E22; color: white;">
            <span style="color: blue;">Powered by: </span><a href="amoraservices.org" style="text-decoration: none; color: white;"><strong>Amora</strong> Software & Services</a>
        </div> 
        <div style="position: fixed; bottom: 2px; right: 2px;">
            <span style="font-size: 12px; background-color: white; color: black; padding-right: 10px;"><%=lang.lng(current_lang, "version")%>: <%=cssn.versionapp()%></span><span style="color: blue; background-color: #E67E22;">Powered by: </span><a href="" style="text-decoration: none; color: white; background-color: #E67E22; color: white;"><strong>Amora</strong> Software & Services</a>
        </div>
        <div id="dvprcssr" style="position: absolute; top: 0px; left: 0px; display: none; z-index: 100; width: 100%; height: 100%; background-color: #EBF5FB; text-align: center;">
            <span id="closeprocessstatus" style="position: absolute; top: 46%;"><%=lang.lng(current_lang, "processing...")%></span>
        </div>
        <script>

hus=document.getElementById("dvrgu").innerHTML;haut=document.getElementById("dvrenroll_aut").innerHTML;window.onload=function(){document.body.style.display="block"};"g"===cfusr&&(setTimeout(function(){chstb("gst");document.getElementById("dvrst").style.display="block";document.getElementById("dvrst").innerHTML="<span style='color: green;'>Processado com sucesso!</span>"},500),cfusr="a");


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
