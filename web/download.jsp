<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 20-May-16
  Time: 1:47 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Download</title>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
  <link rel="stylesheet" href="layout/styles/layout.css" type="text/css" />
</head>


<%
  if(request.getParameter("attendanceName")!=null){
    response.sendRedirect("attendance/" + request.getParameter("attendanceName"));
  }
  else response.sendRedirect("data/" + request.getParameter("fileName"));
%>
</body>
</html>
