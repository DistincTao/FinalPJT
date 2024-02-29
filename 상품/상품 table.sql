use goott351;

CREATE TABLE `originals` (
	`original_class`	VARCHAR(4)	NOT NULL,
	`class_name`	VARCHAR(50)	NOT NULL,
	PRIMARY KEY (`original_class`)
);

CREATE TABLE `manufacturers` (
	`manufacturer_no`	INT	NOT NULL AUTO_INCREMENT,
	`manufacturer_name`	VARCHAR(50)	NOT NULL,
	PRIMARY KEY (`manufacturer_no`)
);

CREATE TABLE `product_class` (
	`class_no`	INT	NOT NULL,
	`class`	VARCHAR(50)	NOT NULL,
	PRIMARY KEY (`class_no`)
);


CREATE TABLE `product_likelog` (
	`like_no`	INT	NOT NULL AUTO_INCREMENT,
	`customer_id`	VARCHAR(36)	NOT NULL,
	`product_no`	INT	NOT NULL,
	`reg_date`	DATETIME	NOT NULL DEFAULT now(),
	PRIMARY KEY (`like_no`),
    FOREIGN KEY (`customer_id`) REFERENCES `customers` (`uuid`),
    FOREIGN KEY (`product_no`) REFERENCES `products` (`product_no`)
);

CREATE TABLE `products` (
	`product_no`	INT	NOT NULL AUTO_INCREMENT,
	`product_name`	VARCHAR(50)	NOT NULL,
	`original_name`	VARCHAR(50)	NOT NULL,
	`original_class`	VARCHAR(4)	NOT NULL,
	`manufacturer_no`	INT	NOT NULL,
	`class_no`	INT	NOT NULL	DEFAULT 30,
	`class_month`	VARCHAR(20),
	`reg_date`	DATETIME	NOT NULL DEFAULT now() ,
	`sales_cost`	INT	NOT NULL,
	`purchase_cost`	INT	NOT NULL,
	`discount_rate`	INT,
	`current_qty`	INT DEFAULT 1,
	`reserve_qty`	INT	DEFAULT 10,
	`thumbnail_img`	VARCHAR(200),
	`materials`	VARCHAR(100),
	`size`	VARCHAR(100),
	`is_sales`	VARCHAR(1)	DEFAULT 'Y',
	`is_recommend`	VARCHAR(1)	DEFAULT 'N',
	`like_cnt`	INT	DEFAULT 0,
	`product_rate`	INT	DEFAULT 0,
	PRIMARY KEY (`product_no`),
	FOREIGN KEY (`original_class`) REFERENCES `originals` (`original_class`),
	FOREIGN KEY (`manufacturer_no`) REFERENCES `manufacturers` (`manufacturer_no`),
	FOREIGN KEY (`class_no`) REFERENCES `product_class` (`class_no`)
);


CREATE TABLE `product_img` (
	`img_no`	INT	NOT NULL AUTO_INCREMENT,
	`product_no`	INT	NOT NULL,
	`original_filename`	VARCHAR(100),
	`new_filename`	VARCHAR(100),
	`img_url`	LONGTEXT,
	`img_size`	INT,
	`img_ext`	VARCHAR(5),
	`reg_date`	DATETIME,
	PRIMARY KEY (`img_no`),
	FOREIGN KEY (`product_no`) REFERENCES `products` (`product_no`)
);manufacturers

 