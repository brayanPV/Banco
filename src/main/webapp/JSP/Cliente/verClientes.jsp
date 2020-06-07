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
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.datatables.net/1.10.20/css/jquery.dataTables.min.css">
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

</html>
