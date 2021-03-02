/*
Navicat MariaDB Data Transfer

Source Server         : MariaDB10
Source Server Version : 100503
Source Host           : localhost:3307
Source Database       : repote-de-incidentes

Target Server Type    : MariaDB
Target Server Version : 100503
File Encoding         : 65001

Date: 2021-03-02 14:49:32
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for cliente
-- ----------------------------
DROP TABLE IF EXISTS `cliente`;
CREATE TABLE `cliente` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `razon_social` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cuit` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of cliente
-- ----------------------------
INSERT INTO `cliente` VALUES ('1', 'Bayer', '30503811061');
INSERT INTO `cliente` VALUES ('2', 'Siemens Energy', '30503364898');

-- ----------------------------
-- Table structure for especialidad
-- ----------------------------
DROP TABLE IF EXISTS `especialidad`;
CREATE TABLE `especialidad` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of especialidad
-- ----------------------------
INSERT INTO `especialidad` VALUES ('1', 'Instalaciones');
INSERT INTO `especialidad` VALUES ('2', 'Actualizaciones');
INSERT INTO `especialidad` VALUES ('3', 'Redes');
INSERT INTO `especialidad` VALUES ('4', 'Sistemas de Archivos');
INSERT INTO `especialidad` VALUES ('5', 'Seguridad Informática');

-- ----------------------------
-- Table structure for especialidad_tecnico
-- ----------------------------
DROP TABLE IF EXISTS `especialidad_tecnico`;
CREATE TABLE `especialidad_tecnico` (
  `tecnico_id` int(11) NOT NULL,
  `especialidad_id` int(11) NOT NULL,
  PRIMARY KEY (`tecnico_id`,`especialidad_id`),
  KEY `IDX_484A6B08841DB1E7` (`tecnico_id`),
  KEY `IDX_484A6B0816A490EC` (`especialidad_id`),
  CONSTRAINT `FK_484A6B0816A490EC` FOREIGN KEY (`especialidad_id`) REFERENCES `especialidad` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_484A6B08841DB1E7` FOREIGN KEY (`tecnico_id`) REFERENCES `tecnico` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of especialidad_tecnico
-- ----------------------------
INSERT INTO `especialidad_tecnico` VALUES ('1', '1');
INSERT INTO `especialidad_tecnico` VALUES ('1', '2');
INSERT INTO `especialidad_tecnico` VALUES ('1', '3');
INSERT INTO `especialidad_tecnico` VALUES ('1', '4');
INSERT INTO `especialidad_tecnico` VALUES ('1', '5');
INSERT INTO `especialidad_tecnico` VALUES ('2', '2');
INSERT INTO `especialidad_tecnico` VALUES ('2', '5');
INSERT INTO `especialidad_tecnico` VALUES ('3', '3');
INSERT INTO `especialidad_tecnico` VALUES ('3', '4');
INSERT INTO `especialidad_tecnico` VALUES ('4', '4');
INSERT INTO `especialidad_tecnico` VALUES ('4', '5');
INSERT INTO `especialidad_tecnico` VALUES ('5', '5');

-- ----------------------------
-- Table structure for especialidad_tipo_de_problema
-- ----------------------------
DROP TABLE IF EXISTS `especialidad_tipo_de_problema`;
CREATE TABLE `especialidad_tipo_de_problema` (
  `tipo_de_problema_id` int(11) NOT NULL,
  `especialidad_id` int(11) NOT NULL,
  PRIMARY KEY (`tipo_de_problema_id`,`especialidad_id`),
  KEY `IDX_218B95D6E7B77340` (`tipo_de_problema_id`),
  KEY `IDX_218B95D616A490EC` (`especialidad_id`),
  CONSTRAINT `FK_218B95D616A490EC` FOREIGN KEY (`especialidad_id`) REFERENCES `especialidad` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_218B95D6E7B77340` FOREIGN KEY (`tipo_de_problema_id`) REFERENCES `tipo_de_problema` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of especialidad_tipo_de_problema
-- ----------------------------
INSERT INTO `especialidad_tipo_de_problema` VALUES ('1', '1');
INSERT INTO `especialidad_tipo_de_problema` VALUES ('1', '2');
INSERT INTO `especialidad_tipo_de_problema` VALUES ('2', '2');
INSERT INTO `especialidad_tipo_de_problema` VALUES ('3', '3');
INSERT INTO `especialidad_tipo_de_problema` VALUES ('4', '4');
INSERT INTO `especialidad_tipo_de_problema` VALUES ('5', '5');
INSERT INTO `especialidad_tipo_de_problema` VALUES ('6', '5');

-- ----------------------------
-- Table structure for estado_incidente
-- ----------------------------
DROP TABLE IF EXISTS `estado_incidente`;
CREATE TABLE `estado_incidente` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `final` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of estado_incidente
-- ----------------------------
INSERT INTO `estado_incidente` VALUES ('1', 'Abierto', '0');
INSERT INTO `estado_incidente` VALUES ('2', 'En proceso', '0');
INSERT INTO `estado_incidente` VALUES ('3', 'Cerrado', '1');

-- ----------------------------
-- Table structure for incidente
-- ----------------------------
DROP TABLE IF EXISTS `incidente`;
CREATE TABLE `incidente` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `servicio_contratado_id` int(11) DEFAULT NULL,
  `tecnico_id` int(11) DEFAULT NULL,
  `posible_problema_id` int(11) DEFAULT NULL,
  `estado_id` int(11) DEFAULT NULL,
  `fecha_alta` date NOT NULL,
  `posible_fecha_resolucion` date NOT NULL,
  `descripcion_del_problema` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `consideraciones` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_cerrado` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_128580815354BD7D` (`servicio_contratado_id`),
  KEY `IDX_12858081841DB1E7` (`tecnico_id`),
  KEY `IDX_128580813583DAC` (`posible_problema_id`),
  KEY `IDX_128580819F5A440B` (`estado_id`),
  CONSTRAINT `FK_128580813583DAC` FOREIGN KEY (`posible_problema_id`) REFERENCES `posible_problema` (`id`),
  CONSTRAINT `FK_128580815354BD7D` FOREIGN KEY (`servicio_contratado_id`) REFERENCES `servicio_contratado` (`id`),
  CONSTRAINT `FK_12858081841DB1E7` FOREIGN KEY (`tecnico_id`) REFERENCES `tecnico` (`id`),
  CONSTRAINT `FK_128580819F5A440B` FOREIGN KEY (`estado_id`) REFERENCES `estado_incidente` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of incidente
-- ----------------------------
INSERT INTO `incidente` VALUES ('1', '1', '3', '13', '1', '2021-03-02', '2021-03-02', 'No puede conectarse a ninguna red wifi.', null, null);

-- ----------------------------
-- Table structure for posible_problema
-- ----------------------------
DROP TABLE IF EXISTS `posible_problema`;
CREATE TABLE `posible_problema` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tipo_id` int(11) DEFAULT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tiempo_de_resolucion_estimado_en_horas` double NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_267C4385A9276E6C` (`tipo_id`),
  CONSTRAINT `FK_267C4385A9276E6C` FOREIGN KEY (`tipo_id`) REFERENCES `tipo_de_problema` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of posible_problema
-- ----------------------------
INSERT INTO `posible_problema` VALUES ('1', '1', 'Requisitos del sistema para instalar el Sistema Operativo', '1');
INSERT INTO `posible_problema` VALUES ('2', '1', 'Errores al actualizar el Sistema Operativo', '3');
INSERT INTO `posible_problema` VALUES ('3', '1', 'Reinstalación de Sistema Operativo', '8');
INSERT INTO `posible_problema` VALUES ('4', '1', 'Reestablecer el Sistema Operativo a un punto de Restauración', '5');
INSERT INTO `posible_problema` VALUES ('5', '2', 'Instalación de una impresora', '3');
INSERT INTO `posible_problema` VALUES ('6', '2', 'Actualizar el controlador de la Impresora', '1');
INSERT INTO `posible_problema` VALUES ('7', '2', 'Ver la cola de Impresión', '1');
INSERT INTO `posible_problema` VALUES ('8', '2', 'Actualización de Drivers', '3');
INSERT INTO `posible_problema` VALUES ('9', '2', 'Problemas con Sonidos', '2');
INSERT INTO `posible_problema` VALUES ('10', '2', 'Problemas con Bluetooth', '2');
INSERT INTO `posible_problema` VALUES ('11', '2', 'Problemas con pantallas inalámbricas', '2');
INSERT INTO `posible_problema` VALUES ('12', '2', 'Instalación de un escáner', '2');
INSERT INTO `posible_problema` VALUES ('13', '3', 'Conectar con WiFi', '1');
INSERT INTO `posible_problema` VALUES ('14', '3', 'Problemas con WiFi', '1');
INSERT INTO `posible_problema` VALUES ('15', '3', 'Configuración de una red inalámbrica', '3');
INSERT INTO `posible_problema` VALUES ('16', '3', 'Búsqueda de la dirección IP del equipo', '1');
INSERT INTO `posible_problema` VALUES ('17', '3', 'Cambio de configuración TCP/IP', '1');
INSERT INTO `posible_problema` VALUES ('18', '3', 'Conectarse a otro equipo', '1');
INSERT INTO `posible_problema` VALUES ('19', '3', 'Conectarse a una VPN', '1');
INSERT INTO `posible_problema` VALUES ('20', '3', 'Sincronizar con el teléfono', '2');
INSERT INTO `posible_problema` VALUES ('21', '4', 'Mostrar archivos ocultos', '1');
INSERT INTO `posible_problema` VALUES ('22', '4', 'Liberación de espacio en disco', '2');
INSERT INTO `posible_problema` VALUES ('23', '4', 'Compresión de archivos', '3');
INSERT INTO `posible_problema` VALUES ('24', '5', 'Protección contra virtus y amenazas', '2');
INSERT INTO `posible_problema` VALUES ('25', '5', 'Activación/Desactivación de Firewall', '1');
INSERT INTO `posible_problema` VALUES ('26', '5', 'Activación de Cifrado', '1');
INSERT INTO `posible_problema` VALUES ('27', '5', 'Cambio de contraseña de usuario', '1');
INSERT INTO `posible_problema` VALUES ('28', '6', 'Mejorar la visualización', '1');
INSERT INTO `posible_problema` VALUES ('29', '6', 'Aumento de tamaño de letra', '1');
INSERT INTO `posible_problema` VALUES ('30', '6', 'Activación del Narrador', '1');
INSERT INTO `posible_problema` VALUES ('31', '6', 'Activar reconocimiento de voz', '2');

-- ----------------------------
-- Table structure for servicio
-- ----------------------------
DROP TABLE IF EXISTS `servicio`;
CREATE TABLE `servicio` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `precio_mensual` double NOT NULL,
  `fecha_actualizacion_precio` datetime NOT NULL,
  `moneda` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of servicio
-- ----------------------------
INSERT INTO `servicio` VALUES ('1', 'Soporte SAP', 'Soporte para el aplicativo SAP', '200', '2020-02-23 00:00:00', 'USD');
INSERT INTO `servicio` VALUES ('2', 'Soporte Tango', 'Soporte para el aplicativo Tango Gestión', '120', '2020-02-23 00:00:00', 'USD');
INSERT INTO `servicio` VALUES ('3', 'Soporte Microsoft Windows', 'Soporte para Sistema Operativo Microsoft Windows', '310', '2020-02-23 00:00:00', 'USD');
INSERT INTO `servicio` VALUES ('4', 'Soporte para MacOS', 'Soporte para Sistema Operativo MacOS', '350', '2020-02-23 00:00:00', 'USD');
INSERT INTO `servicio` VALUES ('5', 'Soporte para Ubuntu', 'Soporte para Sistema Operativo Linux Ubuntu', '50', '2020-02-23 00:00:00', 'USD');

-- ----------------------------
-- Table structure for servicio_contratado
-- ----------------------------
DROP TABLE IF EXISTS `servicio_contratado`;
CREATE TABLE `servicio_contratado` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cliente_id` int(11) DEFAULT NULL,
  `servicio_id` int(11) DEFAULT NULL,
  `fecha_contratacion` datetime NOT NULL,
  `precio_pactado` double NOT NULL,
  `duracion_en_meses` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_35E8306BDE734E51` (`cliente_id`),
  KEY `IDX_35E8306B71CAA3E7` (`servicio_id`),
  CONSTRAINT `FK_35E8306B71CAA3E7` FOREIGN KEY (`servicio_id`) REFERENCES `servicio` (`id`),
  CONSTRAINT `FK_35E8306BDE734E51` FOREIGN KEY (`cliente_id`) REFERENCES `cliente` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of servicio_contratado
-- ----------------------------
INSERT INTO `servicio_contratado` VALUES ('1', '1', '3', '2018-01-01 00:00:00', '340', '60');
INSERT INTO `servicio_contratado` VALUES ('2', '2', '3', '2019-01-01 00:00:00', '420', '60');
INSERT INTO `servicio_contratado` VALUES ('3', '1', '5', '2018-01-01 00:00:00', '60', '60');
INSERT INTO `servicio_contratado` VALUES ('4', '1', '1', '2019-01-01 00:00:00', '215', '60');

-- ----------------------------
-- Table structure for servicio_tipo_de_problema
-- ----------------------------
DROP TABLE IF EXISTS `servicio_tipo_de_problema`;
CREATE TABLE `servicio_tipo_de_problema` (
  `servicio_id` int(11) NOT NULL,
  `tipo_de_problema_id` int(11) NOT NULL,
  PRIMARY KEY (`servicio_id`,`tipo_de_problema_id`),
  KEY `IDX_6C8C137771CAA3E7` (`servicio_id`),
  KEY `IDX_6C8C1377E7B77340` (`tipo_de_problema_id`),
  CONSTRAINT `FK_6C8C137771CAA3E7` FOREIGN KEY (`servicio_id`) REFERENCES `servicio` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_6C8C1377E7B77340` FOREIGN KEY (`tipo_de_problema_id`) REFERENCES `tipo_de_problema` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of servicio_tipo_de_problema
-- ----------------------------
INSERT INTO `servicio_tipo_de_problema` VALUES ('1', '1');
INSERT INTO `servicio_tipo_de_problema` VALUES ('1', '2');
INSERT INTO `servicio_tipo_de_problema` VALUES ('1', '3');
INSERT INTO `servicio_tipo_de_problema` VALUES ('1', '4');
INSERT INTO `servicio_tipo_de_problema` VALUES ('1', '5');
INSERT INTO `servicio_tipo_de_problema` VALUES ('1', '6');
INSERT INTO `servicio_tipo_de_problema` VALUES ('2', '1');
INSERT INTO `servicio_tipo_de_problema` VALUES ('2', '2');
INSERT INTO `servicio_tipo_de_problema` VALUES ('2', '3');
INSERT INTO `servicio_tipo_de_problema` VALUES ('2', '4');
INSERT INTO `servicio_tipo_de_problema` VALUES ('2', '5');
INSERT INTO `servicio_tipo_de_problema` VALUES ('2', '6');
INSERT INTO `servicio_tipo_de_problema` VALUES ('3', '1');
INSERT INTO `servicio_tipo_de_problema` VALUES ('3', '2');
INSERT INTO `servicio_tipo_de_problema` VALUES ('3', '3');
INSERT INTO `servicio_tipo_de_problema` VALUES ('3', '4');
INSERT INTO `servicio_tipo_de_problema` VALUES ('3', '5');
INSERT INTO `servicio_tipo_de_problema` VALUES ('3', '6');
INSERT INTO `servicio_tipo_de_problema` VALUES ('4', '1');
INSERT INTO `servicio_tipo_de_problema` VALUES ('4', '2');
INSERT INTO `servicio_tipo_de_problema` VALUES ('4', '3');
INSERT INTO `servicio_tipo_de_problema` VALUES ('4', '4');
INSERT INTO `servicio_tipo_de_problema` VALUES ('4', '5');
INSERT INTO `servicio_tipo_de_problema` VALUES ('4', '6');
INSERT INTO `servicio_tipo_de_problema` VALUES ('5', '1');
INSERT INTO `servicio_tipo_de_problema` VALUES ('5', '2');
INSERT INTO `servicio_tipo_de_problema` VALUES ('5', '3');
INSERT INTO `servicio_tipo_de_problema` VALUES ('5', '4');
INSERT INTO `servicio_tipo_de_problema` VALUES ('5', '5');
INSERT INTO `servicio_tipo_de_problema` VALUES ('5', '6');

-- ----------------------------
-- Table structure for tecnico
-- ----------------------------
DROP TABLE IF EXISTS `tecnico`;
CREATE TABLE `tecnico` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `usuario_id` int(11) DEFAULT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `apellido` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_CC28C00DB38439E` (`usuario_id`),
  CONSTRAINT `FK_CC28C00DB38439E` FOREIGN KEY (`usuario_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of tecnico
-- ----------------------------
INSERT INTO `tecnico` VALUES ('1', '1', 'Juan', 'Perez');
INSERT INTO `tecnico` VALUES ('2', '2', 'Carlos', 'Mansilla');
INSERT INTO `tecnico` VALUES ('3', '3', 'Ramón', 'Soldado');
INSERT INTO `tecnico` VALUES ('4', '4', 'Agustina', 'Ponce');
INSERT INTO `tecnico` VALUES ('5', '5', 'Romina', 'Lara');

-- ----------------------------
-- Table structure for tipo_de_problema
-- ----------------------------
DROP TABLE IF EXISTS `tipo_de_problema`;
CREATE TABLE `tipo_de_problema` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of tipo_de_problema
-- ----------------------------
INSERT INTO `tipo_de_problema` VALUES ('1', 'Instalación y Actualizaciones');
INSERT INTO `tipo_de_problema` VALUES ('2', 'Controladores y Dispositivos');
INSERT INTO `tipo_de_problema` VALUES ('3', 'Red e Internet');
INSERT INTO `tipo_de_problema` VALUES ('4', 'Archivos y Almacenamiento');
INSERT INTO `tipo_de_problema` VALUES ('5', 'Seguridad y Privacidad');
INSERT INTO `tipo_de_problema` VALUES ('6', 'Accesibilidad');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_de_usuario` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `contrasenia` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `rol` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', 'jperez', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 'Técnico');
INSERT INTO `user` VALUES ('2', 'cmansilla', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 'Técnico');
INSERT INTO `user` VALUES ('3', 'rsoldado', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 'Técnico');
INSERT INTO `user` VALUES ('4', 'aponce', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 'Técnico');
INSERT INTO `user` VALUES ('5', 'rlara', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 'Técnico');
