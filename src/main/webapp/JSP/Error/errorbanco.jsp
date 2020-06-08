<%-- 
    Document   : errorbanco
    Created on : 30/11/2019, 03:25:54 PM
    Author     : stive
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            String error=(String)(request.getSession().getAttribute("error"));
        %>
        <h1 class="register-title">Hubo un error: <%=error%></h1>
        <p>
            <a href="./index.jsp">Regresar a Inicio</a>
        </p>
    </body>
</html>
