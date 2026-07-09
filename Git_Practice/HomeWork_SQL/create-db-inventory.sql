-- Drop and recreate database
DROP DATABASE IF EXISTS `sql_inventory`;
CREATE DATABASE `sql_inventory`;
USE `sql_inventory`;

-- Create products table
CREATE TABLE `products` (
  `product_id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `quantity_in_stock` INT(11) NOT NULL,
  `unit_price` DECIMAL(6,2) NOT NULL,
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Insert products data in a single statement
INSERT INTO `products` (`product_id`, `name`, `quantity_in_stock`, `unit_price`) VALUES
(1,'Foam Dinner Plate',70,1.21),
(2,'Pork - Bacon,back Peameal',49,4.65),
(3,'Lettuce - Romaine, Heart',38,3.35),
(4,'Brocolinni - Gaylan, Chinese',90,4.53),
(5,'Sauce - Ranch Dressing',94,1.63),
(6,'Petit Baguette',14,2.39),
(7,'Sweet Pea Sprouts',98,3.29),
(8,'Island Oasis - Raspberry',26,0.74),
(9,'Longan',67,2.26),
(10,'Broom - Push',6,1.09);

