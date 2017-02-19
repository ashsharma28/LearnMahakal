<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 19-May-16
  Time: 9:24 PM
  To change this template use File | Settings | File Templates.
--%>


<%@ page import="com.google.appengine.api.utils.SystemProperty" %>
<%@ page import="com.vibhuti.lms.Controller" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>



<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Uploads</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <link rel="stylesheet" href="layout/styles/layout.css" type="text/css" />
    <link rel="stylesheet" href="layout/styles/pure-min.css" type="text/css" />


</head>

<jsp:include page="header.html"></jsp:include>



<%!
    Connection con;

    public void jspInit()
    {
        try {
            String url ;

            if (SystemProperty.environment.value() == SystemProperty.Environment.Value.Production)
            {
                Class.forName("com.mysql.jdbc.GoogleDriver");
                url = "jdbc:google:mysql://expensemanager28:expensedatabase/learnmahakal";
            }

            else
            {
                Class.forName("com.mysql.jdbc.Driver");
                url = "jdbc:mysql://localhost:3306/expensemanager";                  // jdbc:mysql://ip-address-of-google-cloud-sql-instance:3306/guestbook?user=root
            }
            con = DriverManager.getConnection(url, "root", "");



        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>


<%
    Controller controller = new Controller();
    ResultSet resultSet = controller.getFiles(con, "Select * from filesrecord where subject='" + request.getParameter("subject") + "'");

    try {
        out.append("<table class=\"pure-table\" >");


        out.append("<form action=\"download.jsp\" >");

        out.append("\n" +
                "<tr>\n" +
                "  <th>Description</th>\n" +
                "  <th>File Name</th>\n" +
                "  <th>Download</th>\n" +
                "</tr>\n");


        while (resultSet.next()){
            out.append("<tr class=\"pure-table-odd\">");

            out.append("<td>");
            out.append(resultSet.getString(2)+ "\t");
            out.append("</td>");

            out.append("<td>");
            String path = resultSet.getString(3);
            /*String finalPath =  "download.jsp?" + URLEncoder.encode(path.substring(path.indexOf("\\data\\") + 6), "UTF-8");*/
            out.append(path.substring(path.indexOf("\\data\\")+6)+ "\t");
            out.append("</td>");


            out.append("<td>");
                out.append("<input type=\"submit\" name=\"fileName\" value=\""+path.substring(path.indexOf("\\data\\")+6)+"\">");
            out.append("</td>");

            out.append("</tr>");
        }

        out.append("</table>");

    } catch (SQLException e) {
        e.printStackTrace();
    }


%>


</body>
</html>
