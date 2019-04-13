-- phpMyAdmin SQL Dump
-- version 4.5.4.1deb2ubuntu2.1
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 13-04-2019 a las 18:02:48
-- Versión del servidor: 5.7.25-0ubuntu0.16.04.2
-- Versión de PHP: 7.0.33-0ubuntu0.16.04.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `access`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `permissions`
--

CREATE TABLE `permissions` (
  `id` int(11) NOT NULL,
  `name` varchar(40) NOT NULL,
  `description` varchar(100) NOT NULL,
  `system_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id` int(11) NOT NULL,
  `name` varchar(40) NOT NULL,
  `system_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles_permissions`
--

CREATE TABLE `roles_permissions` (
  `id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `schema_migrations`
--

CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `schema_migrations`
--

INSERT INTO `schema_migrations` (`version`) VALUES
('20181008224026'),
('20181008224503'),
('20181008225106'),
('20181008230445'),
('20181008230731'),
('20181008231027'),
('20181017003443'),
('20181017003836'),
('20181017013237'),
('20181020144129'),
('20181122234357'),
('20181122234844'),
('20181221234721'),
('20181222025851'),
('20181222174650'),
('20181222174920'),
('20181227024051');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `systems`
--

CREATE TABLE `systems` (
  `id` int(11) NOT NULL,
  `name` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `systems`
--

INSERT INTO `systems` (`id`, `name`) VALUES
(1, 'CanchasProviders');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `user` varchar(25) NOT NULL,
  `pass` varchar(80) NOT NULL,
  `email` varchar(40) NOT NULL,
  `user_state_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users_keys`
--

CREATE TABLE `users_keys` (
  `id` int(11) NOT NULL,
  `activation` varchar(40) DEFAULT NULL,
  `reset` varchar(40) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users_permissions`
--

CREATE TABLE `users_permissions` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users_roles`
--

CREATE TABLE `users_roles` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users_systems`
--

CREATE TABLE `users_systems` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `system_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `user_logs`
--

CREATE TABLE `user_logs` (
  `id` int(11) NOT NULL,
  `moment` datetime NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `user_states`
--

CREATE TABLE `user_states` (
  `id` int(11) NOT NULL,
  `name` varchar(20) NOT NULL,
  `sp` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `user_states`
--

INSERT INTO `user_states` (`id`, `name`, `sp`) VALUES
(1, 'active', NULL),
(2, 'inactive', NULL),
(3, 'suspended', NULL),
(4, 'deleted', NULL),
(5, 'vacationing', NULL),
(6, 'email_pending', NULL),
(7, 'incompleted', NULL);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vw_users_states_systems`
--
CREATE TABLE `vw_users_states_systems` (
`id` int(11)
,`system_id` int(11)
,`system` varchar(30)
,`user_state_id` int(11)
,`state` varchar(20)
,`user_id` int(11)
,`user` varchar(25)
,`pass` varchar(80)
);

-- --------------------------------------------------------

--
-- Estructura para la vista `vw_users_states_systems`
--
DROP TABLE IF EXISTS `vw_users_states_systems`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_users_states_systems`  AS  select `US`.`id` AS `id`,`S`.`id` AS `system_id`,`S`.`name` AS `system`,`UE`.`id` AS `user_state_id`,`UE`.`name` AS `state`,`U`.`id` AS `user_id`,`U`.`user` AS `user`,`U`.`pass` AS `pass` from (((`users_systems` `US` join `users` `U` on((`U`.`id` = `US`.`user_id`))) join `systems` `S` on((`S`.`id` = `US`.`system_id`))) join `user_states` `UE` on((`U`.`user_state_id` = `UE`.`id`))) limit 2000 ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_permission_system_id` (`system_id`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_role_system_id` (`system_id`);

--
-- Indices de la tabla `roles_permissions`
--
ALTER TABLE `roles_permissions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_role_permission_role_id` (`role_id`),
  ADD KEY `fk_role_permission_id` (`permission_id`);

--
-- Indices de la tabla `schema_migrations`
--
ALTER TABLE `schema_migrations`
  ADD PRIMARY KEY (`version`);

--
-- Indices de la tabla `systems`
--
ALTER TABLE `systems`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_user_state` (`user_state_id`);

--
-- Indices de la tabla `users_keys`
--
ALTER TABLE `users_keys`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_user_key_id` (`user_id`);

--
-- Indices de la tabla `users_permissions`
--
ALTER TABLE `users_permissions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_user_permission_user_id` (`user_id`),
  ADD KEY `fk_user_permission_id` (`permission_id`);

--
-- Indices de la tabla `users_roles`
--
ALTER TABLE `users_roles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_user_role_user_id` (`user_id`),
  ADD KEY `fk_user_role_id` (`role_id`);

--
-- Indices de la tabla `users_systems`
--
ALTER TABLE `users_systems`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_user_system_user_id` (`user_id`),
  ADD KEY `fk_user_system_id` (`system_id`);

--
-- Indices de la tabla `user_logs`
--
ALTER TABLE `user_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_user_id` (`user_id`);

--
-- Indices de la tabla `user_states`
--
ALTER TABLE `user_states`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `roles_permissions`
--
ALTER TABLE `roles_permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `systems`
--
ALTER TABLE `systems`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `users_keys`
--
ALTER TABLE `users_keys`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `users_permissions`
--
ALTER TABLE `users_permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `users_roles`
--
ALTER TABLE `users_roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `users_systems`
--
ALTER TABLE `users_systems`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `user_logs`
--
ALTER TABLE `user_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `user_states`
--
ALTER TABLE `user_states`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `permissions`
--
ALTER TABLE `permissions`
  ADD CONSTRAINT `fk_permission_system_id` FOREIGN KEY (`system_id`) REFERENCES `systems` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `roles`
--
ALTER TABLE `roles`
  ADD CONSTRAINT `fk_role_system_id` FOREIGN KEY (`system_id`) REFERENCES `systems` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `roles_permissions`
--
ALTER TABLE `roles_permissions`
  ADD CONSTRAINT `fk_role_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`),
  ADD CONSTRAINT `fk_role_permission_role_id` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `fk_user_state` FOREIGN KEY (`user_state_id`) REFERENCES `user_states` (`id`);

--
-- Filtros para la tabla `users_keys`
--
ALTER TABLE `users_keys`
  ADD CONSTRAINT `fk_user_key_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `users_permissions`
--
ALTER TABLE `users_permissions`
  ADD CONSTRAINT `fk_user_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`),
  ADD CONSTRAINT `fk_user_permission_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `users_roles`
--
ALTER TABLE `users_roles`
  ADD CONSTRAINT `fk_user_role_id` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`),
  ADD CONSTRAINT `fk_user_role_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `users_systems`
--
ALTER TABLE `users_systems`
  ADD CONSTRAINT `fk_user_system_id` FOREIGN KEY (`system_id`) REFERENCES `systems` (`id`),
  ADD CONSTRAINT `fk_user_system_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `user_logs`
--
ALTER TABLE `user_logs`
  ADD CONSTRAINT `fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
