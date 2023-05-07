-- CREAR LAS TABLAS SQL:
		-- Se crea la Base de Datos:
DROP DATABASE IF EXISTS car_api;
CREATE DATABASE IF NOT EXISTS car_api; USE
		car_api;

SET FOREIGN_KEY_CHECKS=0;

		-- Se borran las tablas si existen:
DROP TABLE IF EXISTS car_api.maintenance;
DROP TABLE IF EXISTS car_api.appointment;
DROP TABLE IF EXISTS car_api.car;
DROP TABLE IF EXISTS car_api.log;
DROP TABLE IF EXISTS car_api.user;
DROP TABLE IF EXISTS car_api.car_model;
DROP TABLE IF EXISTS car_api.dealership;
DROP TABLE IF EXISTS car_api.postal_code;
DROP TABLE IF EXISTS car_api.state;
DROP TABLE IF EXISTS car_api.transmission;
DROP TABLE IF EXISTS car_api.car_condition;
DROP TABLE IF EXISTS car_api.price;
DROP TABLE IF EXISTS car_api.color;
DROP TABLE IF EXISTS car_api.maker;
DROP TABLE IF EXISTS car_api.car_category;
DROP TABLE IF EXISTS car_api.schedule;
DROP TABLE IF EXISTS car_api.maintenance_type;
DROP TABLE IF EXISTS car_api.role;

SET FOREIGN_KEY_CHECKS=1;

		-- Se crean las tablas:
CREATE TABLE IF NOT EXISTS car_api.schedule(
		id INT NOT NULL AUTO_INCREMENT,
		hour TIME NOT NULL,
		PRIMARY KEY(id)
) ENGINE = InnoDB;
ALTER TABLE `car_api`.`schedule` ADD INDEX `hour` (`hour`) USING BTREE;


CREATE TABLE IF NOT EXISTS car_api.car_category(
		id INT NOT NULL AUTO_INCREMENT,
		name VARCHAR(20) NOT NULL,
		PRIMARY KEY(id)
) ENGINE = InnoDB;
ALTER TABLE `car_api`.`car_category` ADD INDEX `name` (`name`) USING BTREE;


CREATE TABLE IF NOT EXISTS car_api.maker(
		id INT NOT NULL AUTO_INCREMENT,
		name VARCHAR(40) NOT NULL,
		logo VARCHAR(250) NOT NULL,
		PRIMARY KEY(id)
) ENGINE = InnoDB;
ALTER TABLE `car_api`.`maker` ADD INDEX `name` (`name`) USING BTREE;


CREATE TABLE IF NOT EXISTS car_api.color(
		id INT NOT NULL AUTO_INCREMENT,
		name VARCHAR(15) NOT NULL,
		PRIMARY KEY(id)
) ENGINE = InnoDB;
ALTER TABLE `car_api`.`color` ADD INDEX `name` (`name`) USING BTREE;


CREATE TABLE IF NOT EXISTS car_api.price(
		id INT NOT NULL AUTO_INCREMENT,
		concept VARCHAR(350) NOT NULL,
		percentage INT NOT NULL,
		PRIMARY KEY(id)
) ENGINE = InnoDB;
ALTER TABLE `car_api`.`price` ADD INDEX `percentage` (`percentage`) USING BTREE,
ADD INDEX `concept` (`concept`) USING BTREE;


CREATE TABLE IF NOT EXISTS car_api.car_condition(
		id INT NOT NULL AUTO_INCREMENT,
		type VARCHAR(30) NOT NULL,
		PRIMARY KEY(id)
) ENGINE = InnoDB;
ALTER TABLE `car_api`.`car_condition` ADD INDEX `type` (`type`) USING BTREE;


CREATE TABLE IF NOT EXISTS car_api.transmission(
		id INT NOT NULL AUTO_INCREMENT,
		type VARCHAR(15) NOT NULL,
		PRIMARY KEY(id)
) ENGINE = InnoDB;
ALTER TABLE `car_api`.`transmission` ADD INDEX `type` (`type`) USING BTREE;


