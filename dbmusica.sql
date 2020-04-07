-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 07-04-2020 a las 21:16:27
-- Versión del servidor: 10.4.11-MariaDB
-- Versión de PHP: 7.4.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `dbmusica`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_I_Cancion` (`pgenero` VARCHAR(50), `pautor` VARCHAR(50), `ptitulo` VARCHAR(50), `pfecha` DATE, `pduracion` VARCHAR(50), `pusuario_idusuario` INT)  BEGIN		
		INSERT INTO cancion(genero,autor,titulo,fecha,duracion,usuario_idusuario)
		VALUES(pgenero,pautor,ptitulo,pfecha,pduracion,pusuario_idusuario);
        END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_I_ListadeReproduccion` (IN `pnombreLista` VARCHAR(45), IN `pUsuario_Idusuario` INT)  BEGIN		
		INSERT INTO lista_reproduccion(nombreLista,Usuario_Idusuario)
		VALUES(pnombreLista,pUsuario_Idusuario);	
        END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_I_Usuario` (`pNombre` VARCHAR(50), `pApellido` VARCHAR(50), `pCorreo` VARCHAR(50), `pPassword` VARCHAR(50))  BEGIN		
		INSERT INTO usuario(Nombre,Apellido,Correo,Password)
		VALUES(pNombre,pApellido,pCorreo,pPassword);
        END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_Cancion` ()  BEGIN
		SELECT * FROM cancion;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_CancionPorParametro` (`pcriterio` VARCHAR(20), `pbusqueda` VARCHAR(20))  BEGIN
	IF pcriterio = "Id" THEN
		SELECT c.idcancion,c.genero,c.autor,c.titulo,c.fecha, c.duracion, c.usuario_idusuario FROM Cancion AS c WHERE c.idcancion=pbusqueda;
	ELSEIF pcriterio = "genero" THEN
		SELECT c.idcancion,c.genero,c.autor,c.titulo,c.fecha, c.duracion, c.usuario_idusuario FROM Cancion AS c WHERE c.genero LIKE CONCAT("%",pbusqueda,"%");
	ELSEIF pcriterio = "autor" THEN
		SELECT   c.idcancion,c.genero,c.autor,c.titulo,c.fecha, c.duracion, c.usuario_idusuario FROM Cancion AS c WHERE c.autor LIKE CONCAT("%",pbusqueda,"%");
   ELSEIF pcriterio = "titulo" THEN
		SELECT   c.idcancion,c.genero,c.autor,c.titulo,c.fecha, c.duracion, c.usuario_idusuario FROM Cancion AS c WHERE c.titulo LIKE CONCAT("%",pbusqueda,"%");
	ELSEIF pcriterio = "fecha" THEN
		SELECT   c.idcancion,c.genero,c.autor,c.titulo,c.fecha, c.duracion, c.usuario_idusuario FROM Cancion AS c WHERE c.fecha=pbusqueda ;
    ELSEIF pcriterio = "usuario" THEN
		SELECT   c.idcancion,c.genero,c.autor,c.titulo,c.fecha, c.duracion, c.usuario_idusuario FROM Cancion AS c WHERE c.usuario_idusuario=pbusqueda ;
    ELSE
		SELECT c.idcancion,c.genero,c.autor,c.titulo,c.fecha, c.duracion, c.usuario_idusuario FROM Cancion AS c;
	END IF; 
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_Listadereproduccion` ()  BEGIN
		SELECT * FROM lista_reproduccion;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_ListaPorParametro` (IN `pcriterio` VARCHAR(20), IN `pbusqueda` VARCHAR(20))  BEGIN
	IF pcriterio = "id" THEN
		SELECT lr.IdLista_reproduccion,lr.nombrelista,lr.usuario_idusuario FROM lista_reproduccion AS lr WHERE lr.IdLista_reproduccion =pbusqueda;
	ELSEIF pcriterio = "nombre" THEN
		SELECT lr.IdLista_reproduccion,lr.nombrelista,lr.usuario_idusuario FROM lista_reproduccion AS lr WHERE lr.nombrelista LIKE CONCAT("%",pbusqueda,"%");
        ELSEIF pcriterio = "usuario"THEN
        SELECT lr.IdLista_reproduccion,lr.nombrelista,lr.usuario_idusuario FROM lista_reproduccion AS lr WHERE lr.usuario_idusuario = pbusqueda;
        ELSE
		SELECT lr.IdLista_reproduccion,lr.nombrelista,lr.usuario_idusuario FROM lista_reproduccion AS lr;
	END IF; 
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_Usuario` ()  BEGIN
		SELECT * FROM usuario;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_UsuarioPorParametro` (`pcriterio` VARCHAR(20), `pbusqueda` VARCHAR(20))  BEGIN
	IF pcriterio = "Id" THEN
		SELECT c.IdUsuario,c.Nombre,c.Apellido,c.Correo,c.Password FROM usuario AS c WHERE c.IdUsuario=pbusqueda;
	ELSEIF pcriterio = "Nombre" THEN
		SELECT c.IdUsuario,c.Nombre,c.Apellido,c.Correo,c.Password FROM usuario AS c WHERE c.Nombre LIKE CONCAT("%",pbusqueda,"%");
	ELSEIF pcriterio = "Apellido" THEN
		SELECT c.IdUsuario,c.Nombre,c.Apellido,c.Correo,c.Password FROM usuario AS c WHERE c.Apellido LIKE CONCAT("%",pbusqueda,"%");
   ELSEIF pcriterio = "Correo" THEN
		SELECT c.IdUsuario,c.Nombre,c.Apellido,c.Correo,c.Password FROM usuario AS c WHERE c.Correo LIKE CONCAT("%",pbusqueda,"%");
	ELSE
		SELECT c.IdUsuario,c.Nombre,c.Apellido,c.Correo,c.Password FROM usuario AS c;
	END IF; 
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_U_Cancion` (IN `pidcancion` INT, IN `pgenero` VARCHAR(50), IN `pautor` VARCHAR(50), IN `ptitulo` VARCHAR(50), IN `pfecha` DATE, IN `pduracion` VARCHAR(50))  BEGIN
		UPDATE cancion SET
			genero=pgenero,
			autor=pautor,
			titulo=ptitulo,
            fecha=pfecha,
			duracion=pduracion
		WHERE idcancion = pidcancion;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_U_ListadeReproduccion` (IN `pidLista_reproduccion` INT, IN `pnombreLista` VARCHAR(45))  BEGIN
		UPDATE lista_reproduccion SET
			nombreLista=pnombreLista
		WHERE IdLista_reproduccion= pidLista_reproduccion;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_U_Usuario` (`pIdUsuario` INT, `pNombre` VARCHAR(50), `pApellido` VARCHAR(50), `pCorreo` VARCHAR(50), `pPassword` VARCHAR(50))  BEGIN
		UPDATE usuario SET
			Nombre=pNombre,
			Apellido=pApellido,
			Correo=pCorreo,
			Password=pPassword
		WHERE IdUsuario = pIdUsuario;
	END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cancion`
--

CREATE TABLE `cancion` (
  `idcancion` int(11) NOT NULL,
  `genero` varchar(45) DEFAULT NULL,
  `autor` varchar(45) DEFAULT NULL,
  `titulo` varchar(45) DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `duracion` varchar(45) DEFAULT NULL,
  `usuario_idusuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `cancion`
