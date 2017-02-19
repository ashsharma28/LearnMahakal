<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Faculty Dashboard</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <link rel="stylesheet" href="layout/styles/layout.css" type="text/css" />
</head>

<jsp:include page="header.html"></jsp:include><p></p>

<div id="mainContent" style="margin-left:35%; margin-top: 3%; ">

<p></p>
<p></p>

<%
    String username = (String) session.getAttribute("username");
    String subject1 = (String) session.getAttribute("subject1");
    String subject2 = (String) session.getAttribute("subject2");
    String subject3 = (String) session.getAttribute("subject3");
    String subject4 = (String) session.getAttribute("subject4");
%>
<%="Welcome " + username %>
<h4>Subjects:-
    <%=subject1%> &nbsp;
    <%=subject2%>&nbsp;
    <%=subject3%>&nbsp;
    <%=subject4%>&nbsp;
</h4>

<h2>
    <ul>
        <li><a href="uploadFiles.jsp">Upload files for students</a></li>
    </ul>
</h2>



<form action="AdminPanel.jsp">
    <input type="submit" value="Logout" name="logout">
</form>


<%
    if(request.getMethod().equalsIgnoreCase("get")){
        if(request.getParameter("logout")!=null  && request.getParameter("logout").equals("Logout") )
        {
            session.invalidate();
            response.sendRedirect("index.html");
        }
    }
%>

    </div>

</body>
</html>