CREATE TABLE IF NOT EXISTS car_api.state(
		id INT NOT NULL AUTO_INCREMENT,
		name VARCHAR(35) NOT NULL,
		PRIMARY KEY(id)
) ENGINE = InnoDB;
ALTER TABLE `car_api`.`state` ADD INDEX `name` (`name`) USING BTREE;


CREATE TABLE IF NOT EXISTS car_api.postal_code(
		id INT NOT NULL AUTO_INCREMENT,
		code VARCHAR(15) NOT NULL,
		PRIMARY KEY(id)
) ENGINE = InnoDB;
ALTER TABLE `car_api`.`postal_code` ADD INDEX `code` (`code`) USING BTREE;


CREATE TABLE IF NOT EXISTS car_api.dealership(
		id INT NOT NULL AUTO_INCREMENT,
		name VARCHAR(50) NOT NULL,
		description VARCHAR(300),
		street VARCHAR(10) NOT NULL,
		exterior_number VARCHAR(10) NOT NULL,
		neighborhood VARCHAR(50) NOT NULL,
		state INT NOT NULL,
		country VARCHAR(25),
		postal_code INT NOT NULL,
		PRIMARY KEY(id),
		CONSTRAINT `fk_postal_code`
			FOREIGN KEY (`postal_code`)
			REFERENCES `car_api`.`postal_code` (`id`)
			ON UPDATE CASCADE
			ON DELETE CASCADE,
		CONSTRAINT `fk_state`
			FOREIGN KEY (`state`)
			REFERENCES `car_api`.`state` (`id`)
			ON UPDATE CASCADE
			ON DELETE CASCADE
) ENGINE = InnoDB;
ALTER TABLE `car_api`.`dealership` ADD INDEX `name` (`name`) USING BTREE,
ADD INDEX `state` (`state`) USING BTREE,
ADD INDEX `postal_code` (`postal_code`) USING BTREE;


CREATE TABLE IF NOT EXISTS car_api.maintenance_type(
		id INT NOT NULL AUTO_INCREMENT,
		concept VARCHAR(100) NOT NULL,
		price INT NOT NULL,
		PRIMARY KEY(id)
) ENGINE = InnoDB;
ALTER TABLE `car_api`.`maintenance_type` ADD INDEX `concept` (`concept`) USING BTREE;


CREATE TABLE IF NOT EXISTS car_api.role(
		id INT NOT NULL AUTO_INCREMENT,
		name VARCHAR(10) NOT NULL,
		permissions VARCHAR(10) NULL,
		PRIMARY KEY(id)
) ENGINE = InnoDB;
ALTER TABLE `car_api`.`role` ADD INDEX `name` (`name`) USING BTREE;


CREATE TABLE IF NOT EXISTS car_api.car_model(
		id INT NOT NULL AUTO_INCREMENT,
		name VARCHAR(75) NOT NULL,
		year INT NULL,
		factory_price INT NULL,
		transmission INT NOT NULL,
		color INT NOT NULL,
		category INT NOT NULL,
		maker INT NOT NULL,
		created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
		PRIMARY KEY(id),
		CONSTRAINT `fk_transmission`
			FOREIGN KEY (`transmission`)
			REFERENCES `car_api`.`transmission` (`id`)
			ON UPDATE CASCADE
			ON DELETE CASCADE,
		CONSTRAINT `fk_color`
			FOREIGN KEY (`color`)
			REFERENCES `car_api`.`color` (`id`)
			ON UPDATE CASCADE
			ON DELETE CASCADE,
		CONSTRAINT `fk_category`
			FOREIGN KEY (`category`)
			REFERENCES `car_api`.`car_category` (`id`)
			ON UPDATE CASCADE
			ON DELETE CASCADE,
		CONSTRAINT `fk_maker`
			FOREIGN KEY (`maker`)
			REFERENCES `car_api`.`maker` (`id`)
			ON UPDATE CASCADE
			ON DELETE CASCADE
) ENGINE = InnoDB;
ALTER TABLE `car_api`.`car_model` ADD INDEX `name` (`name`) USING BTREE,
ADD INDEX `transmission` (`transmission`) USING BTREE,
ADD INDEX `color` (`color`) USING BTREE,
ADD INDEX `category` (`category`) USING BTREE,
ADD INDEX `maker` (`maker`) USING BTREE,
ADD INDEX `factory_price` (`factory_price`) USING BTREE,
ADD INDEX `year` (`year`) USING BTREE;


