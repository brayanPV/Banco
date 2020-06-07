<%-- 
    Document   : verClientes
    Created on : 1/12/2019, 08:33:23 PM
    Author     : Carlos Jose
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="DTO.Cliente"%>
<%@page import="NEGOCIO.Banco"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="">
    <% Banco banco = new Banco();
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
    %> 

    <head>
         <jsp:include page="../../templates/meta.jsp"/>
        <title></title>
    </head>

    <body>
        <header>
            <div class="container">
                <div class="row">
                    <div class="col-lg-3">
                        <img src="images/logo.png" class="img-fluid" alt="Responsive image" alt="Lorem Ipsum Bank">
                    </div>
                    <div class="col-lg-9 align-self-center">
                        <h1>Lorem Ipsum</h1>
                        <h1>Bank</h1>
                    </div>
                </div>
            </div>
        </header>

        <div class="container">
            <nav class="navbar sticky-top navbar-light bg-light">
                <a class="navbar-brand" href="./index.html">Inicio</a>
            </nav>
            <hr>
            <div class="row">
                <div class="col-lg-12">
                    <div class="card">
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

                                    <% for (Cliente clientes : banco.getClientes()) {%>
                                    <tr>
                                        <td> <%=clientes.getCedula()%> </td>
                                        <td> <%=clientes.getNombre()%></td>
                                        <td><%=format.format(clientes.getFechanacimiento())%></td>
                                        <td><%=clientes.getDircorrespondencia()%></td>
                                        <td><%=clientes.getTelefono()%></td>
                                        <td><%=clientes.getEmail()%></td>
                                        <td><a href="EditarCliente?cedula=<%=clientes.getCedula()%>">Editar</a></td>
                                    </tr>
                                    <% }%>


                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

            </div>
            <footer class="text-center">
                <p>
                    Copyright © AÑO Autor: | Cod: | Correo:
                    Desarrollo De Aplicaciones Web - Ing.Sistemas - UFPS
                </p>
            </footer>
        </div>




        <jsp:include page="../../templates/footer.jsp"/> 
        <script>
            $(document).ready(function () {
                $('#table_id').DataTable();
            });

        </script>
    </body>

</html>
