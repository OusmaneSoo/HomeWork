DROP DATABASE IF EXISTS `sql_hr`;
CREATE DATABASE `sql_hr`;
USE `sql_hr`;

SET FOREIGN_KEY_CHECKS = 0;

-- Create offices table

CREATE TABLE `offices` (
  `office_id` INT(11) NOT NULL,
  `address` VARCHAR(50) NOT NULL,
  `city` VARCHAR(50) NOT NULL,
  `state` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`office_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
-- Insert offices
INSERT INTO `offices` (`office_id`, `address`, `city`, `state`) VALUES
(1,'03 Reinke Trail','Cincinnati','OH'),
(2,'5507 Becker Terrace','New York City','NY'),
(3,'54 Northland Court','Richmond','VA'),
(4,'08 South Crossing','Cincinnati','OH'),
(5,'553 Maple Drive','Minneapolis','MN'),
(6,'23 North Plaza','Aurora','CO'),
(7,'9658 Wayridge Court','Boise','ID'),
(8,'9 Grayhawk Trail','New York City','NY'),
(9,'16862 Westend Hill','Knoxville','TN'),
(10,'4 Bluestem Parkway','Savannah','GA');

-- Create employees table
CREATE TABLE `employees` (
  `employee_id` INT(11) NOT NULL,
  `first_name` VARCHAR(50) NOT NULL,
  `last_name` VARCHAR(50) NOT NULL,
  `job_title` VARCHAR(50) NOT NULL,
  `salary` INT(11) NOT NULL,
  `reports_to` INT(11) DEFAULT NULL,
  `office_id` INT(11) NOT NULL,
  PRIMARY KEY (`employee_id`),
  KEY `fk_employees_offices_idx` (`office_id`),
  KEY `fk_employees_managers_idx` (`reports_to`),
  CONSTRAINT `fk_employees_offices` FOREIGN KEY (`office_id`) REFERENCES `offices` (`office_id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_employees_managers` FOREIGN KEY (`reports_to`) REFERENCES `employees` (`employee_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Insert employees
INSERT INTO `employees` (`employee_id`, `first_name`, `last_name`, `job_title`, `salary`, `reports_to`, `office_id`) VALUES
(37270,'Yovonnda','Magrannell','Executive Secretary',63996,NULL,10),
(33391,'D''arcy','Nortunen','Account Executive',62871,37270,1),
(37851,'Sayer','Matterson','Statistician III',98926,37270,1),
(40448,'Mindy','Crissil','Staff Scientist',94860,37270,1),
(56274,'Keriann','Alloisi','VP Marketing',110150,37270,1),
(63196,'Alaster','Scutchin','Assistant Professor',32179,37270,2),
(67009,'North','de Clerc','VP Product Management',114257,37270,2),
(67370,'Elladine','Rising','Social Worker',96767,37270,2),
(68249,'Nisse','Voysey','Financial Advisor',52832,37270,2),
(72540,'Guthrey','Iacopetti','Office Assistant I',117690,37270,3),
(72913,'Kass','Hefferan','Computer Systems Analyst IV',96401,37270,3),
(75900,'Virge','Goodrum','Information Systems Manager',54578,37270,3),
(76196,'Mirilla','Janowski','Cost Accountant',119241,37270,3),
(80529,'Lynde','Aronson','Junior Executive',77182,37270,4),
(80679,'Mildrid','Sokale','Geologist II',67987,37270,4),
(84791,'Hazel','Tarbert','General Manager',93760,37270,4),
(95213,'Cole','Kesterton','Pharmacist',86119,37270,4),
(96513,'Theresa','Binney','Food Chemist',47354,37270,5),
(98374,'Estrellita','Daleman','Staff Accountant IV',70187,37270,5),
(115357,'Ivy','Fearey','Structural Engineer',92710,37270,5);

SET FOREIGN_KEY_CHECKS = 1;
