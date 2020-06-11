<%-- 
    Document   : extratoexitoso
    Created on : 2/12/2019, 05:43:13 PM
    Author     : stive
--%>

<%@ page import="DTO.Movimiento"%>
<%@ page import="DTO.Cuenta"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="../../templates/meta.jsp"/>
        <title>JSP Page</title>
    </head>
    <body>
        <a class="btnStyle" href="index.jsp"> Volver </a>
        <% int cta = (int) request.getSession().getAttribute("banquito");
            String cli = String.valueOf(cta);
            request.setAttribute("cli", cli);
        %>
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
                <jsp:useBean id="cDAO" class="DAO.CuentaJpaController" scope="request"></jsp:useBean>
                <jsp:useBean id="mDAO" class="DAO.MovimientoJpaController" scope="request"></jsp:useBean>
            <p><c:out value="${cta}"/></p>
            <c:forEach var="movimiento" items="${mDAO.findMovimientoEntities()}">
                <c:forEach var="cuenta" items="${cDAO.findCuentaEntities()}"> 
                    <c:choose>
                        <c:when test="${cli eq cuenta.getCedula().toString() and cuenta.getNroCuenta().toString() eq movimiento.getNroCuenta().toString()}">
                            
                                <tr>
                                    <td> <c:out value="${movimiento.getId()}"/></td>
                                    <td> <c:out value="${movimiento.getFecha()}"/></td>
                                    <td> <c:out value="${movimiento.getValor()}"/></td>
                                    <td> <c:out value="${movimiento.getNroCuenta().toString()}"/></td>
                                    <td> <c:out value="${movimiento.getIdTipoMovimiento().toString()}"/></td>
                                </tr>
                        </c:when>
                    </c:choose>
                </c:forEach>
            </c:forEach>
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
