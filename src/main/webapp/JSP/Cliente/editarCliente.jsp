<%-- 
    Document   : editarCliente
    Created on : 1/12/2019, 08:34:40 PM
    Author     : Carlos Jose
--%>

<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="DTO.Cliente"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="">

<head>
    <jsp:include page="../../templates/meta.jsp"/>
	<title></title>
</head>

<body>
<% Cliente clientesito = (Cliente) (request.getSession().getAttribute("cliente"));
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
    %>
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
						<div class="card-title">Actualizar Cliente</div>
						<form action="actualizarCliente" name="registrar">
							<div class="form-group">
								<label for="">Cedula</label>
								<input type="number" class="form-control" min=0 max="9999999999" placeholder="Ingrese Cedula" name="cedula" readonly value="<%= clientesito.getCedula()%>">
							</div>
							<div class="form-group">
								<label for="">Nombre</label>
								<input type="text" class="form-control" placeholder="Ingrese Nombre" name="nombre" value="<%= clientesito.getNombre()%>">
							</div>
							<div class="form-group">
								<label for="">Email</label>
								<input type="email" class="form-control" placeholder="Ingrese email" name="email" value="<%= clientesito.getEmail()%>">
							</div>
							<div class="form-group">
								<label for="">Direccion</label>
								<input type="text" class="form-control"  placeholder="Ingrese Direccion" name="direccion" value="<%= clientesito.getDircorrespondencia()%>">
							</div>
							<div class="form-group">
								<label for="">Telefono</label>
								<input type="number" class="form-control" min=0 max="9999999999" placeholder="Ingrese numero" name="telefono" value="<%= clientesito.getTelefono()%>">
							</div>
							<div class="form-group">
								<label for="">Fecha</label>
								<input type="date" class="form-control" name="fecha" value="<%= format.format(clientesito.getFechanacimiento())%>">
							</div>
							<button type="submit" class="btn btn-primary" name="registar">Actualizar</button>
						</form>
					</div>
				</div>
			</div>

		</div>
		
	</div>

        <jsp:include page="../../templates/footer.jsp"/>                                                 
</body>

</html>

