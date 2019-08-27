CREATE DATABASE IF NOT EXISTS `yeticave` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `yeticave`;

CREATE TABLE IF NOT EXISTS `bets` (
  `id` int(6) unsigned NOT NULL AUTO_INCREMENT,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `price` decimal(9,2) NOT NULL,
  `user_id` int(6) unsigned NOT NULL,
  `lot_id` int(6) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_bets_users` (`user_id`),
  KEY `FK_bets_lots` (`lot_id`),
  CONSTRAINT `FK_bets_lots` FOREIGN KEY (`lot_id`) REFERENCES `lots` (`id`),
  CONSTRAINT `FK_bets_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Ставка - это зафиксированное намерение пользователя приобрести товар, указанный в лоте по фиксированной стоимости';

CREATE TABLE IF NOT EXISTS `categories` (
  `id` int(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` char(50) NOT NULL,
  `code` char(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Индекс 2` (`name`,`code`),
  FULLTEXT KEY `Индекс 3` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Категории товаров';

CREATE TABLE IF NOT EXISTS `lots` (
  `id` int(6) unsigned NOT NULL AUTO_INCREMENT,
  `date_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `name` char(50) NOT NULL,
  `description` char(100) NOT NULL,
  `image_url` char(150) NOT NULL,
  `price_start` decimal(9,2) NOT NULL,
  `date_close` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `price_step` decimal(9,2) NOT NULL,
  `user_creator_id` int(6) unsigned NOT NULL,
  `user_winner_id` int(6) unsigned NULL DEFAULT NULL,
  `category_id` int(3) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_lots_categories` (`category_id`),
  KEY `FK_lots_users` (`user_creator_id`),
  KEY `FK_lots_users_2` (`user_winner_id`),
  FULLTEXT KEY `Индекс 5` (`name`),
  CONSTRAINT `FK_lots_categories` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`),
  CONSTRAINT `FK_lots_users` FOREIGN KEY (`user_creator_id`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_lots_users_2` FOREIGN KEY (`user_winner_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Лоты, выставленные на продажу';

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(6) unsigned NOT NULL AUTO_INCREMENT,
  `date_reg` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `email` char(30) NOT NULL,
  `name` char(50) NOT NULL,
  `password` char(15) NOT NULL,
  `avatar` char(150) NOT NULL,
  `contact` char(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Индекс 2` (`email`),
  FULLTEXT KEY `Индекс 3` (`email`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Представляет зарегистрированного пользователя';

CREATE TABLE IF NOT EXISTS `users_bets` (
  `id` int(6) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(6) unsigned NOT NULL,
  `bet_id` int(6) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_users_bets_users` (`user_id`),
  KEY `FK_users_bets_bets` (`bet_id`),
  CONSTRAINT `FK_users_bets_bets` FOREIGN KEY (`bet_id`) REFERENCES `bets` (`id`),
  CONSTRAINT `FK_users_bets_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Ставки, сделанные пользователем';

CREATE TABLE IF NOT EXISTS `users_lots` (
  `id` int(6) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(6) unsigned NOT NULL,
  `lot_id` int(6) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_users_lots_users` (`user_id`),
  KEY `FK_users_lots_lots` (`lot_id`),
  CONSTRAINT `FK_users_lots_lots` FOREIGN KEY (`lot_id`) REFERENCES `lots` (`id`),
  CONSTRAINT `FK_users_lots_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Лоты, созданные пользователем';