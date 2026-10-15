-- FoodFinder database. Run this once in phpMyAdmin (Import tab) after creating
-- an empty database on your host.

CREATE TABLE IF NOT EXISTS `users` (
  `user_id`  INT(11) NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(150) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `created`  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `favorites` (
  `id`      INT(11) NOT NULL AUTO_INCREMENT,
  `user_id` INT(11) NOT NULL,
  `meal_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_meal` (`user_id`, `meal_id`),
  CONSTRAINT `fav_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
