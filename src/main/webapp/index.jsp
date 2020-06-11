<%-- 
    Document   : index
    Created on : 7/06/2020, 05:10:02 PM
    Author     : stive
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="">

    <head>
        <title>Banco Web UFPS</title>
        <jsp:include page="templates/meta.jsp"/>
    </head>

    <body>
        <header class="d-none d-lg-block">
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
        <!--Navbar-->
        <nav class="navbar sticky-top navbar-expand-lg navbar-dark secondary-color">

            <!-- Navbar brand -->
            <a class="navbar-brand d-none d-xs-none d-sm-none d-md-none d-lg-block" href="index.jsp">Banco</a>

            <a class="navbar-brand d-block d-xs-none d-sm-block d-md-block d-lg-none" href="index.jsp">
                <img src="images/logo.svg" width="50" class="d-inline-block align-middle" alt="">Banco</a>

            <!-- Collapse button -->
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#basicExampleNav" aria-controls="basicExampleNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <!-- Collapsible content -->
            <div class="collapse navbar-collapse" id="basicExampleNav">

                <!-- Links -->
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item">
                        <a class="nav-link"  href="./JSP/Cliente/registrarcliente.jsp"><i class="fas fa-user-plus"></i>Registrar Clientes
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="./Redir?url=./JSP/Cuenta/registrarcuenta.jsp"><i class="fas fa-user-plus"></i>Registrar Cuenta</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="./Redir?url=./JSP/Movimiento/registrarmovimiento.jsp"><i class="fas fa-exchange-alt"></i>Registrar Movimiento</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="./Redir?url=./JSP/Cliente/verClientes.jsp"><i class="fas fa-users"></i>Ver Clientes</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="./Redir?url=./JSP/Cuenta/verCuentas.jsp"><i class="fas fa-file-invoice"></i>Ver Cuentas</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="./Redir?url=./JSP/Cliente/extractobancario.jsp"><i class="fas fa-file-invoice-dollar"></i>Ver Extracto</a>
                    </li>
                </ul>

                <!-- Links -->

            </div>
            <!-- Collapsible content -->

        </nav>
        <!--/.Navbar-->

        <div class="container">

            <hr>
            <div class="row">
                <div class="col-lg-4 animated fadeInUp">
                    <div class="card text-center">
                        <!-- Card image -->
                        <img class="card-img-top" src="https://d29fhpw069ctt2.cloudfront.net/icon/image/73384/preview.svg" alt="Card image cap">
                        <div class="card-body">
                            <h5 class="card-title">Servicios</h5>
                            <p class="card-text">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Necessitatibus odit sapiente illum laboriosam voluptatibus repellendus ducimus corrupti rem, reiciendis accusantium aperiam nihil, eaque excepturi est maxime earum eum, doloremque deleniti!</p>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 animated fadeInUp delay-1s">
                    <div class="card text-center">
                        <!-- Card image -->
                        <img class="card-img-top" src="https://d29fhpw069ctt2.cloudfront.net/icon/image/84650/preview.svg" alt="Card image cap">
                        <div class="card-body">
                            <h5 class="card-title">Contacto</h5>
                            <p class="card-text">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Necessitatibus odit sapiente illum laboriosam voluptatibus repellendus ducimus corrupti rem, reiciendis accusantium aperiam nihil, eaque excepturi est maxime earum eum, doloremque deleniti!</p>
                        </div>
                    </div>
                </div>


                <div class="col-lg-4 animated fadeInUp delay-2s">
                    <div class="card text-center">
                        <img class="card-img-top" src="https://d29fhpw069ctt2.cloudfront.net/icon/image/120771/preview.svg" alt="Card image cap">
                        <div class="card-body">
                            <h5 class="card-title">Soporte</h5>
                            <p class="card-text">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Necessitatibus odit sapiente illum laboriosam voluptatibus repellendus ducimus corrupti rem, reiciendis accusantium aperiam nihil, eaque excepturi est maxime earum eum, doloremque deleniti!</p>
                        </div>
                    </div>
                </div>

            </div>
        </div>
        <jsp:include page="templates/footer.jsp"/> 
    </body>

</html>