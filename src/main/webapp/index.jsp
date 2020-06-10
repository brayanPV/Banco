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
        <nav class="navbar sticky-top navbar-light bg-light">
                <a class="navbar-brand" href="index.jsp">Inicio</a>
                <a class="navbar-brand" href="./JSP/Cliente/registrarcliente.jsp">Registrar Cliente</a>
                <a class="navbar-brand" href="./Redir?url=./JSP/Cuenta/registrarcuenta.jsp">Registrar Cuenta</a>
                <a class="navbar-brand" href="./Redir?url=./JSP/Movimiento/registrarmovimiento.jsp">Registrar Movimiento</a>
                <a class="navbar-brand" href="./Redir?url=./JSP/Cliente/verClientes.jsp">Ver Clientes</a>
                <a class="navbar-brand" href="./Redir?url=./JSP/Cuenta/verCuentas.jsp">Ver Cuentas</a>
                <a class="navbar-brand" href="./Redir?url=./JSP/Cliente/extractobancario.jsp">Ver Extracto</a>
            </nav>

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