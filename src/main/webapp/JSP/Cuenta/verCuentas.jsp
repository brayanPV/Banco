<%-- 
    Document   : verCuentas
    Created on : 1/12/2019, 11:15:14 PM
    Author     : Carlos Jose
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="NEGOCIO.Banco"%>
<%@page import="DTO.Cuenta"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="">

    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-1.11.3.min.js"></script>

        <link href="https://nightly.datatables.net/css/jquery.dataTables.css" rel="stylesheet" type="text/css" />
        <script src="https://nightly.datatables.net/js/jquery.dataTables.js"></script>

        <link href="https://cdn.datatables.net/rowgroup/1.0.2/css/rowGroup.dataTables.min.css" rel="stylesheet" type="text/css" />
        <script src="https://cdn.datatables.net/rowgroup/1.0.2/js/dataTables.rowGroup.min.js"></script>
        <script src="https://cdn.datatables.net/buttons/1.2.2/js/buttons.html5.js"></script>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/pdfmake.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/vfs_fonts.js"></script>

        <link href="https://cdn.datatables.net/buttons/1.5.1/css/buttons.dataTables.css" rel="stylesheet" type="text/css" />
        <script src="https://cdn.datatables.net/buttons/1.5.1/js/dataTables.buttons.js"></script>
        <script src="https://cdn.datatables.net/buttons/1.5.1/js/buttons.colVis.min.js"></script>
        <script type="text/javascript" language="javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>

        <script src="https://cdn.datatables.net/buttons/1.5.1/js/buttons.colVis.min.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="../../templates/meta.jsp"/>
        <title>Ver Cuentas</title>
    </head>

    <body>
        <% Banco banco = new Banco();
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");%>
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
                            <div class="card-title">Ver Cuentas</div>
                            <table border="1" id="example" class="display">
                                <thead>
                                    <tr>
                                        <th>Numero Cuenta</th>
                                        <th>Saldo</th>
                                        <th>Creacion</th>
                                        <th>Cedula</th>
                                        <th>Tipo</th>
                                    </tr>
                                </thead>
                                <tfoot>
                                    <tr>
                                        <th>Numero Cuenta</th>
                                        <th>Saldo</th>
                                        <th>Creacion</th>
                                        <th>Cedula</th>
                                        <th>Tipo</th>
                                    </tr>
                                </tfoot>
                                <tbody>
                                    <% for (Cuenta cuentas : banco.getCuentas()) {%>
                                    <tr>
                                        <td><%= cuentas.getNroCuenta()%></td>
                                        <td><%= cuentas.getSaldo()%></td>
                                        <td><%= format.format(cuentas.getFechacreacion())%></td>
                                        <td><%= cuentas.getCedula().getCedula()%> </td>
                                        <td><%= cuentas.getTipo().getNombre()%></td>
                                    </tr>
                                    <% }%>


                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

            </div>

        </div>







        <script>
            $(document).ready(function () {
                var collapsedGroups = {};

                var table = $('#example').DataTable({
                    "columnDefs": [{
                            "visible": false,
                            "targets": [3]
                        }],
                    order: [
                        [3, 'asc']
                    ],
                    rowGroup: {
                        // Uses the 'row group' plugin
                        dataSrc: 3,
                        startRender: function (rows, group) {
                            var collapsed = !!collapsedGroups[group];

                            rows.nodes().each(function (r) {
                                r.style.display = collapsed ? 'none' : '';
                            });

                            // Add category name to the <tr>. NOTE: Hardcoded colspan
                            return $('<tr/>')
                                    .append('<td colspan="8">' + group + ' (' + rows.count() + ')</td>')
                                    .attr('data-name', group)
                                    .toggleClass('collapsed', collapsed);
                        }
                    }
                });

                $('#example tbody').on('click', 'tr.group-start', function () {
                    var name = $(this).data('name');
                    collapsedGroups[name] = !collapsedGroups[name];
                    table.draw(false);
                });

            });

        </script>
        <footer class="page-footer font-small mdb-color lighten-3 mt-4">

            <!-- Footer Elements -->

            <!-- Footer Elements -->

            <!-- Copyright -->
            <div class="footer-copyright text-center py-3">
                <a href="https://github.com/brayanPV/"> Brayan Stiven Palomino - 1151370</a><br>
                <a href="https://github.com/kose25/"> Carlos Jose Pablos - 1151383</a><br>
                <a href="#"> Juan Jose - 1151148</a><br>
                © 2020 Copyright
            </div>

        </footer>


    </body>

</html>
