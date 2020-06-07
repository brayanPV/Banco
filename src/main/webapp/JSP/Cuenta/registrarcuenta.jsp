<%-- 
    Document   : registrarcuenta
    Created on : 30/11/2019, 03:14:44 PM
    Author     : stive
--%>

<%@page import="java.util.Iterator"%>
<%@page import="DTO.Cliente"%>
<%@page import="NEGOCIO.Banco"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!DOCTYPE html>
<html lang="">

<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
	<title></title>
</head>

<body>
	<header>
		<div class="container">
			<div class="row">
				<div class="col-lg-3">
                                    <img src="./images/logo.png" class="img-fluid" alt="Responsive image" alt="Lorem Ipsum Bank">
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
		<div class="row justify-content-center">
			<div class="col-lg-5">
				<div class="card">
					<div class="card-body">
						<div class="card-title">Registrar Cuenta</div>
						<form action="registrarCuenta.do">
							<div class="form-group">
								<label for="">Numero de cuenta</label>
								<input type="number" class="form-control" min=0 max="9999999999" placeholder="Ingrese numero de cuenta" name="nrocuenta">
							</div>
							<div class="form-group">
								<label for="">Tipo cuenta</label>
								<select name="tipocuenta" id="" class="form-control">
									<option> Elegir tipo </option>
									<option value="1"> Cuenta Ahorros</option>
									<option value="2"> Cuenta Corriente </option>
								</select>
							</div>
							<div class="form-group">
								<label for="">Cliente</label>
								<input type="number" class="form-control" placeholder="Ingrese Cedula del Cliente" required name="cedula" min="0" max="9999999999">
							</div>
							
							<button type="submit" class="btn btn-primary">Registrar</button>
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




	<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
</body>

</html>
