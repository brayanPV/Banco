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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            Banco banco = (Banco) (request.getSession().getAttribute("banquito"));
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        %>
        <a class="btnStyle" href="./index.html"> Volver </a>


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

        <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
        <script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
        <script>
            $(document).ready(function () {
                $('#table_id').DataTable();
            });

        </script>
    </body>
</body>
</html>
