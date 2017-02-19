<%@ page import="com.google.appengine.api.utils.SystemProperty" %>
<%@ page import="com.vibhuti.lms.Controller" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.SQLException" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Faculty</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <link rel="stylesheet" href="layout/styles/layout.css" type="text/css" />
</head>


<jsp:include page="header.html"></jsp:include>

<div id="mainContent" style="margin-left:35%; margin-top: 3%; ">

<h1>ADD Faculty</h1>
<form action="addUser.jsp" method="post">

    Username*         : <input required type="text" name="username"><p></p>
    Password*         : <input required type="password" name="password"><p></p>
    Password confirm* : <input required type="password" ><p></p>
    Subject1*         : <input required type="text" name="subject1"><p></p>
    Subject2*         : <input required type="text" name="subject2"><p></p>
    Subject3          :  <input type="text" name="subject3"><p></p>
    Subject4          :  <input type="text" name="subject4"><p></p>


    <input type="submit" value="Add user !">


</form>




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
                url = "jdbc:mysql://localhost:3306/expensemanager";

                // jdbc:mysql://ip-address-of-google-cloud-sql-instance:3306/guestbook?user=root
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

    if(request.getMethod().equalsIgnoreCase("post"))
    {


        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String subject1 = request.getParameter("subject1");
        String subject2 = request.getParameter("subject2");
        String subject3 = request.getParameter("subject3");
        String subject4 = request.getParameter("subject4");


        Controller controller = new Controller();


        Exception e = controller.createFacultyAccount(con ,username, password, subject1, subject2 , subject3, subject4);

        if(e==null)out.append("<h1>Successful</h1>");
        else out.append(e + "");
    }

%>



</div>
</body>
</html>