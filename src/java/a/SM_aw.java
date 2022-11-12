package a;

import ed.encr;
import java.io.IOException;
import java.net.UnknownHostException;
import java.util.*;
import java.sql.*;
import java.text.DateFormat;
import java.text.Format;
import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.text.DecimalFormat;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.regex.Pattern;

public class SM_aw {

    private Connection con = null;
    private Statement stmt = null;
    private StringBuffer retorno = new StringBuffer("aaa");
    private String tblins = "";
    private String prvls = "z";
    private String tlst = "";
    String tp = "";
    SM_Values vls;
    SM_client_session cssn;
    int user_register = 0;
    SM_PreferedLang plng;
    String current_lang = "";
    SM_get_lng_file glng;
    SM_language lang;
    encr ec;

    public SM_aw(javax.servlet.http.HttpServletRequest request) throws UnknownHostException, IOException {
        String a = request.getParameter("acao");
        vls = new SM_Values();
        cssn = new SM_client_session();
        glng = new SM_get_lng_file();
        lang = new SM_language(glng.getlngs());
        plng = new SM_PreferedLang();
        current_lang = plng.getPreferedLang();
        tp = request.getParameter("tp");
        String[] vlspid = cssn.prvls(request.getParameter("user"));
        prvls = vlspid[0];
        ec = new encr();
        String completefield = " " + lang.lng(current_lang, "complete");
        if (request.getParameter("prp") == null || request.getParameter("user").trim().length() == 0) {
        } else if (request.getParameter("prp").equalsIgnoreCase("s")) {
            prvls = prvls + "ui";
        }
        tlst = request.getParameter("tlst");
        if (tlst == null || tlst.trim().length() == 0) {
            tlst = "zw";
        }
        //System.out.println("===" + a);
        try {
            user_register = Integer.parseInt(vlspid[1]);
        } catch (NumberFormatException e) {
            user_register = 0;
        }
        String s = "";
        String vldr = "";
        if (a == null) {
        } else if (a.equalsIgnoreCase("u")) {/*Inserir novo usuario*/
            String username = request.getParameter("usu");
            String firstnames = request.getParameter("usn");
            String surnames = request.getParameter("usa");
            String roles = request.getParameter("usp");
            String cat = request.getParameter("usc");
            if (username == null || username.trim().length() == 0) {
                vldr = " Prencher Nome";
            }
            if (firstnames == null || firstnames.trim().length() == 0) {
                vldr = " Prencher Primeiros Nomes";
            }
            if (surnames == null || surnames.trim().length() == 0) {
                vldr = " Prencher Apelido";
            }
            if (roles == null || roles.trim().length() == 0) {
                vldr = " Prencher Privilegios";
            }
            tblins = "users";
            s = "insert into users (username,firstnames,surnames,status,roles,category,entrydatetime,user_register,password) values ('" + username + "','" + firstnames + "','" + surnames + "',2,'" + roles + "','" + cat + "',now()," + user_register + ",'" + ec.enc("abcdefghij") + "')";
            retorno = new StringBuffer(insert(s, "b", vldr, prvls));
        } else if (a.equalsIgnoreCase("class")) {
            String class_id = request.getParameter("class_id");
            String resp_person_id = request.getParameter("resp_person_id");
            String resp_person_name = request.getParameter("resp_person_name");
            String description = request.getParameter("description");

            if (class_id == null || class_id.trim().length() == 0) {
                vldr = " Prencher class_id";
            }
            if (resp_person_id == null || resp_person_id.trim().length() == 0) {
                vldr = " Prencher resp_person_id";
            }
            if (resp_person_name == null || resp_person_name.trim().length() == 0) {
                vldr = " Prencher Apelido";
            }
            if (description == null || description.trim().length() == 0) {
                vldr = " Prencher description";
            }
            String class_level = "1";
            String class_year = "1";
            tblins = "class";
            s = "insert into classes (class_id,resp_person_id,resp_person_name,description,class_level,class_year,number_of_students,user_datetime,iduser) "
                    + "values ('" + class_id + "','" + resp_person_id + "','" + resp_person_name + "','" + description + "','" + class_level
                    + "','" + class_year + "',0,now()," + user_register + ")";
            retorno = new StringBuffer(insert(s, "b", vldr, prvls));
        } else if (a.equalsIgnoreCase("coursei")) {
            String courseid = request.getParameter("courseid");
            String coursename = request.getParameter("coursename");
            String regprice = request.getParameter("regprice");
            String mthprice = request.getParameter("mthprice");
            String coursedescr = request.getParameter("coursedescr");

            if (courseid == null || courseid.trim().length() == 0) {
                vldr = " Prencher Id do Curso";
            }
            if (coursename == null || coursename.trim().length() == 0) {
                vldr = " Prencher Nome  do Curso";
            }
            if (regprice == null || regprice.trim().length() == 0) {
                vldr = " Prencher Preco";
            }
            if (mthprice == null || mthprice.trim().length() == 0) {
                vldr = " Prencher Mensalidades";
            }
            if (coursedescr == null || coursedescr.trim().length() == 0) {
                vldr = " Prencher Descricao do Curso";
            }
            tblins = "course";
            s = "insert into courses (course_id,course_name,reg_price,mth_price,course_descr,user_datetime,iduser) values ('" + courseid + "','" + coursename + "','" + regprice + "','" + mthprice + "','" + coursedescr + "',now()," + user_register + ")";
            retorno = new StringBuffer(insert(s, "b", vldr, prvls));
        } else if (a.equalsIgnoreCase("aut")) {
            String class_level = request.getParameter("class_level");
            String class_simester = request.getParameter("class_simester");
            String class_year = request.getParameter("class_year");
            String start_date = request.getParameter("start_date");
            String end_date = request.getParameter("end_date");

            if (class_level == null || class_level.trim().length() == 0) {
                vldr = " Prencher class_level";
            }
            if (class_simester == null || class_simester.trim().length() == 0) {
                vldr = " Prencher class_simester";
            }
            if (class_year == null || class_year.trim().length() == 0) {
                vldr = " Prencher class_year";
            }
            if (start_date == null || start_date.trim().length() == 0) {
                vldr = " Prencher start_date";
            }
            if (end_date == null || end_date.trim().length() == 0) {
                vldr = " Prencher end_date";
            }
            tblins = "course";
            s = "insert into enrollment_authorizations (class_level,class_simester,class_year,start_date,end_date,status,user_datetime,iduser)"
                    + " values "
                    + "('" + class_level + "','" + class_simester + "','" + class_year + "','" + start_date + "','" + end_date + "','1',now()," + user_register + ")";
            retorno = new StringBuffer(insert(s, "b", vldr, prvls));
        }  else if(a.equalsIgnoreCase("unlckscrn")){
            String Usr = request.getParameter("user");
            String snh = request.getParameter("s");
            SM_lb Lb = new SM_lb(Usr, snh, "", "no");
            String statusyn = Lb.getStatusYesNo();
            //System.out.println("'" + statusyn + "'");
            retorno = new StringBuffer(statusyn);
            return;
        } else if (a.equalsIgnoreCase("subjecti")) {
            String subjectid = request.getParameter("subj_subject_id");//
            String subjsimester = request.getParameter("subj_course_simester");
            String subjcourse_level = request.getParameter("subj_course_level");
            String subjsubject_name = request.getParameter("subj_subject_name");//
            String subjectdescr = request.getParameter("subject_descr");//
            String courseid = request.getParameter("courseid");
            String subj_course_simester = request.getParameter("subj_course_simester");
            String subj_course_level = request.getParameter("subj_course_level");
            if (subjectid == null || subjectid.trim().length() == 0) {
                vldr = " Prencher Id da Cadeira";
            }
            if (subjsubject_name == null || subjsubject_name.trim().length() == 0) {
                vldr = " Prencher Nome  da Cadeira";
            }
            if (subjsimester == null || subjsimester.trim().length() == 0) {
                vldr = " Prencher o Simestre";
            }
            if (subjcourse_level == null || subjcourse_level.trim().length() == 0) {
                vldr = " Prencher o nivel";
            }
            if (subjectdescr == null || subjectdescr.trim().length() == 0) {
                vldr = " Prencher Descricao da Cadeira";
            }
            if (subj_course_simester == null || subj_course_simester.trim().length() == 0) {
                vldr = " Prencher Simestre";
            }
            if (subj_course_level == null || subj_course_level.trim().length() == 0) {
                vldr = " Prencher nivel";
            }
            tblins = "subject";
            s = "insert into subjects (subject_id,subject_name,subject_descr,subj_course_level,subj_course_simester,course_id,user_datetime,iduser)"
                    + " values ('" + subjectid + "','" + subjsubject_name + "','" + subjectdescr + "','" + subj_course_level
                    + "','" + subj_course_simester + "'," + "'" + courseid + "',now()," + user_register + ")";
            retorno = new StringBuffer(insert(s, "b", vldr, prvls));

        } else if (a.equalsIgnoreCase("enrollstdnt")) {
            String aut_enrl = vls.autorized_enrolmnt_dates();
            String v = aut_enrl.split(":")[0];
            String class_year = aut_enrl.split(":")[1];
            if (!v.equalsIgnoreCase("a")) {
                retorno = new StringBuffer("not_autorized");
                return;
            }
            String enroll_type = request.getParameter("enroll_type");
            String student_id = request.getParameter("student_id");
            String student_name = request.getParameter("student_name");
            String stundent_surname = request.getParameter("stundent_surname");
            String course_id = request.getParameter("course_id");
            String birth_date = request.getParameter("birth_date");
            String residence = request.getParameter("residence");
            String phone_1 = request.getParameter("phone_1");
            String phone_2 = request.getParameter("phone_2");
            String email = request.getParameter("email");
            String course_level = request.getParameter("course_level");
            String enroll_date = request.getParameter("enroll_date");
            String course_simest = request.getParameter("course_simest");
            String course_type = request.getParameter("course_type");

            if (enroll_type == null || enroll_type.trim().length() == 0) {
                vldr = " Prencher tipo de escricao";
                enroll_type = "NA";
            }
            if (course_type == null || course_type.trim().length() == 0 || course_type.equalsIgnoreCase("DiurnoNoturno")) {
                vldr = " Prencher course_type";
            }
            if (student_name == null || student_name.trim().length() <= 1) {
                vldr = " Prencher nome do estudante";
            }
            if (stundent_surname == null || stundent_surname.trim().length() <= 1) {
                vldr = " Prencher apelido do estudante";
            }
            if (course_id == null || course_id.trim().length() <= 1) {
                vldr = " Prencher id do curso";
            }

            if (birth_date == null || birth_date.trim().length() <= 8) {
                vldr = " Prencher data de nascimento";
            }
            if (residence == null || residence.trim().length() <= 8) {
                vldr = " Prencher residencia";
            }
            if (phone_1 == null || phone_1.trim().length() <= 3) {
                vldr = " Prencher telefone 1 se nao tem 8888";
            }
            if (phone_2 == null || phone_2.trim().length() <= 3) {
                vldr = " Prencher telefone 1 se nao tem 8888";
            }
            if (email == null || (email.trim().length() <= 6 && !email.equalsIgnoreCase("NA"))) {
                vldr = " Prencher Email se nao tem NA";
            }
            if (course_level == null || course_level.trim().length() == 0) {
                vldr = " Prencher Nivel";
            }
            if (enroll_date == null || enroll_date.trim().length() <= 8) {
                vldr = " Prencher data de inscricao";
            }
            if (course_simest == null || course_simest.trim().length() == 0) {
                vldr = " Prencher simestre do curso";
            }
            if (course_simest == null || course_simest.trim().length() == 0) {
                retorno = new StringBuffer(" Prencher Simestre!");
                return;
            } else if (course_simest.equalsIgnoreCase("Primeiro")) {
                course_simest = "1";
            } else if (course_simest.equalsIgnoreCase("Segundo")) {
                course_simest = "2";
            }
            String student_id_new_enrolled = "";
            if (!enroll_type.equalsIgnoreCase("Inscricao")) {
                student_id_new_enrolled = student_id;
            }
            tblins = "enrolled_students";//1 + (select max(a.student_id) from enrolled_students a)
            if (enroll_type.equalsIgnoreCase("Inscricao")) {
                java.util.Date today = new java.util.Date();
                SimpleDateFormat frmt = new SimpleDateFormat("yyyyMMddmmss");
                student_id_new_enrolled = "" + frmt.format(today.getTime());
                s = "insert into enrolled_students (enroll_type,student_id,student_name,stundent_surname,course_id,"
                        + "birth_date,residence,phone_1,phone_2,email,course_level,enroll_date,last_reenroll_date,course_simest,class_year,course_type,user_datetime,iduser)"
                        + " values ('" + enroll_type + "','" + student_id_new_enrolled + "','" + student_name + "','"
                        + stundent_surname + "','" + course_id + "','" + birth_date + "','" + residence + "','" + phone_1
                        + "','" + phone_2 + "','" + email + "','" + course_level + "','" + enroll_date + "','"
                        + enroll_date + "','" + course_simest + "','" + class_year + "','" + course_type + "',now()," + user_register + ")";
            } else if (enroll_type.equalsIgnoreCase("Renovacao")) {
                s = "update enrolled_students set enroll_type = '" + enroll_type + "', course_id = '" + course_id + "', course_level = '" + course_level + "',"
                        + " last_reenroll_date = '" + enroll_date + "', course_simest = '" + course_simest + "', class_year = '" + class_year + "',"
                        + " course_type = '" + course_type + "', user_datetime = now(), iduser = " + user_register
                        + " where student_id = '" + student_id_new_enrolled + "'";
            } else if (enroll_type.equalsIgnoreCase("Cancelamento")) {
                s = "update enrolled_students set enroll_type = '" + enroll_type + "', user_datetime = now(), iduser = " + user_register
                        + " where student_id = '" + student_id_new_enrolled + "'";
            } else {
                retorno = new StringBuffer("Inscricao, Renovacao ou Cancelamento!");
                return;
            }
            //System.out.println("S: " + s);
            String s2 = "insert into enrolled_students_events (enroll_type,student_id,student_name,stundent_surname,course_id,course_level,enroll_date,course_simest,class_year,"
                    + "course_type,user_datetime,iduser)"
                    + " values ('" + enroll_type + "','" + student_id_new_enrolled + "','" + student_name + "','"
                        + stundent_surname + "','" + course_id + "','" + course_level
                    + "','" + enroll_date + "','" + course_simest + "','" + class_year + "','" + course_type + "',now()," + user_register + ")";
            if (enroll_type.equalsIgnoreCase("Cancelamento")) {
                s2 = "update enrolled_students_events set enroll_type = '" + enroll_type + "', user_datetime = now(), iduser = " + user_register
                        + " where student_id = '" + student_id_new_enrolled + "' and course_level = '" + course_level + "' and "
                        + " course_simest = '" + course_simest + "' and class_year = '" + class_year + "'";
            }
            //System.out.println("S: " + s2);
            String insert_rst = insert(s, s2, vldr, prvls);
            //System.out.println("insert_rst: " + insert_rst);
            String stdnt_id = student_id_new_enrolled;//vls.getStndId(enroll_type, student_name, stundent_surname, birth_date, enroll_date, user_register, phone_1, course_level);
            if(!insert_rst.contains("sucesso")){
              stdnt_id = "erro: " + vldr + ", " + insert_rst;
            }
            retorno = new StringBuffer(stdnt_id);
        } else if (a.equalsIgnoreCase("subjects_list")) {
            String stdid = request.getParameter("stdid");
            String sbjts = request.getParameter("sbjts");
            String mthpymt = request.getParameter("mthpymt");
            String enroll_pymnt = request.getParameter("enrollpymnt");
            retorno = new StringBuffer(insert_subjects_mthly_pymnt_for_student(stdid, sbjts, mthpymt, enroll_pymnt));
        } else if (a.equalsIgnoreCase("edc")) {
            String id = request.getParameter("id");
            String c = request.getParameter("c");
            String p = request.getParameter("p");
            String e = request.getParameter("e");
            if (p == null || p.trim().length() == 0 || p.equalsIgnoreCase("NA")) {
                vldr = " Ver Previlegios";
            }
            if (c == null || c.trim().length() == 0 || c.equalsIgnoreCase("NA")) {
                vldr = " Ver Categoria";
            }
            if (e == null || e.trim().length() == 0 || e.equalsIgnoreCase("NA")) {
                vldr = " Ver Estado";
            }
            if (!e.equalsIgnoreCase("0") && !e.equalsIgnoreCase("1")) {
                vldr = " O estado deve ser 1 para activo e 0 para n&atilde;o activo";
            }
            try{
                String esty = e.trim();
                e = esty;
            }catch(Exception ex){}
            if (!cssn.activeduser() && e.equals("1")) {
                //retorno = new StringBuffer("<span style='color: red;'>Esta activando mais usu&aacute;rios que a subscri&ccedil;&atilde;o, pode fazer um <em>upgrade</em> ou desativar um usu&aacute;rio!</span>");
                //return;
            }
            String z = "update users set category = '" + c + "', status = '" + e + "',roles = '" + p + "' where id = " + id;
            //System.out.println("z: " + z);
            retorno = new StringBuffer(updateobs(z, vldr, prvls));
        }  else if (a.equalsIgnoreCase("orgdt")) {
            String dg = request.getParameter("dg");
            String lg = request.getParameter("lg");
            String lc = request.getParameter("lc");
            String lnk_download = request.getParameter("lnk_download");
            if (dg == null || dg.trim().length() == 0) {
                vldr = completefield + lang.lng(current_lang, "designation");
            }
            if (lg == null || lg.trim().length() == 0) {
                vldr = completefield + lang.lng(current_lang, "logo");
            }
            if (lc == null || lc.trim().length() == 0) {
                vldr = completefield + lang.lng(current_lang, "location");
            }
            if (lnk_download == null || lnk_download.trim().length() == 0) {
                lnk_download = "localhost";
            }
            //cdg=" + vldg + "&clc=" + vlc + "&clg
            String cdg = request.getParameter("cdg");
            String clc = request.getParameter("clc");
            String clg = request.getParameter("clg");

            if (vldr == null || vldr.trim().length() == 0) {
                retorno = new StringBuffer(vls.insert_replace_desiglogloc(dg, lg, lc, cdg, clg, clc, lnk_download, user_register));
                return;
            } else {
                retorno = new StringBuffer(vldr);
                return;
            }
        } else if (a.equalsIgnoreCase("assigclass")) {
            String stnd = request.getParameter("stnd");
            String clsid = request.getParameter("clsid");
            String stndname = request.getParameter("stndname");
            String classlevel = request.getParameter("classlevel");
            String classyear = request.getParameter("classyear");
            String description = request.getParameter("description");

            s = "insert into students_by_classes (class_id,student_id,student_name,class_level,class_year,description,user_datetime,iduser)"
                    + " values ('" + clsid + "','" + stnd + "','" + stndname + "','" + classlevel + "','" + classyear + "','"
                    + description + "',now()," + user_register + ")";
            String insert_rst = insert(s, "b", vldr, prvls);
            retorno = new StringBuffer(insert_rst);
        } else if (a.equalsIgnoreCase("pymnt_inf")) {
            String ref = request.getParameter("c");
            String depositnr = request.getParameter("depositnr");
            String bnkname = request.getParameter("bnkname");
            if (depositnr == null || depositnr.trim().length() <= 2) {
                retorno = new StringBuffer("Prencher o numero de talao!");
                return;
            }
            if (bnkname == null || bnkname.trim().length() <= 2) {
                retorno = new StringBuffer("Prencher nome do banco!");
                return;
            }
            s = "update mthly_payments set amount_paid = amount_to_pay, deposit_nmb = '" + depositnr + "', bank_name = '" + bnkname 
                    + "' where ref_payment = '" + ref + "' and amount_paid = 0";
            retorno = new StringBuffer(updateobs(s, vldr, prvls));
        } else if (a.equalsIgnoreCase("lnkdwn")) {
            //System.out.println("t1: " + prvls);
            if (prvls.contains("o")) {
                SM_DownloadDB db = new SM_DownloadDB();
                retorno = new StringBuffer(db.DwnRrtn());
            } else {
                retorno = new StringBuffer("<span style='color: red;'>" + lang.lng(current_lang, "you_dont_have_enough_privileges_to_manage_and_download_backup") + "!</span>");
            }
            return;
        } else if (a.equalsIgnoreCase("sysssn")) {
            String idsys = request.getParameter("idsys");
            String pwdsys = request.getParameter("pwdsys");
            String rsact = cssn.sessionactivation(idsys, pwdsys);
            retorno = new StringBuffer(rsact);
        } else if (a.equalsIgnoreCase("pymnt_inf_special")) {
            String stdntid = request.getParameter("stdntid");
            String amountpaid = request.getParameter("amountpaid");
            String bnkname = request.getParameter("bnkname");
            String depositnr = request.getParameter("depositnr");
            String ref = request.getParameter("ref");
            if (depositnr == null || depositnr.trim().length() <= 2) {
                retorno = new StringBuffer("Prencher o numero de talao!");
                return;
            }
            if (bnkname == null || bnkname.trim().length() <= 2) {
                retorno = new StringBuffer("Prencher nome do banco!");
                return;
            }
            tblins = "mthly_payments";
            s = "insert into mthly_payments (student_id,month_nmb,amount_to_pay,amount_paid,ref_payment,course_level,course_simest,bank_name,deposit_nmb,user_datetime,iduser) "
                    + " values "
                    + "('" + stdntid + "','NA',0.00," + amountpaid + ",'" + ref + "',0,0,'" + bnkname + "','" + depositnr + "',now()," + user_register + ")";
            retorno = new StringBuffer(insert(s, "b", vldr, prvls));
        } else if (a.equalsIgnoreCase("b")) {
            String di = request.getParameter("di");
            String df = request.getParameter("df");
            String prv = request.getParameter("prv");
            String id = request.getParameter("id");
            if (di == null || di.trim().length() == 0) {
                di = "1900-01-01";
            }
            if (df == null || df.trim().length() == 0) {
                df = "2030-12-31";
            }
            String dts = "";
            String didf = "" + di + df;
            if (didf.equalsIgnoreCase("1900-01-012030-12-31")) {
                dts = "";
            } else {
                dts = " user_datetime between '" + di + "' and '" + df + "'";
            }
            if (prv.equalsIgnoreCase("gu")) {
                s = "select id,username,firstnames,surnames,category,roles,status from users";
            } else if (prv.equalsIgnoreCase("course")) {
                //System.out.println("course");
                s = "select id, course_id,  course_name from courses";
            } else if (prv.equalsIgnoreCase("subject")) {
                String c = request.getParameter("cc");
                if (c == null || c.trim().length() == 0) {
                    s = "select id, subject_id, subject_name from subjects";
                } else {
                    s = "select id, subject_id, subject_name from subjects where course_id = '" + c + "'";
                }
            } else if (prv.equalsIgnoreCase("subject_c")) {
                String c = request.getParameter("cc");
                s = "select subjects.id as id, subjects.subject_id as subject_id, subjects.subject_name as subject_name,"
                        + "courses.reg_price as reg_price,courses.mth_price as mth_price from subjects "
                        + "left join courses on subjects.course_id = courses.course_id";// where course_id = '" + c + "'";
            } else if (prv.equalsIgnoreCase("other_subject")) {
                s = "select subject_id from subjects";
            } else if (prv.equalsIgnoreCase("getcrs")) {
                String c = request.getParameter("c");
                s = "select course_id,course_name,reg_price,mth_price,course_descr from courses where course_id = '" + c + "' limit 1";
            } else if (prv.equalsIgnoreCase("getsubjecttoedit")) {
                String c = request.getParameter("sbjt");
                s = "select subject_id,subject_name,subject_descr,subj_course_level as subject_level,subj_course_simester as subject_simest "
                        + " from subjects where subject_id = '" + c + "'";
            } else if (prv.equalsIgnoreCase("studentprofile")) {
                String c = request.getParameter("c");
                s = "select enrolled_students.enroll_type as enroll_type,enrolled_students.student_id as student_id,"
                        + "enrolled_students.student_name as student_name,enrolled_students.stundent_surname as stundent_surname,"
                        + "enrolled_students.birth_date as birth_date,enrolled_students.residence as residence,"
                        + "enrolled_students.phone_1 as phone_1,enrolled_students.phone_2 as phone_2,"
                        + "enrolled_students.email as email,enrolled_students.course_id as course_id,"
                        + "enrolled_students.course_level as course_level,enrolled_students.course_simest as course_simest,"
                        + "enrolled_students.enroll_date as enroll_date,courses.reg_price as reg_price,"
                        + "courses.mth_price as mth_price from enrolled_students left join courses on "
                        + "enrolled_students.course_id = courses.course_id where enrolled_students.student_id = '" + c + "' limit 1";
            } else if (prv.equalsIgnoreCase("studentprofile_mth")) {
                String c = request.getParameter("c");
                s = "select enrolled_students.enroll_type as enroll_type,enrolled_students.student_id as student_id,"
                        + "enrolled_students.student_name as student_name,enrolled_students.stundent_surname as stundent_surname,"
                        + "enrolled_students.birth_date as birth_date,enrolled_students.residence as residence,"
                        + "enrolled_students.phone_1 as phone_1,enrolled_students.phone_2 as phone_2,"
                        + "enrolled_students.email as email,enrolled_students.course_id as course_id,"
                        + "enrolled_students.course_level as course_level,enrolled_students.course_simest as course_simest,"
                        + "enrolled_students.enroll_date as enroll_date,courses.reg_price as reg_price,"
                        + "courses.mth_price as mth_price from enrolled_students left join courses on "
                        + "enrolled_students.course_id = courses.course_id where enrolled_students.student_id = '" + c + "' limit 1";
            } else if (prv.equalsIgnoreCase("ref_cod")) {
                String stdntid = request.getParameter("stdntid");
                String c = request.getParameter("c");
                s = "select amount_to_pay,month_nmb from mthly_payments where ref_payment = '" + c + "' and student_id = '" + stdntid + "'";
            } else if (prv.equalsIgnoreCase("lists")) {
                String stdntid = request.getParameter("stdntid");
                String c = request.getParameter("c");
                String dc = request.getParameter("dc");
                if (tp.equalsIgnoreCase("ind")) {
                    if (dc.equalsIgnoreCase("ref")) {
                        s = "select * from view_mthly_payments where ref_payment = '" + c + "' and student_id = '" + stdntid + "' " + dts + "";
                    } else if (dc.equalsIgnoreCase("depdoc")) {
                        s = "select * from view_mthly_payments where deposit_nmb = '" + c + "' and student_id = '" + stdntid + "' " + dts + "";
                    } else {
                        if (dts == null || dts.trim().length() == 0) {
                        } else {
                            dts = " where " + dts;
                        }
                        s = "select * from view_mthly_payments where student_id = '" + stdntid + "' " + dts + "";
                    }
                } else if (tp.equalsIgnoreCase("a")) {
                    String dts2 = dts;
                    if (dts == null || dts.trim().length() == 0) {
                    } else {
                        dts = " where " + dts;
                    }
                    if (tlst.equalsIgnoreCase("Estudantes")) {
                        s = "select * from enrolled_students " + dts + "";
                    } else if (tlst.equalsIgnoreCase("Devedores")) {
                        s = "select * from view_mthly_payments " + dts + "";
                    } else {
                        if (dc.equalsIgnoreCase("ref")) {
                            s = "select * from view_mthly_payments where ref_payment = '" + c + "' " + dts2 + "";
                        } else if (dc.equalsIgnoreCase("depdoc")) {
                            s = "select * from view_mthly_payments where deposit_nmb = '" + c + "' " + dts2 + "";
                        } else {
                            s = "select * from view_mthly_payments " + dts + "";
                        }
                    }
                }
            } else if (prv.equalsIgnoreCase("classes_list")) {
                String yr = request.getParameter("yr");
                //s = "select * from classes where class_year = " + yr + "";
                s = "select * from classes";
            } else if (prv.equalsIgnoreCase("enroll_aut")) {
                s = "select * from enrollment_authorizations order by id desc";
            } else if(prv.equalsIgnoreCase("confirmdepnmr")){
                String c = request.getParameter("c");
                s = "select id from mthly_payments where deposit_nmb = '" + c + "'";
            } else if (prv.equalsIgnoreCase("dhs")) {
                s = "select tbl,week(user_datetime) as semana,sum(saldo) as saldo from geral where "
                        + "user_datetime between CAST('" + di + "' AS DATE) and CAST('" + df + "' AS DATE) "
                        + " group by tbl,week(user_datetime) order by week(user_datetime) asc";
            }
            //System.out.println("SSSS: " + s);//studentprofile
            retorno = new StringBuffer(buscar(s, prvls, prv));
        } else if(a.equalsIgnoreCase("cmmnts")){
           String hlpid = request.getParameter("hlpid");
           String hlpnm = request.getParameter("hlpnm");
           String hlptxt = request.getParameter("hlptxt");
           String user = request.getParameter("user");
           String sector = request.getParameter("sector");
           retorno = new StringBuffer(cssn.send_comments(hlpid, hlpnm, hlptxt, user, sector));
        }
    }