CREATE TABLE IF NOT EXISTS car_api.user(
		id INT NOT NULL AUTO_INCREMENT,
		first_name VARCHAR(75) NOT NULL,
		last_name_1 VARCHAR(75) NOT NULL,
		last_name_2  VARCHAR(75) NOT NULL,
		password VARCHAR(30) NOT NULL,
		dealership INT NOT NULL,
		user_role INT NOT NULL,
		created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
		updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
		PRIMARY KEY(id),
		CONSTRAINT `fk_dealership`
			FOREIGN KEY (`dealership`)
			REFERENCES `car_api`.`dealership` (`id`)
			ON UPDATE CASCADE
			ON DELETE CASCADE,
		CONSTRAINT `fk_role`
			FOREIGN KEY (`user_role`)
			REFERENCES `car_api`.`role` (`id`)
			ON UPDATE CASCADE
			ON DELETE CASCADE
) ENGINE = InnoDB;
ALTER TABLE `car_api`.`user` ADD INDEX `first_name` (`first_name`) USING BTREE,
ADD INDEX `last_name_1` (`last_name_1`) USING BTREE,
ADD INDEX `last_name_2` (`last_name_2`) USING BTREE,
ADD INDEX `dealership` (`dealership`) USING BTREE,
ADD INDEX `user_role` (`user_role`) USING BTREE;


CREATE TABLE IF NOT EXISTS car_api.log(
		id INT NOT NULL AUTO_INCREMENT,
		user INT NOT NULL,
		ip VARCHAR(50) NOT NULL,
		event TEXT NOT NULL,
		observation VARCHAR(50) NOT NULL,
		created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
		PRIMARY KEY(id),
		CONSTRAINT `fk_user`
			FOREIGN KEY (`user`)
			REFERENCES `car_api`.`user` (`id`)
			ON UPDATE CASCADE
			ON DELETE CASCADE
) ENGINE = InnoDB;
ALTER TABLE `car_api`.`log` ADD INDEX `user` (`user`) USING BTREE,
ADD INDEX `created_at` (`created_at`) USING BTREE;