--

INSERT INTO `cancion` (`idcancion`, `genero`, `autor`, `titulo`, `fecha`, `duracion`, `usuario_idusuario`) VALUES
(1, 'Baladas', 'Juanes', 'La camisa negra', '1998-03-27', '3:34', 1),
(2, 'Rock', 'Aerosmith', 'Crazy', '2000-08-13', '4:45', 1),
(4, 'Baladas', 'Shakira', 'La despedida', '2008-03-02', '4min', 4),
(5, 'rockola', 'segundo rosero', '17 a?os', '2014-04-20', '3 minutos', 11),
(6, 'cumbia', 'nanpa basico', 'mujer perfecta', '1970-01-01', '3 minutos', 17),
(7, 'requetoon', 'camilo', 'por primera vez ', '1970-01-01', '3 minutos', 17),
(8, 'bomba', 'windison', 'un millon de cosas', '2014-04-10', '4 minutos', 11),
(9, 'dfgdf', 'dfgdf', 'dfgdfg', '2020-04-15', 'sfgfdg', 11),
(10, 'rock', 'pxndx', 'enfermedad en casa', '2013-04-12', '3 minutos', 18);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cancion_has_lista_reproduccion`
--

CREATE TABLE `cancion_has_lista_reproduccion` (
  `cancion_idcancion` int(11) NOT NULL,
  `Lista_reproduccion_idLista_reproduccion` int(11) NOT NULL,
  `orden` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lista_reproduccion`
