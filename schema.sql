
CREATE DATABASE IF NOT EXISTS `yeticave` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `yeticave`;

CREATE TABLE IF NOT EXISTS `bets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` timestamp NOT NULL,
  `price` mediumint(9) NOT NULL,
  `user_id` int(11) NOT NULL,
  `lot_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_bets_users` (`user_id`),
  KEY `FK_bets_lots` (`lot_id`),
  CONSTRAINT `FK_bets_lots` FOREIGN KEY (`lot_id`) REFERENCES `lots` (`id`),
  CONSTRAINT `FK_bets_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Ставка - это зафиксированное намерение пользователя приобрести товар, указанный в лоте по фиксированной стоимости';

CREATE TABLE IF NOT EXISTS `categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` char(50) NOT NULL,
  `code` char(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Индекс 2` (`name`,`code`),
  FULLTEXT KEY `Индекс 3` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Категории товаров';

CREATE TABLE IF NOT EXISTS `lots` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date_create` timestamp NOT NULL,
  `name` char(50) NOT NULL,
  `description` char(100) NOT NULL,
  `image_url` char(150) NOT NULL,
  `price_start` mediumint(9) NOT NULL,
  `date_close` timestamp NOT NULL,
  `price_step` mediumint(9) NOT NULL,
  `user_creator_id` int(11) NOT NULL,
  `user_winner_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_lots_users` (`user_creator_id`),
  KEY `FK_lots_users_2` (`user_winner_id`),
  KEY `FK_lots_categories` (`category_id`),
  FULLTEXT KEY `Индекс 5` (`name`),
  CONSTRAINT `FK_lots_categories` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`),
  CONSTRAINT `FK_lots_users` FOREIGN KEY (`user_creator_id`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_lots_users_2` FOREIGN KEY (`user_winner_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Центральная сущность всего сайта';

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date_reg` timestamp NOT NULL,
  `email` char(50) NOT NULL,
  `name` char(50) NOT NULL,
  `password` char(15) NOT NULL,
  `avatar` char(150) NOT NULL,
  `contact` char(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Индекс 2` (`email`),
  FULLTEXT KEY `Индекс 3` (`email`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Представляет зарегистрированного пользователя';

CREATE TABLE IF NOT EXISTS `users_bets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `bet_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_users_bets_users` (`user_id`),
  KEY `FK_users_bets_users_lots` (`bet_id`),
  CONSTRAINT `FK_users_bets_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_users_bets_users_lots` FOREIGN KEY (`bet_id`) REFERENCES `users_lots` (`lot_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Ставки, сделанные пользователем';

CREATE TABLE IF NOT EXISTS `users_lots` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `lot_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_users_lots_users` (`user_id`),
  KEY `FK_users_lots_lots` (`lot_id`),
  CONSTRAINT `FK_users_lots_lots` FOREIGN KEY (`lot_id`) REFERENCES `lots` (`id`),
  CONSTRAINT `FK_users_lots_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Лоты, созданные пользователем';
