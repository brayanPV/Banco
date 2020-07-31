<%-- 
    Document   : registrarcliente
    Created on : 30/11/2019, 10:20:03 AM
    Author     : stive
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="">

    <head>
        <jsp:include page="../../templates/meta.jsp"/>
        <title>Registrar Cliente</title>
    </head>

    <body>
        <header>
            <div class="container">
                <div class="row">
                    <div class="col-lg-3">
                        <img src="../../images/logo.png" class="img-fluid" alt="Responsive image" alt="Lorem Ipsum Bank">
                    </div>
                    <div class="col-lg-9 align-self-center">
                        <h1>Lorem Ipsum</h1>
                        <h1>Bank</h1>
                    </div>
                </div>
            </div>
        </header>


        <div class="container">
            <nav class="navbar sticky-top navbar-expand-lg navbar-dark secondary-color">
                <!-- Navbar brand -->
                <a class="navbar-brand d-none d-xs-none d-sm-none d-md-none d-lg-block" href="../../index.jsp">Banco</a>

                <a class="navbar-brand d-block d-xs-none d-sm-block d-md-block d-lg-none" href="../../index.jsp">
                    <img src="../../images/logo.png" width="50" class="d-inline-block align-middle" alt="">Banco</a>

            </nav>
            <hr>
            <div class="row justify-content-center">
                <div class="col-lg-5">
                    <div class="card animated fadeIn">
                        <div class="card-body">
                            <div class="card-title">Registrar Cliente</div>
                            <form method="post" action="../../RegistrarCliente" name="registrar">
                                <div class="form-group">
                                    <label for="">Cedula</label>
                                    <input type="number" class="form-control" min=0 max="9999999999" placeholder="Ingrese Cedula" name="cedula" required>
                                </div>
                                <div class="form-group">
                                    <label for="">Nombre</label>
                                    <input type="text" class="form-control" placeholder="Ingrese Nombre" name="nombre" required>
                                </div>
                                <div class="form-group">
                                    <label for="">Email</label>
                                    <input type="email" class="form-control" placeholder="Ingrese email" name="email" required>
                                </div>
                                <div class="form-group">
                                    <label for="">Direccion</label>
                                    <input type="text" class="form-control"  placeholder="Ingrese Direccion" name="direccion" required>
                                </div>
                                <div class="form-group">
                                    <label for="">Telefono</label>
                                    <input type="number" class="form-control" min=0 max="9999999999" placeholder="Ingrese numero" name="telefono" required>
                                </div>
                                <div class="form-group">
                                    <label for="">Fecha</label>
                                    <input type="date" class="form-control" name="fecha" required>
                                </div>
                                <button type="submit" class="btn btn-primary" name="registar">Registrar</button>
                            </form>
                        </div>
                    </div>
                </div>

            </div>

        </div>




        <jsp:include page="../../templates/footer.jsp"/> 
    </body>

</html>

