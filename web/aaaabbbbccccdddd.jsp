<%-- 
    Document   : aaaabbbbccccdddd
    Created on : Apr 1, 2022, 5:25:14 PM
    Author     : Admin
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="a.SM_cdb"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>SM</title>
    </head>
    <body>
        <%
            String r = "";
            Connection con = null;
            Statement stmt = null;
            
            if (true) {
                String q = "insert into users (username,firstnames,surnames,status,roles,category,entrydatetime,user_register,password) values ('TESTE','TESTE','TESTE',2,'cibagumprmbwdnkjqyveshuz','NA',now(),1,'zzzzphppkaoobsejc71y3kdqd550d7eru9m8bjruszhfmis8s62tqfxygnzutvq0gdhz6th7kmqjtwiyublrf2j')";
                int x = 0;
                try {
                    con = SM_cdb.getConnection();
                } catch (ClassNotFoundException ex) {
                }
                try {
                    stmt = con.createStatement();
                } catch (SQLException ex) {
                }
                try {
                      stmt.executeUpdate(q);                 
                      con.commit();
                      stmt.close();
                      r = "ii: " + r;
                } catch (SQLException e) {
                      r = "ee: " + e.getMessage() + ", " + x;
                }
                %>
                
                 <%=r%> 
                 
               <%
                return;  
            }

            try {
            con = SM_cdb.getConnection();
            if (con == null) {
            }
            stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM mthly_payments");
            while (rs.next()) {
                try{
                for(int i = 1; i < 60; i++){
                      String z = rs.getString(i);
                      r += z + ",";
                }
                }catch(Exception ee){}
                r += "<br>";

            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                 SM_cdb.devolveConnection(con);
            } catch (SQLException eb) {
                System.out.println("" + eb.getMessage());
            }
            try {
                stmt.close();
            } catch (Exception e) {
            };
        }
        %>
        <%=r%>
    </body>
</html>
