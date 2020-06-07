<%-- 
    Document   : errorCta
    Created on : 30/11/2019, 03:23:22 PM
    Author     : stive
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <%
            String error=(String)(request.getSession().getAttribute("error"));
        %>
    <body>
        <h1>La esta cagando pai, pero con las cuentas <%=error%></h1>
    </body>
</html>