    private String updateobs(String q, String val, String pvl) {
        String b = "";
        /*if (!pvl.contains("i")) {
            return "<span style='color: red;'>N&atilde;o tem previlegios para inserir dados!</span>";
        }
        if (!pvl.contains("u")) {
            return "<span style='color: red;'>N&atilde;o tem previlegios para inserir dados!</span>";
        }
        if (val == null || val.trim().length() == 0) {
        } else {
            return "<span style='color: red;'>" + val + "!</span>";
        }*/
        try {
            con = SM_cdb.getConnection();
            if (con == null) {
                return "<span style='color: red;'>Servidor ocupado. Tente mais tarde!</span>";
            }
            con.setAutoCommit(false);
            DatabaseMetaData meta = con.getMetaData();
            if (meta.supportsTransactionIsolationLevel(con.TRANSACTION_REPEATABLE_READ)) {
                con.setTransactionIsolation(con.TRANSACTION_REPEATABLE_READ);
            }
            stmt = con.createStatement();
            String r = "" + stmt.executeUpdate(q);
            con.setAutoCommit(true);
            if (meta.supportsTransactionIsolationLevel(con.TRANSACTION_READ_COMMITTED)) {
                con.setTransactionIsolation(con.TRANSACTION_READ_COMMITTED);
            }
            //b = "<span style='color: green;'>Processado com sucesso: " + r + " linhas!</span>";
            b = "processado com sucesso!";
        } catch (Exception e) {
            b = "erro: " + e;
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
        return b;
    }

    private String insert(String sx, String rf, String val, String pvl) {
        //System.out.println("insert: " + sx + "," + rf + "," + val + "," + pvl);
        if (!pvl.contains("i")) {
            String txt = "<span style='color: red;'>N&atilde;o tem previlegios para inserir dados!</span>";
            //System.out.println("txt: " + txt);
            return txt;
        }
        if (val == null || val.trim().length() == 0) {
        } else {
            //System.out.println("txt2: " + val);
            return "<span style='color: red;'>" + val + "!</span>";
        }
        String sx1 = sx;
        String b = "";
        //System.out.println("SX: " + sx);
       
        try {
            con = SM_cdb.getConnection();
        } catch (ClassNotFoundException ex) {
        }
        try {
            stmt = con.createStatement();
        } catch (SQLException ex) {
        }
        try {
            stmt.executeUpdate(sx1);
            if (rf.contains("enrolled_students_events")) {
                //System.out.println("SX2: " + rf);
                stmt.executeUpdate(rf);
            }
            con.commit();
            stmt.close();
            b = "Processado com sucesso!";
        } catch (SQLException e) {
            b = "Erro ao processar!" + e.getMessage();
            e.printStackTrace();
        }
        return b;
    }

    private String buscar(String s, String pvl, String p) {
        Double saldo = 0.0;
        Double tb_p = 0.0;
        Double tb_e = 0.0;
        Double tb_s = 0.0;

        String tbp = "";
        String tbe = "";
        String tbs = "";
        String smns = "";
        String sn = "a";
        String sn2 = "";
        if (p.equalsIgnoreCase("getcrs") || p.equalsIgnoreCase("getsubjecttoedit")) {
        } else {
            //return "<span style='color: red;'>N&atilde;o tem previlegios para visualizar dados!</span>";
        }
        String b = "<table id=\"tblcs\" ><tr style=\"height: 46px; background-color:  #9B00FF;background: linear-gradient(to bottom, #9B00FF, white);\"><th style=\"width: 400px;\">Item 1</th><th style=\"width: 400px;\">Item 2</th>";
        if (p.equalsIgnoreCase("subject_c") || p.equalsIgnoreCase("other_subject") || p.equalsIgnoreCase("getsubjecttoedit")
                || p.equalsIgnoreCase("studentprofile_mth") || p.equalsIgnoreCase("ref_cod")
                || p.equalsIgnoreCase("lists") || p.equalsIgnoreCase("classes_list") || p.equalsIgnoreCase("enroll_aut")
                || p.equalsIgnoreCase("gu") || p.equalsIgnoreCase("confirmdepnmr") || p.equalsIgnoreCase("dhs")) {
            b = "";
        }
        try {
            con = SM_cdb.getConnection();
            if (con == null) {
                return "Servidor ocupado. Tente mais tarde!";
            }
            stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery(s);
            int y = 1;
            while (rs.next()) {
                if (p.equalsIgnoreCase("dhs")) {
                    String tbll = rs.getString("tbl");
                    String tbvls = rs.getString("saldo");

                    if (tbll == null || tbll.trim().length() == 0) {
                        tbll = "_";
                    }
                    //b += vls.dshtbls(tbll, tbvls);
                    try {
                        Double sld = Double.parseDouble(tbvls);
                        saldo = saldo + sld;
                        //System.out.println("w: " + sld + "," + saldo);
                    } catch (Exception e) {
                        // System.out.println("we: " + e.getMessage());
                    }

                    Double zz = 0.0;
                    try {
                        Double jj = Double.parseDouble(tbvls);
                        zz = jj;
                    } catch (Exception e) {
                        zz = 0.0;
                        //System.out.println("we: " + e.getMessage());
                    }

                    if (tbll.equalsIgnoreCase("purchases")) {
                        tb_p = tb_p + zz;
                        tbp += zz + ",";
                        sn2 += "purchases,";
                    } else if (tbll.equalsIgnoreCase("expenses")) {
                        tb_e = tb_e + zz;
                        tbe += zz + ",";
                        sn2 += "expenses,";
                    } else if (tbll.equalsIgnoreCase("sales")) {
                        tb_s = tb_s + zz;
                        tbs += zz + ",";
                        sn2 += "sales,";
                    }

                    if (smns == null || smns.trim().length() == 0) {
                        smns += rs.getString("semana") + ",";
                    } else if (!smns.contains(rs.getString("semana"))) {
                        smns += rs.getString("semana") + ",";
                        if (!sn.equalsIgnoreCase(rs.getString("semana"))) {
                            if (!sn2.contains("purchases")) {
                                tbp += "0.0,";
                            }
                            if (!sn2.contains("expenses")) {
                                tbe += "0.0,";
                            }
                            if (!sn2.contains("sales")) {
                                tbs += "0.0,";
                            }
                            sn2 = "";
                        }

                    }
                    sn = rs.getString("semana");
                } else if (p.equalsIgnoreCase("course") || p.equalsIgnoreCase("subject")) {
                    b += "<tr><td>";
                    if (p.equalsIgnoreCase("course")) {
                        b += "" + rs.getString("course_id") + "</td><td>" + rs.getString("course_name");
                    } else if (p.equalsIgnoreCase("subject")) {
                        b += "<a href='#' style='text-decoration: none;' onclick=\"getSubjects('" + rs.getString("subject_id") + "')\">" + rs.getString("subject_id") + "</a></td><td>" + rs.getString("subject_name");
                    }
                    /*
                    if (p.equalsIgnoreCase("course")) {
                        b += "" + rs.getString("id") + "</td><td>" + rs.getString("course_id") + "</td><td>" + rs.getString("course_name");
                    } else if (p.equalsIgnoreCase("subject")) {
                        b += "" + rs.getString("id") + "</td><td>" + rs.getString("subject_id") + "</td><td>" + rs.getString("subject_name");
                    }
                     */
                    b += "</td></tr>";
                } else if (p.equalsIgnoreCase("getcrs")) {
                    b = rs.getString("course_id") + "," + rs.getString("course_name") + "," + rs.getString("reg_price")
                            + "," + rs.getString("mth_price") + "," + rs.getString("course_descr");
                } else if (p.equalsIgnoreCase("getsubjecttoedit")) {
                    b = rs.getString("subject_id") + "," + rs.getString("subject_name") + "," + rs.getString("subject_descr")
                            + rs.getString("subject_level") + "," + rs.getString("subject_simest");
                } else if (p.equalsIgnoreCase("gu")) {
                    b += rs.getString("id") + ";" + rs.getString("username") + ";" + rs.getString("firstnames") + ";"
                            + rs.getString("surnames") + ";" + rs.getString("category") + ";"
                            + rs.getString("roles") + ";" + rs.getString("status") + ":";
                } else if (p.equalsIgnoreCase("studentprofile") || p.equalsIgnoreCase("studentprofile_mth")) {
                    b = rs.getString("enroll_type") + "," + rs.getString("student_id") + "," + rs.getString("student_name")
                            + "," + rs.getString("stundent_surname") + "," + rs.getString("course_id") + "," + rs.getString("birth_date")
                            + "," + rs.getString("residence") + "," + rs.getString("phone_1") + "," + rs.getString("phone_2")
                            + "," + rs.getString("email") + "," + rs.getString("course_level") + "," + rs.getString("enroll_date")
                            + "," + rs.getString("course_simest") + "," + rs.getString("reg_price")
                            + "," + rs.getString("mth_price");
                } else if (p.equalsIgnoreCase("enroll_aut")) {
                    b = rs.getString("id") + ";" + rs.getString("class_level") + ";" + rs.getString("class_simester") + ";"
                            + vls.getDateFromString(rs.getString("start_date")) + ";" + vls.getDateFromString(rs.getString("end_date")) + ";"
                            + rs.getString("class_year") + ";" + rs.getString("status") + ";" + vls.getDateFromString(rs.getString("user_datetime")) + ";"
                            + rs.getString("iduser") + ":";
                } else if (p.equalsIgnoreCase("subject_c")) {
                    b += "" + rs.getString("reg_price") + ":" + rs.getString("mth_price") + ":" + rs.getString("subject_id") + ",";
                } else if (p.equalsIgnoreCase("other_subject")) {
                    b += "" + rs.getString("subject_id") + ",";
                } else if (p.equalsIgnoreCase("ref_cod")) {
                    b = rs.getString("amount_to_pay") + "," + rs.getString("month_nmb");
                } else if (p.equalsIgnoreCase("classes_list")) {
                    b += rs.getString("id") + "," + rs.getString("class_id") + "," + rs.getString("resp_person_id")
                            + "," + rs.getString("resp_person_name") + "," + rs.getString("number_of_students")
                            + "," + rs.getString("class_level") + "," + rs.getString("class_year")
                            + "," + rs.getString("description") + "::";
                } else if (p.equalsIgnoreCase("lists")) {
                    if (tp.equalsIgnoreCase("ind")) {
                        String yr_mth = rs.getString("user_datetime");
                        String yr_rgstr = "";
                        String mth_rgstr = "";
                        try{
                            String w = "" + yr_mth.charAt(0) + yr_mth.charAt(1) + yr_mth.charAt(2) + yr_mth.charAt(3);
                            yr_rgstr = w;
                        }catch(Exception e){}     
                        try{
                            String w = "" + yr_mth.charAt(5) + yr_mth.charAt(6);
                            mth_rgstr = w;
                        }catch(Exception e){}  
                        DateFormat df = new SimpleDateFormat("yyyy");
                        DateFormat df2 = new SimpleDateFormat("MM");
                        Date tdy = Calendar.getInstance().getTime();
                        String stdy = df.format(tdy);
                        String stdy_mth = df2.format(tdy);
                        String year_month = "";
                        int istdy = 0;
                        int mth_rgstr2 = 0;
                        int yr_rgstr2 = 0;
                        try{
                            int z = Integer.parseInt(stdy);
                            istdy = z;
                        }catch(Exception e){}
                        try{
                            int z = Integer.parseInt(mth_rgstr);
                            mth_rgstr2 = z;
                        }catch(Exception e){}  
                        try{
                            int z = Integer.parseInt(yr_rgstr);
                            yr_rgstr2 = z;
                        }catch(Exception e){} 
                        String mth_debt = "";
                        String month_nmb = rs.getString("month_nmb");
                        if(month_nmb.equalsIgnoreCase("Janeiro")){mth_debt = "1";}
                        else if(month_nmb.equalsIgnoreCase("Fevereiro")){mth_debt = "2";}
                        else if(month_nmb.equalsIgnoreCase("Marco")){mth_debt = "3";}
                        else if(month_nmb.equalsIgnoreCase("Abril")){mth_debt = "4";}
                        else if(month_nmb.equalsIgnoreCase("Maio")){mth_debt = "5";}
                        else if(month_nmb.equalsIgnoreCase("Junho")){mth_debt = "6";}
                        else if(month_nmb.equalsIgnoreCase("Julho")){mth_debt = "7";}
                        else if(month_nmb.equalsIgnoreCase("Agosto")){mth_debt = "8";}
                        else if(month_nmb.equalsIgnoreCase("Setembro")){mth_debt = "9";}
                        else if(month_nmb.equalsIgnoreCase("Outubro")){mth_debt = "10";} 
                        else if(month_nmb.equalsIgnoreCase("Novembro")){mth_debt = "11";}
                        else if(month_nmb.equalsIgnoreCase("Dezembro")){mth_debt = "12";}
                        else if(month_nmb.equalsIgnoreCase("Inscricao")){mth_debt = "0";}
                        else{
                            mth_debt = "14";
                        }
                        int mth_debt2 = 0;
                        try{
                            int z = Integer.parseInt(mth_debt);
                            mth_debt2 = z;
                        }catch(Exception e){}                         
                        if(istdy == yr_rgstr2 && mth_debt2 <= mth_rgstr2){
                            year_month = "y";
                        } else {
                            year_month = "n";
                        }
                        b += rs.getString("id") + "," + month_nmb + "," + rs.getString("ref_payment")
                                + "," + rs.getString("deposit_nmb") + "," + rs.getString("amount_to_pay") + ","
                                + rs.getString("amount_paid") + "," + year_month + "::";
                    } else {
                        if (tlst.equalsIgnoreCase("Estudantes")) {
                            b += rs.getString("id") + "," + rs.getString("student_id") + ","
                                    + rs.getString("student_name") + " " + rs.getString("stundent_surname") + ","
                                    + rs.getString("course_level") + "," + rs.getString("course_simest") + "," + rs.getString("birth_date")
                                    + "," + rs.getString("residence") + "," + rs.getString("phone_1") + "," + rs.getString("phone_2") + ","
                                    + rs.getString("email") + "," + rs.getString("course_type") + "," + rs.getString("enroll_date") + ","
                                    + rs.getString("last_reenroll_date") + "," + rs.getString("status") + ","
                                    + rs.getString("user_datetime") + "," + rs.getString("iduser") + "::";
                        } else {
                            b += rs.getString("id") + "," + rs.getString("student_id") + ","
                                    + rs.getString("student_name") + " " + rs.getString("stundent_surname") + ","
                                    + rs.getString("course_level") + "," + rs.getString("course_simest") + "," + rs.getString("month_nmb")
                                    + "," + rs.getString("ref_payment") + "," + rs.getString("bank_name")
                                    + "," + rs.getString("deposit_nmb") + "," + rs.getString("amount_to_pay")
                                    + "," + rs.getString("amount_paid") + "," + rs.getString("user_datetime")
                                    + "," + rs.getString("iduser") + "::";
                        }
                    }
                } else if(p.equalsIgnoreCase("confirmdepnmr")){
                     b = "Este numero de talao ja esta registado na base de dados";       
                }
            }
        } catch (Exception e) {
            retorno = new StringBuffer("<div style='color: red;'>Falhou 1 , " + e.getMessage() + "tente novamente</div>");
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
        if (p.equalsIgnoreCase("getcrs") || p.equalsIgnoreCase("getsubjecttoedit") || p.equalsIgnoreCase("studentprofile")
                || p.equalsIgnoreCase("subject_c") || p.equalsIgnoreCase("other_subject") || p.equalsIgnoreCase("studentprofile_mth")
                || p.equalsIgnoreCase("ref_cod") || p.equalsIgnoreCase("lists") || p.equalsIgnoreCase("classes_list")
                || p.equalsIgnoreCase("enroll_aut") || p.equalsIgnoreCase("gu") || p.equalsIgnoreCase("confirmdepnmr")
                || p.equalsIgnoreCase("dhs")) {
        } else {
            b += "</table>";
        }
        if (p.equalsIgnoreCase("subject_c")) {
            try {
                b += ",";
                String h = b.replaceAll(",,", "");
                b = h;
            } catch (Exception e) {
            }
        } else if(p.equalsIgnoreCase("confirmdepnmr")){
              if(b == null || b.trim().length() == 0){
                  b = "Talao nao encontrado na base de dados!";
              }
        }
        //Second query in database
        if (p.equalsIgnoreCase("dhs")) {
                s = s.split("between")[1];
                s = s.split("group")[0];
                try {
                    String[] sw = s.split("and");
                    String sw1 = sw[0].trim();
                    String sw2 = sw[1].trim();
                    String tw = " CAST('" + sw1 + "' AS DATE) and CAST('" + sw2 + "' AS DATE)";
                    s = tw;
                } catch (Exception e) {
                }
                s = "select tbl,sum(saldo) as saldo from geral where user_datetime between " + s + " group by tbl";
                try {

                    con = SM_cdb.getConnection();
                    if (con == null) {
                    }
                    stmt = con.createStatement();
                    ResultSet rs = stmt.executeQuery(s);
                    while (rs.next()) {
                        String z = rs.getString("tbl");
                        String t = rs.getString("saldo");
                        b += vls.dshtbls(z, t);
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
            }
        //System.out.println("" + b);
        return b;
    }

    private String insert_subjects_mthly_pymnt_for_student(String stdid, String sbjts, String mth_pymnt, String enroll_pymnt) {
        String r = "";
        //System.out.println("stdid: " + stdid);
        //System.out.println("sbjts: " + sbjts);
        String[] stdidary = stdid.split(":");
        String stdntid = stdidary[0];
        String course_level = stdidary[1];
        String course_simest = stdidary[2];
        String sbjct = "";
        String z = "";
        try {
            con = SM_cdb.getConnection();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(SM_RestoreDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        try {
            stmt = con.createStatement();
        } catch (SQLException ex) {
            Logger.getLogger(SM_RestoreDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        int y = 0;
        try {
            for (String g : sbjts.split(":")) {
                if (g == null || g.trim().length() == 0 || g.equalsIgnoreCase("undefined")) {
                } else {
                    String[] gg = g.split(",");
                    if (course_simest.equalsIgnoreCase("Primeiro")) {
                        course_simest = "1";
                    } else if (course_simest.equalsIgnoreCase("Segundo")) {
                        course_simest = "2";
                    }
                    z = "insert into student_subjects (student_id,subject,course_level,course_simest,user_datetime,iduser) "
                            + " values "
                            + " ('" + stdntid + "','" + gg[1] + "','" + course_level + "','" + course_simest + "',now()," + user_register + ")";
                    //System.out.println("z: " + z);
                    stmt.executeUpdate(z);
                }
            }
            int i = 0;
            String valor_d = null;
            String refer = "";
            String mes_c = "";
            String cont_cc = "" + i;
            String conv = "";
            List<String> mths = new ArrayList<String>();
            if (course_simest.equals("1")) {
                mths.add("Inscricao");
                /*mths.add("Janeiro");
                mths.add("Janeiro_juro1");
                mths.add("Janeiro_juro2");
                mths.add("Janeiro_juro3");*/
                mths.add("Fevereiro");
                mths.add("Fevereiro_juro1");
                mths.add("Fevereiro_juro2");
                mths.add("Fevereiro_juro3");
                mths.add("Marco");
                mths.add("Marco_juro1");
                mths.add("Marco_juro2");
                mths.add("Marco_juro3");
                mths.add("Abril");
                mths.add("Abril_juro1");
                mths.add("Abril_juro2");
                mths.add("Abril_juro3");
                mths.add("Maio");
                mths.add("Maio_juro1");
                mths.add("Maio_juro2");
                mths.add("Maio_juro3");
                mths.add("Junho");
                mths.add("Junho_juro1");
                mths.add("Junho_juro2");
                mths.add("Junho_juro3");

            } else if (course_simest.equals("2")) {
                mths.add("Inscricao");
                mths.add("Julho");
                mths.add("Julho_juro1");
                mths.add("Julho_juro2");
                mths.add("Julho_juro3");
                mths.add("Agosto");
                mths.add("Agosto_juro1");
                mths.add("Agosto_juro2");
                mths.add("Agosto_juro3");
                mths.add("Setembro");
                mths.add("Setembro_juro1");
                mths.add("Setembro_juro2");
                mths.add("Setembro_juro3");
                mths.add("Outubro");
                mths.add("Outubro_juro1");
                mths.add("Outubro_juro2");
                mths.add("Outubro_juro3");
                mths.add("Novembro");
                mths.add("Novembro_juro1");
                mths.add("Novembro_juro2");
                mths.add("Novembro_juro3");
                /*mths.add("Dezembro");
                mths.add("Dezembro_juro1");
                mths.add("Dezembro_juro2");
                mths.add("Dezembro_juro3");*/
            } else {
            }
            Iterator ms = mths.iterator();
            Random w = new Random();
            while (ms.hasNext()) {
                String mes = (String) ms.next();
                String rf = "" + w.nextInt((9999 - 1000) + 1);
                String mth_pymnt2 = "";
                if (mes.endsWith("juro1") || mes.endsWith("juro2") || mes.endsWith("juro3")) {
                    mth_pymnt2 = "0";
                } else if (mes.endsWith("Inscricao")) {
                    mth_pymnt2 = enroll_pymnt;
                }else {
                    mth_pymnt2 = mth_pymnt;
                }
                if (cont_cc.trim().length() == 1) {
                    conv = "0" + i;
                } else if (cont_cc.length() == 2) {
                    conv = "" + i;
                } else {
                }
                i = i + 1;

                refer = "" + stdntid + "-" + conv + "-" + rf;
                z = "insert into mthly_payments (student_id,month_nmb,amount_to_pay,amount_paid,ref_payment,course_level,course_simest,bank_name,deposit_nmb,user_datetime,iduser) "
                        + " values "
                        + "('" + stdntid + "','" + mes + "','" + mth_pymnt2 + "','0.00','" + refer + "','" + course_level + "','" + course_simest + "','NA','000000',now()," + user_register + ")";
                //System.out.println("z: " + z);
                stmt.executeUpdate(z);
            }
            con.commit();
            stmt.close();
            r = "Inserido com sucesso!";
        } catch (SQLException e) {
            e.printStackTrace();
            r = "Ocorreu um erro: " + e;
        }
        return r;
    }

    public String getR() {
        return retorno.toString();
    }
}
