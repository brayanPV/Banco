<%-- 
    Document   : verClientes
    Created on : 1/12/2019, 08:33:23 PM
    Author     : Carlos Jose
--%>


<%@ page import="DTO.Cliente"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="">

    <head>
        <jsp:include page="../../templates/meta.jsp"/>
        <title>Ver Clientes</title>
    </head>

    <body>
        <header>
            <div class="container">
                <div class="row">
                    <div class="col-lg-3">
                        <img src="images/logo.svg" class="img-fluid" alt="Responsive image" alt="Lorem Ipsum Bank">
                    </div>
                    <div class="col-lg-9 align-self-center">
                        <h1>Lorem Ipsum</h1>
                        <h1>Bank</h1>
                    </div>
                </div>
            </div>
        </header>
        <jsp:include page="../../templates/navInicio.jsp"/>
        <div class="container">

            <hr>
            <div class="row">
                <div class="col-lg-12">
                    <div class="card animated fadeIn">
                        <div class="card-body">
                            <div class="card-title">Ver Clientes</div>
                            <table border="1" id="table_id" class="display">
                                <thead>
                                    <tr>
                                        <th>cedula</th>
                                        <th>nombre</th>
                                        <th>fecha nacimiento</th>
                                        <th>direccion</th>
                                        <th>telefono</th>
                                        <th>email</th>
                                        <th>Editar</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <jsp:useBean id="cDAO" class="DAO.ClienteJpaController" scope="request"></jsp:useBean>


                                    <c:forEach var="cliente" items="${cDAO.findClienteEntities()}">
                                        <tr>
                                            <td><c:out value="${cliente.getCedula()}"/></td>  
                                            <td><c:out value="${cliente.getNombre()}"/></td> 
                                            <td><c:out value="${cliente.getFechanacimiento()}"/></td> 
                                            <td><c:out value="${cliente.getDircorrespondencia()}"/></td> 
                                            <td><c:out value="${cliente.getTelefono()}"/></td> 
                                            <td><c:out value="${cliente.getEmail()}"/></td> 
                                            <td><a href="EditarCliente?cedula=${cliente.getCedula()}">Editar</a></td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

            </div>

        </div>




        <jsp:include page="../../templates/footer.jsp"/> 
        <script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
        <script>
            $(document).ready(function () {
                $('#table_id').DataTable();
            });

        </script>
    </body>

</html>
