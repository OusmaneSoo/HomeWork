
-- Drop and create database
DROP DATABASE IF EXISTS `store`;
CREATE DATABASE `store`;
USE `store`;

-- Create products table
CREATE TABLE `products` (
  `product_id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `quantity_in_stock` INT(11) NOT NULL,
  `unit_price` DECIMAL(4,2) NOT NULL,
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;

-- Insert products data
INSERT INTO `products` VALUES
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

-- Create shippers table
CREATE TABLE `shippers` (
  `shipper_id` SMALLINT(6) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`shipper_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

INSERT INTO `shippers` VALUES
(1,'Hettinger LLC'),
(2,'Schinner-Predovic'),
(3,'Satterfield LLC'),
(4,'Mraz, Renner and Nolan'),
(5,'Waters, Mayert and Prohaska');

-- Create customers table
CREATE TABLE `customers` (
  `customer_id` INT(11) NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(50) NOT NULL,
  `last_name` VARCHAR(50) NOT NULL,
  `birth_date` DATE DEFAULT NULL,
  `phone` VARCHAR(50) DEFAULT NULL,
  `address` VARCHAR(50) NOT NULL,
  `city` VARCHAR(50) NOT NULL,
  `state` CHAR(2) NOT NULL,
  `points` INT(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;

INSERT INTO `customers` VALUES
(1,'Babara','MacCaffrey','1986-03-28','781-932-9754','0 Sage Terrace','Waltham','MA',2273),
(2,'Ines','Brushfield','1986-04-13','804-427-9456','14187 Commercial Trail','Hampton','VA',947),
(3,'Freddi','Boagey','1985-02-07','719-724-7869','251 Springs Junction','Colorado Springs','CO',2967),
(4,'Ambur','Roseburgh','1974-04-14','407-231-8017','30 Arapahoe Terrace','Orlando','FL',457),
(5,'Clemmie','Betchley','1973-11-07',NULL,'5 Spohn Circle','Arlington','TX',3675),
(6,'Elka','Twiddell','1991-09-04','312-480-8498','7 Manley Drive','Chicago','IL',3073),
(7,'Ilene','Dowson','1964-08-30','615-641-4759','50 Lillian Crossing','Nashville','TN',1672),
(8,'Thacher','Naseby','1993-07-17','941-527-3977','538 Mosinee Center','Sarasota','FL',205),
(9,'Romola','Rumgay','1992-05-23','559-181-3744','3520 Ohio Trail','Visalia','CA',1486),
(10,'Levy','Mynett','1969-10-13','404-246-3370','68 Lawn Avenue','Atlanta','GA',796);

-- Create order_statuses table
CREATE TABLE `order_statuses` (
  `order_status_id` TINYINT(4) NOT NULL,
  `name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`order_status_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `order_statuses` VALUES
(1,'Processed'),
(2,'Shipped'),
(3,'Delivered');

-- Create orders table
CREATE TABLE `orders` (
  `order_id` INT(11) NOT NULL AUTO_INCREMENT,
  `customer_id` INT(11) NOT NULL,
  `order_date` DATE NOT NULL,
  `status` TINYINT(4) NOT NULL DEFAULT '1',
  `comments` VARCHAR(2000) DEFAULT NULL,
  `shipped_date` DATE DEFAULT NULL,
  `shipper_id` SMALLINT(6) DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `fk_orders_customers_idx` (`customer_id`),
  KEY `fk_orders_shippers_idx` (`shipper_id`),
  KEY `fk_orders_order_statuses_idx` (`status`),
  CONSTRAINT `fk_orders_customers` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_orders_order_statuses` FOREIGN KEY (`status`) REFERENCES `order_statuses` (`order_status_id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_orders_shippers` FOREIGN KEY (`shipper_id`) REFERENCES `shippers` (`shipper_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;

-- Insert orders
INSERT INTO `orders` VALUES
(1,6,'2019-01-30',1,NULL,NULL,NULL),
(2,7,'2018-08-02',2,NULL,'2018-08-03',4),
(3,8,'2017-12-01',1,NULL,NULL,NULL),
(4,2,'2017-01-22',1,NULL,NULL,NULL),
(5,5,'2017-08-25',2,'','2017-08-26',3),
(6,10,'2018-11-18',1,'Aliquam erat volutpat. In congue.',NULL,NULL),
(7,2,'2018-09-22',2,NULL,'2018-09-23',4),
(8,5,'2018-06-08',1,'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis.',NULL,NULL),
(9,10,'2017-07-05',2,'Nulla mollis molestie lorem. Quisque ut erat.','2017-07-06',1),
(10,6,'2018-04-22',2,NULL,'2018-04-23',2);

-- Create order_items table
CREATE TABLE `order_items` (
  `order_id` INT(11) NOT NULL,
  `product_id` INT(11) NOT NULL,
  `quantity` INT(11) NOT NULL,
  `unit_price` DECIMAL(4,2) NOT NULL,
  PRIMARY KEY (`order_id`,`product_id`),
  KEY `fk_order_items_products_idx` (`product_id`),
  CONSTRAINT `fk_order_items_orders` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_order_items_products` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Insert order_items
INSERT INTO `order_items` VALUES
(1,4,4,3.74),
(2,1,2,9.10),
(2,4,4,1.66),
(2,6,2,2.94),
(3,3,10,9.12),
(4,3,7,6.99),
(4,10,7,6.40),
(5,2,3,9.89),
(6,1,4,8.65),
(6,2,4,3.28),
(6,3,4,7.46),
(6,5,1,3.45),
(7,3,7,9.17),
(8,5,2,6.94),
(8,8,2,8.59),
(9,6,5,7.28),
(10,1,10,6.01),
(10,9,9,4.28);

-- Create order_item_notes table
CREATE TABLE `order_item_notes` (
  `note_id` INT NOT NULL AUTO_INCREMENT,
  `order_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  `note` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`note_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Insert order_item_notes
INSERT INTO `order_item_notes` (`note_id`, `order_id`, `product_id`, `note`) VALUES
(1,1,2,'first note'),
(2,1,2,'second note');
