<%-- 
    Document   : extratoexitoso
    Created on : 2/12/2019, 05:43:13 PM
    Author     : stive
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="DTO.Movimiento"%>
<%@page import="NEGOCIO.Banco"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="../../templates/meta.jsp"/>
        <title>JSP Page</title>
    </head>
    <body>
        <%
            Banco banco = (Banco) (request.getSession().getAttribute("banquito"));
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        %>
        <a class="btnStyle" href="../../index.jsp"> Volver </a>


        <table border="1" id="table_id" class="display">
            <thead>
                <tr>
                    <th>id</th>
                    <th>fecha</th>
                    <th>valor</th>
                    <th>nroCuenta</th>
                    <th>idTipoMovimiento</th>

                </tr>
            </thead>
            <tbody>
                <% for (Movimiento mov : banco.getMovimientos()) {%>
                <tr>
                    <td> <%=mov.getId()%> </td>
                    <td><%=format.format(mov.getFecha())%></td>
                    <td> <%=mov.getValor()%></td>
                    <td><%=mov.getNroCuenta()%></td>
                    <td><%=mov.getIdTipoMovimiento()%></td>
                </tr>
                <% }%>
            </tbody>
        </table>

        <jsp:include page="../../templates/footer.jsp"/> 
        <script>
            $(document).ready(function () {
                $('#table_id').DataTable();
            });

        </script>
    </body>
</body>
</html>
