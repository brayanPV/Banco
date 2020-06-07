-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 07-06-2020 a las 23:53:32
-- Versión del servidor: 10.4.11-MariaDB
-- Versión de PHP: 7.4.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `banco`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `cedula` int(20) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `fechanacimiento` date NOT NULL,
  `dircorrespondencia` varchar(100) NOT NULL,
  `telefono` int(11) NOT NULL,
  `email` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`cedula`, `nombre`, `fechanacimiento`, `dircorrespondencia`, `telefono`, `email`) VALUES
(88, 'marco editado', '1980-01-06', 'cll nueva vida', 55588, 'm@ufps.edu.co'),
(89, 'pepe editado', '1988-01-20', 'av 0 con 4', 96325, 'adsd@nadie.com'),
(100, 'Jose editado', '1997-01-25', 'nada editado', 2222, 'nada@editado.com'),
(123, 'pedro bootstrap', '2019-01-05', 'calle 156', 123, 'ep@pedro.com'),
(542, 'Jesus', '2019-01-28', 'calle t', 412, 'Jesus@jesus.com'),
(555, 'yyyyy', '2019-01-04', 'calle 2', 234, 'we@email.com'),
(645, 'alex', '2019-01-11', 'calle prueba', 123, 'alex@gmail.com'),
(963, 'marco', '2019-01-01', 'sasda', 444, 'madarme@gmail.com'),
(1090, 'brayan', '2019-01-29', 'calle 4', 1090, 'brayanstivenp578@gmail.com'),
(1111, 'aaaa', '2019-01-06', 'calle a', 11, 'a@a.com'),
(1234, 'test', '2019-01-03', 'adasd', 212032153, 'test@test.cp'),
(1459, 'kevin', '2019-01-30', 'calle 98', 456, 'k@kevin.com'),
(1541, 'carlos', '2019-01-05', 'calle 3', 123, 'c@gmail.com'),
(5871, 'Daniel', '1998-01-05', 'calle daniel', 4555, 'daniel@daniel.com'),
(12345, 'miguel', '2019-01-28', 'calle 52', 12, 'm@miguel.com'),
(963852, 'ultima prueba', '2019-01-02', 'a', 11354, 's@f.a'),
(23378336, 'bootstrap', '2015-01-27', '', 1231, 'q@q.q');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cuenta`
--

CREATE TABLE `cuenta` (
  `nroCuenta` int(11) NOT NULL,
  `saldo` double NOT NULL DEFAULT 0,
  `fechacreacion` date NOT NULL,
  `cedula` int(11) NOT NULL,
  `tipo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `cuenta`
--

INSERT INTO `cuenta` (`nroCuenta`, `saldo`, `fechacreacion`, `cedula`, `tipo`) VALUES
(55, 22, '2019-12-01', 1111, 1),
(189, 600000, '3919-12-15', 100, 1),
(236, 0, '2019-12-02', 963, 1),
(255, 22000, '1907-07-12', 1111, 1),
(1225, 0, '1907-07-12', 1111, 1),
(2558, 0, '2020-01-01', 1111, 1),
(8982, 0, '1907-07-12', 1111, 1),
(25548, 0, '3920-01-01', 1111, 1),
(74712, 20000, '2019-12-03', 5871, 1),
(75319, 0, '2019-12-02', 555, 2),
(89915, 142000, '2019-12-01', 1090, 1),
(123544, 0, '2019-12-01', 1111, 1),
(136974, 89451, '2019-12-01', 645, 1),
(654893, 30000, '2019-12-03', 5871, 2),
(741852, 0, '2019-12-03', 963852, 1),
(894718, 0, '2019-01-01', 1111, 1),
(963852, 20500, '2019-12-03', 100, 1),
(545454888, 0, '2019-12-01', 1111, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `movimiento`
--

CREATE TABLE `movimiento` (
  `id` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `valor` int(10) NOT NULL,
  `nroCuenta` int(10) NOT NULL,
  `idTipoMovimiento` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `movimiento`
--

INSERT INTO `movimiento` (`id`, `fecha`, `valor`, `nroCuenta`, `idTipoMovimiento`) VALUES
(1, '2019-01-01', 1562400, 136974, 1),
(2, '2019-01-03', 789451, 189, 1),
(3, '2019-01-01', 152000, 89915, 1),
(4, '2019-01-01', 100000, 189, 2),
(5, '2019-01-01', 10000, 89915, 2),
(6, '2019-01-01', 89451, 189, 2),
(7, '2019-01-01', 89451, 136974, 1),
(8, '2019-01-03', 22000, 255, 1),
(9, '2019-01-02', 20500, 963852, 1),
(10, '2019-01-20', 20000, 74712, 1),
(11, '2019-01-28', 30000, 654893, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo`
--

CREATE TABLE `tipo` (
  `id` int(11) NOT NULL,
  `nombre` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tipo`
--

INSERT INTO `tipo` (`id`, `nombre`) VALUES
(1, 'ahorros'),
(2, 'corriente');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipomovimiento`
--

CREATE TABLE `tipomovimiento` (
  `id` int(11) NOT NULL,
  `descripcion` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tipomovimiento`
--

INSERT INTO `tipomovimiento` (`id`, `descripcion`) VALUES
(1, 'consignar'),
(2, 'retirar');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`cedula`);

--
-- Indices de la tabla `cuenta`
--
ALTER TABLE `cuenta`
  ADD PRIMARY KEY (`nroCuenta`),
  ADD KEY `cedula` (`cedula`),
  ADD KEY `tipo` (`tipo`);

--
-- Indices de la tabla `movimiento`
--
ALTER TABLE `movimiento`
  ADD PRIMARY KEY (`id`),
  ADD KEY `nroCuenta` (`nroCuenta`),
  ADD KEY `idTipoMovimiento` (`idTipoMovimiento`);

--
-- Indices de la tabla `tipo`
--
ALTER TABLE `tipo`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tipomovimiento`
--
ALTER TABLE `tipomovimiento`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `movimiento`
--
ALTER TABLE `movimiento`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `tipo`
--
ALTER TABLE `tipo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `tipomovimiento`
--
ALTER TABLE `tipomovimiento`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `cuenta`
--
ALTER TABLE `cuenta`
  ADD CONSTRAINT `Cuenta_ibfk_1` FOREIGN KEY (`cedula`) REFERENCES `cliente` (`cedula`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Cuenta_ibfk_2` FOREIGN KEY (`tipo`) REFERENCES `tipo` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `movimiento`
--
ALTER TABLE `movimiento`
  ADD CONSTRAINT `Movimiento_ibfk_1` FOREIGN KEY (`nroCuenta`) REFERENCES `cuenta` (`nroCuenta`),
  ADD CONSTRAINT `Movimiento_ibfk_2` FOREIGN KEY (`idTipoMovimiento`) REFERENCES `tipomovimiento` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
