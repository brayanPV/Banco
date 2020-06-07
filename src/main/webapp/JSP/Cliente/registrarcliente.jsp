<%-- 
    Document   : registrarcliente
    Created on : 30/11/2019, 10:20:03 AM
    Author     : stive
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!DOCTYPE html>
<html lang="">

    <head>
         <jsp:include page="../../templates/meta.jsp"/>
        <title></title>
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
            <jsp:include page="../../templates/navInicio.jsp"/>
            <hr>
            <div class="row justify-content-center">
                <div class="col-lg-5">
                    <div class="card">
                        <div class="card-body">
                            <div class="card-title">Registrar Cliente</div>
                            <form action="../../registrarCliente.do" name="registrar">
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
            <footer class="text-center">
                <p>
                    Copyright © AÑO Autor: | Cod: | Correo:
                    Desarrollo De Aplicaciones Web - Ing.Sistemas - UFPS
                </p>
            </footer>
        </div>




      <jsp:include page="../../templates/footer.jsp"/> 
    </body>

</html>

