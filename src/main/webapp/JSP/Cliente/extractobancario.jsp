<%-- 
    Document   : extractobancario
    Created on : 2/12/2019, 05:14:00 PM
    Author     : stive
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
            <jsp:include page="../../templates/navInicio.jsp"/>
            <hr>
            <div class="row justify-content-center">
                <div class="col-lg-5">
                    <div class="card">
                        <div class="card-body">
                            <div class="card-title">Ver Extracto</div>
                            <form action="extracto.do">
                                <div class="form-group">
                                    <label for="">Cedula</label>
                                    <input type="number" class="form-control" min=0 max="9999999999" placeholder="Ingrese Cedula" Required name="cedula">
                                </div>

                                <div class="form-group">
                                    <label for="">Fecha Inico</label>
                                    <input type="date" class="form-control" required name="fechaInicio">
                                </div>
                                <div class="form-group">
                                    <label for="">Fecha FIn</label>
                                    <input type="date" class="form-control" required name="fechaFinal">
                                </div>
                                <button type="submit" class="btn btn-primary">Ver Extracto</button>
                            </form>
                        </div>
                    </div>
                </div>

            </div>
            <jsp:include page="../../templates/footer.jsp"/> 
    </body>

</html>

