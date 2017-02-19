<%@ page import="com.google.appengine.api.utils.SystemProperty" %>
<%@ page import="com.vibhuti.lms.Controller" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.sql.Connection" %>

<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Update</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <link rel="stylesheet" href="layout/styles/layout.css" type="text/css" />
</head>

<jsp:include page="header.html"></jsp:include>

<div id="mainContent" style="margin-left:35%; margin-top: 3%; ">

<%!
    private boolean delete(String selected) {

        Controller controller = new Controller();

       boolean b = controller.deleteFacultyWithQuery(con, "DELETE FROM users WHERE username= '" + selected + "';");

        return b;

    }

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



<form action="update.jsp"  method="post" >




<%
    Controller controller = new Controller();

    ResultSet resultSet = controller.readFacultyAccount(con, "SELECT * FROM users");


    try {

        out.append("<table border=1px>");



        out.append("\n" +
                "<tr>\n" +
                "  <th>Select Faculty</th>\n" +
                "  <th>Subject1</th>\n" +
                "  <th>Subject2</th>\n" +
                "  <th>Subject3</th>\n" +
                "  <th>Subject4</th>\n" +
                "  <th>Username</th>\n" +
                "</tr>\n");

        while (resultSet.next()){

            if(resultSet.getString(5).equals("admingullu"))continue;

            out.append("<tr>");



            out.append("<td>");
            out.append("<input type=\"radio\" name=\"selected\" value=\""+ resultSet.getString(5)+ "\" required>");
            out.append("</td>");

            out.append("<td>");
            out.append(resultSet.getString(1)+ "\t");
            out.append("</td>");

            out.append("<td>");
            out.append(resultSet.getString(2)+ "\t");
            out.append("</td>");

            out.append("<td>");
            out.append(resultSet.getString(3)+ "\t");
            out.append("</td>");

            out.append("<td>");
            out.append(resultSet.getString(4)+ "\t");
            out.append("</td>");

            out.append("<td>");
            out.append(resultSet.getString(5)+ "\t");
            out.append("</td>");

            out.append("</tr>");
        }

        out.append("</table>");


    } catch (SQLException e) {
        e.printStackTrace();
    } catch (IOException e) {
        e.printStackTrace();
    }


%>

<br>
    <input type="submit" value="Update" name="action">
    <input type="submit" value="delete" name="action">

</form>



<%

    if(request.getMethod().equalsIgnoreCase("post") && request.getParameter("selected")!=null )
    {
        String selected = request.getParameter("selected");
        String action = request.getParameter("action");

        if(action.equals("delete")){

            if(delete(selected))
                out.append("<h2>Successfully deleted faculty: <u>").append(selected).append("</u></h2>");
            }

        else if(action.equals("Update")){


            out.print("\n" +
                    "<form action=\"update.jsp\" method=\"post\">\n" +
                    "    <h3>Update the values for:</h3>\n" +
                    "\n" +
                    "    <h3>Username         :<u>\""+selected+"\":</u> </h3>" +
                    "<input  type=\"hidden\" value=\""+selected+"\" name=\"username\" > <p></p>" +
                    "    Subject1*         : <input required type=\"text\" name=\"subject1\"><p></p>\n" +
                    "    Subject2*         : <input required type=\"text\" name=\"subject2\"><p></p>\n" +
                    "    Subject3         : <input type=\"text\" name=\"subject3\"><p></p>\n" +
                    "    Subject4         : <input type=\"text\" name=\"subject4\"><p></p>\n" +
                    "\n" +
                    "\n" +
                    "    <input type=\"submit\" value=\"Update Subjects\" name=\"updater\">\n" +
                    "\n" +
                    "\n" +
                    "</form>\n");



        }



    }



    if(request.getMethod().equalsIgnoreCase("post") && request.getParameter("updater")!=null )
    {
        String username = request.getParameter("username");
        String subject1 = request.getParameter("subject1");
        String subject2 = request.getParameter("subject2");
        String subject3 = request.getParameter("subject3");
        String subject4 = request.getParameter("subject4");

        Exception b = controller.updateFacultyInfoWithQuery(con, "UPDATE users SET subject1='"+subject1+"', subject2='"+subject2+"', subject3='"+subject3+"', subject4='"+subject4+"' WHERE username='"+username+"';");

        if(b==null) out.append("Success");
        else out.append("Failed, Reason:\n ->  " + b );

    }
%>




</div>
</body>
</html>