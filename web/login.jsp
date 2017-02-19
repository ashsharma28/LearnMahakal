<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 19-May-16
  Time: 9:24 PM
  To change this template use File | Settings | File Templates.
--%>


<%@ page import="com.google.appengine.api.utils.SystemProperty" %>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>



<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Login</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <link rel="stylesheet" href="layout/styles/layout.css" type="text/css" />
</head>




<jsp:include page="header.html"></jsp:include>
<div id="mainContent" style="margin-left:35%; margin-top: 3%; ">





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

      String username = request.getParameter("username");
      String password = request.getParameter("password");

      if(username==null || password==null )response.sendRedirect("login.html");

      try {
        PreparedStatement preparedStatement =  con.prepareStatement("SELECT * From  users where username=?");
        preparedStatement.setString(1, username);
        ResultSet resultSet = preparedStatement.executeQuery();


          if(resultSet.next())
        {
            if(password.equals(resultSet.getString(6)) )
          {

              session.setAttribute("username", username);
              session.setAttribute("subject1", resultSet.getString(1));
              session.setAttribute("subject2", resultSet.getString(2));
              session.setAttribute("subject3", resultSet.getString(3));
              session.setAttribute("subject4", resultSet.getString(4));


              if (username.equals("admingullu"))
            {
                //BLOCK FOR CHECKING IF THE ADMIN HAS LOGGED IN
                response.sendRedirect("AdminPanel.jsp");
            }
            else
            {
            //BLOCK FOR CHECKING IF THE OTHER USER HAS LOGGED IN
               response.sendRedirect("UserDashboard.jsp");
            }

          }
          else
                out.append("Password you entered is wrong");
        }
        else
                out.append("Invalid username.");





      } catch (SQLException e)
        {
            e.printStackTrace();
        }
    %>





</div>

</body>
</html>
