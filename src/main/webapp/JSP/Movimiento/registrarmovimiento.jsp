<%-- 
    Document   : registrarMovimiento
    Created on : 1/12/2019, 03:52:29 PM
    Author     : stive
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!DOCTYPE html>
<html lang="">

    <head>
        <jsp:include page="../../templates/meta.jsp"/>
        <title>Registrar Movomiento</title>
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
        <jsp:include page="../../templates/navInicio.jsp"/>
        <div class="container">

            <hr>
            <div class="row justify-content-center">
                <div class="col-lg-5">
                    <div class="card">
                        <div class="card-body">
                            <div class="card-title">Registrar Movimiento</div>
                            <form name="operadcion" method="post" action="Movimiento">
                                <div class="form-group">
                                    <label for="">Seleccionar Operacion</label>
                                    <select name="tipo" required id="dropdown" class="form-control">
                                        <option value="1">Consignar</option>
                                        <option value="2">Retirar</option>
                                        <option value="3">Transferir</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="">Cuenta Origen</label>
                                    <input type="number" class="form-control" min=0 max="9999999999" placeholder="Ingrese cuenta origen" value="" name="cuentaOrigen" required>
                                </div>
                                <div class="form-group">
                                    <label for="">Cuenta Destino</label>
                                    <input type="number" class="form-control" min=0 max="9999999999" placeholder="Ingrese cuenta destino" value="" id="destino" disabled name="cuentaDestino">
                                </div>
                                <div class="form-group">
                                    <label for="">Monto</label>
                                    <input type="number" min="1" max="999999999" name="valor" required class="form-control">
                                </div>
                                <div class="form-group">
                                    <label for="">Fecha</label>
                                    <input type="date" class="form-control" name="fecha" required>
                                </div>

                                <button type="submit" class="btn btn-primary">Registrar</button>
                            </form>
                        </div>
                    </div>
                </div>

            </div>

        </div>

        <jsp:include page="../../templates/footer.jsp"/> 




        <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
        <script type="text/javascript">
            $(document).ready(function () {

                $('#dropdown').change(function () {
                    if ($(this).val() == 3) {
                        $('#destino').prop("disabled", false);
                    } else {
                        $('#destino').prop("disabled", true);
                    }
                });

            });

        </script>
    </body>

</html>