CREATE TABLE IF NOT EXISTS car_api.car(
		vin VARCHAR(17) NOT NULL,
		mileage INT NOT NULL,
		description TEXT NULL,
		purchase_price INT NOT NULL,
		sale_price INT NULL,
		maintenance_cost INT DEFAULT 0,
		model INT NOT NULL,
		car_condition INT NOT NULL,
		interior_color INT NOT NULL,
		exterior_color INT NOT NULL,
		dealership INT NOT NULL,
		sold BOOLEAN DEFAULT 0,
		created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
		PRIMARY KEY(vin),
		CONSTRAINT `fk_model`
			FOREIGN KEY (`model`)
			REFERENCES `car_api`.`car_model` (`id`)
			ON UPDATE CASCADE
			ON DELETE CASCADE,
		CONSTRAINT `fk_car_condition`
			FOREIGN KEY (`car_condition`)
			REFERENCES `car_api`.`car_condition` (`id`)
			ON UPDATE CASCADE
			ON DELETE CASCADE,
		CONSTRAINT `fk_exterior_color`
			FOREIGN KEY (`exterior_color`)
			REFERENCES `car_api`.`color` (`id`)
			ON UPDATE CASCADE
			ON DELETE CASCADE,
		CONSTRAINT `fk_interior_color`
			FOREIGN KEY (`interior_color`)
			REFERENCES `car_api`.`color` (`id`)
			ON UPDATE CASCADE
			ON DELETE CASCADE,
		CONSTRAINT `fk_dealership_2`
			FOREIGN KEY (`dealership`)
			REFERENCES `car_api`.`dealership` (`id`)
			ON UPDATE CASCADE
			ON DELETE CASCADE
) ENGINE = InnoDB;
ALTER TABLE `car_api`.`car` ADD INDEX `purchase_price` (`purchase_price`) USING BTREE,
ADD INDEX `sale_price` (`sale_price`) USING BTREE,
ADD INDEX `maintenance_cost` (`maintenance_cost`) USING BTREE,
ADD INDEX `model` (`model`) USING BTREE,
ADD INDEX `car_condition` (`car_condition`) USING BTREE,
ADD INDEX `interior_color` (`interior_color`) USING BTREE,
ADD INDEX `exterior_color` (`exterior_color`) USING BTREE,
ADD INDEX `dealership` (`dealership`) USING BTREE,
ADD INDEX `sold` (`sold`) USING BTREE,
ADD INDEX `mileage` (`mileage`) USING BTREE,
ADD INDEX `created_at` (`created_at`) USING BTREE;


CREATE TABLE IF NOT EXISTS car_api.appointment(
		id INT NOT NULL AUTO_INCREMENT,
		first_name VARCHAR(80) NOT NULL,
		last_name_1 VARCHAR(80) NOT NULL,
		last_name_2 VARCHAR(80) NOT NULL,
		email VARCHAR(80) NOT NULL,
		telephone VARCHAR(20) NULL,
		appointment_date DATE NOT NULL,
		dealership INT NOT NULL,
		car VARCHAR(17) NOT NULL,
		created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
		PRIMARY KEY(id),
		CONSTRAINT `fk_dealership_3`
			FOREIGN KEY (`dealership`)
			REFERENCES `car_api`.`dealership` (`id`)
			ON UPDATE CASCADE
			ON DELETE CASCADE,
		CONSTRAINT `fk_car`
			FOREIGN KEY (`car`)
			REFERENCES `car_api`.`car` (`vin`)
			ON UPDATE CASCADE
			ON DELETE CASCADE
) ENGINE = InnoDB;
ALTER TABLE `car_api`.`appointment` ADD INDEX `first_name` (`first_name`) USING BTREE,
ADD INDEX `last_name_1` (`last_name_1`) USING BTREE,
ADD INDEX `last_name_2` (`last_name_2`) USING BTREE,
ADD INDEX `email` (`email`) USING BTREE,
ADD INDEX `telephone` (`telephone`) USING BTREE,
ADD INDEX `appointment_date` (`appointment_date`) USING BTREE,
ADD INDEX `dealership` (`dealership`) USING BTREE,
ADD INDEX `car` (`car`) USING BTREE;


CREATE TABLE IF NOT EXISTS car_api.maintenance(
		maintenance_type INT NOT NULL,
		car VARCHAR(17) NOT NULL,
		created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
		PRIMARY KEY(maintenance_type, car),
		CONSTRAINT `fk_maintenance_type`
			FOREIGN KEY (`maintenance_type`)
			REFERENCES `car_api`.`maintenance_type` (`id`)
			ON UPDATE CASCADE
			ON DELETE CASCADE,
		CONSTRAINT `fk_car_2`
			FOREIGN KEY (`car`)
			REFERENCES `car_api`.`car` (`vin`)
			ON UPDATE CASCADE
			ON DELETE CASCADE
) ENGINE = InnoDB;