--

CREATE TABLE `lista_reproduccion` (
  `IdLista_reproduccion` int(11) NOT NULL,
  `nombrelista` varchar(45) DEFAULT NULL,
  `usuario_idusuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `lista_reproduccion`
--

INSERT INTO `lista_reproduccion` (`IdLista_reproduccion`, `nombrelista`, `usuario_idusuario`) VALUES
(13, 'baladas', 4),
(14, 'rock ', 2),
(17, 'cumbia', 17),
(18, 'electronica', 17),
(19, 'todo un poco ', 11),
(20, 'evelin', 17),
(21, 'yo', 11),
(22, 'marlon', 11),
(23, 'rock', 11),
(24, 'canciones que me gustan ', 19);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `IdUsuario` int(11) NOT NULL,
  `Nombre` varchar(45) DEFAULT NULL,
  `Apellido` varchar(45) DEFAULT NULL,
  `Correo` varchar(45) DEFAULT NULL,
  `Password` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`IdUsuario`, `Nombre`, `Apellido`, `Correo`, `Password`) VALUES
(1, 'JUAN', 'chimarro', 'jchimarro', ''),
(2, 'jefferson javier', 'Quilo c', 'jq@gmail.com', ''),
(4, 'Andres', 'Pujota', 'pj@gmail.com', '12334'),
(8, 'jhonder pedro', 'farinango', 'jf@gmail.com', 'asdff'),
(11, 'veronica', 'campues', 'vc@gmail.com', '1234'),
(17, 'hernan ', 'cholca', 'hernanc@gmail.com', ''),
(18, 'fabricio', 'campues ', 'fabricampues34@gmail.com', '12345'),
(19, 'alison', 'cacuango', 'alicacuango@gmail.com', '123456');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `cancion`
--
ALTER TABLE `cancion`
  ADD PRIMARY KEY (`idcancion`),
  ADD KEY `fk_cancion_usuario_idx` (`usuario_idusuario`);

--
-- Indices de la tabla `cancion_has_lista_reproduccion`
--
ALTER TABLE `cancion_has_lista_reproduccion`
  ADD PRIMARY KEY (`cancion_idcancion`,`Lista_reproduccion_idLista_reproduccion`),
  ADD KEY `fk_cancion_has_Lista_reproduccion_Lista_reproduccion1_idx` (`Lista_reproduccion_idLista_reproduccion`),
  ADD KEY `fk_cancion_has_Lista_reproduccion_cancion1_idx` (`cancion_idcancion`);

--
-- Indices de la tabla `lista_reproduccion`
--
ALTER TABLE `lista_reproduccion`
  ADD PRIMARY KEY (`IdLista_reproduccion`),
  ADD KEY `fk_Lista_reproduccion_usuario1_idx` (`usuario_idusuario`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`IdUsuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `cancion`
--
ALTER TABLE `cancion`
  MODIFY `idcancion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `lista_reproduccion`
--
ALTER TABLE `lista_reproduccion`
  MODIFY `IdLista_reproduccion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `IdUsuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `cancion`
--
ALTER TABLE `cancion`
  ADD CONSTRAINT `fk_cancion_usuario` FOREIGN KEY (`usuario_idusuario`) REFERENCES `usuario` (`IdUsuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `cancion_has_lista_reproduccion`
--
ALTER TABLE `cancion_has_lista_reproduccion`
  ADD CONSTRAINT `fk_cancion_has_Lista_reproduccion_Lista_reproduccion1` FOREIGN KEY (`Lista_reproduccion_idLista_reproduccion`) REFERENCES `lista_reproduccion` (`idLista_reproduccion`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_cancion_has_Lista_reproduccion_cancion1` FOREIGN KEY (`cancion_idcancion`) REFERENCES `cancion` (`idcancion`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `lista_reproduccion`
--
ALTER TABLE `lista_reproduccion`
  ADD CONSTRAINT `fk_Lista_reproduccion_usuario1` FOREIGN KEY (`usuario_idusuario`) REFERENCES `usuario` (`IdUsuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
