use goott351;
use Test;

CREATE TABLE `category` (
	`category_no`	INT	NOT NULL AUTO_INCREMENT,
	`category_name`	VARCHAR(50)	NOT NULL,
	PRIMARY KEY (`category_no`)
);

CREATE TABLE `header` (
	`header_no`	INT	NOT NULL AUTO_INCREMENT,
	`header_name`	VARCHAR(50)	NOT NULL,
	PRIMARY KEY (`header_no`)
);

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

CREATE TABLE `order_cs_type` (
	`cs_type`	VARCHAR(10)	NOT NULL,
	`penalty`	VARCHAR(1),
	PRIMARY KEY (`cs_type`)
);

CREATE TABLE `customers` (
	`uuid`	VARCHAR(36)	NOT NULL,
	`email`	VARCHAR(50)	NOT NULL,
	`password`	VARCHAR(12)	NOT NULL,
	`name`	VARCHAR(12)	NOT NULL,
	`birthday`	DATE	NOT NULL,
	`phone_number`	VARCHAR(13)	NOT NULL,
	`gender`	VARCHAR(6)	NOT NULL,
	`nickname`	VARCHAR(15)	NOT NULL,
	`session_key`	VARCHAR(100),
	`user_img`	LONGTEXT,
	`user_point`	INT,
	`register_date`	DATETIME,
	`is_admin`	VARCHAR(1),
	`msg_agree`	VARCHAR(1)	NOT NULL,
	`bank_name`	VARCHAR(20),
	`refund_account`	VARCHAR(20),
	`social_login`	VARCHAR(1),
	PRIMARY KEY (`uuid`)
);

CREATE TABLE `order` (
	`order_no`	VARCHAR(10)	NOT NULL,
	`order_time`	DATETIME	NOT NULL,
	`order_status`	VARCHAR(20),
	`pay_status`	VARCHAR(20),
	`delivery_date`	DATETIME,
	`payment_key`	VARCHAR(50),
	`payment_date`	DATETIME,
	`order_name`	VARCHAR(30)	NOT NULL,
	`customer_id`	VARCHAR(36),
	PRIMARY KEY (`order_no`)
);

CREATE TABLE `order_products` (
	`order_no`	VARCHAR(10)	NOT NULL,
	`product_no`	INT	NOT NULL,
	`quantity`	INT,
	`order_price`	INT	NOT NULL,
	`order_cancel`	VARCHAR(1),
	`Field`	VARCHAR(50),
	PRIMARY KEY (`order_no`, `product_no`),
	FOREIGN KEY (`order_no`) REFERENCES `order` (`order_no`),
	FOREIGN KEY (`product_no`) REFERENCES `products` (`product_no`)
);

CREATE TABLE `order_billing` (
	`order_no`	VARCHAR(10)	NOT NULL,
	`product_amount`	INT	NOT NULL,
	`product_discount`	INT,
	`point_discount`	INT,
	`shipping_cost`	INT,
	`order_cost`	INT,
	`order_point`	INT,
	PRIMARY KEY (`order_no`),
	FOREIGN KEY (`order_no`) REFERENCES `order` (`order_no`)
);

CREATE TABLE `shipping` (
	`order_no`	VARCHAR(10)	NOT NULL,
	`receiver`	VARCHAR(20)	NOT NULL,
	`phone`	VARCHAR(10)	NOT NULL,
	`address`	VARCHAR(50)	NOT NULL,
	`zip_code`	INT	NOT NULL,
	`request`	VARCHAR(200),
	`tracking_no`	INT,
	PRIMARY KEY (`order_no`),
	FOREIGN KEY (`order_no`) REFERENCES `order` (`order_no`)
);

CREATE TABLE `delivery` (
	`delivery_no`	INT	NOT NULL AUTO_INCREMENT,
	`delivery_addr`	VARCHAR(50)	NOT NULL,
	`basic_addr`	VARCHAR(255)	NOT NULL,
	`uuid`	VARCHAR(36)	NOT NULL,
	PRIMARY KEY (`delivery_no`)
);

CREATE TABLE `login_trylog` (
	`no`	INT	NOT NULL AUTO_INCREMENT,
	`customer_uuid`	VARCHAR(36)	NOT NULL,
	`try_date`	DATETIME,
	PRIMARY KEY (`no`)
);

CREATE TABLE `withdraw_customers` (
	`no`	INT	NOT NULL AUTO_INCREMENT,
	`email`	VARCHAR(50),
	`withdraw_date`	DATETIME	NOT NULL,
	`posible_date`	DATETIME,
	`withdraw_reason`	VARCHAR(500),
	PRIMARY KEY (`no`)
);

CREATE TABLE `pointpolicy` (
	`why`	VARCHAR(100)	NOT NULL,
	`howmuch`	INT	NOT NULL,
	PRIMARY KEY (`why`)
);

CREATE TABLE `pointlog` (
	`no`	INT	NOT NULL AUTO_INCREMENT,
	`why`	VARCHAR(50)	NOT NULL,
	`customer_uuid`	VARCHAR(36)	NOT NULL,
	`when`	DATETIME	NOT NULL,
	`howmuch`	INT	NOT NULL,
	PRIMARY KEY (`no`),
	FOREIGN KEY (`why`) REFERENCES `pointpolicy` (`why`)
);

CREATE TABLE `product_likelog` (
	`like_no`	INT	NOT NULL AUTO_INCREMENT,
	`customer_id`	VARCHAR(36)	NOT NULL,
	`product_no`	INT	NOT NULL,
	`reg_date`	DATETIME	NOT NULL,
	PRIMARY KEY (`like_no`)
);

CREATE TABLE `products` (
	`product_no`	INT	NOT NULL AUTO_INCREMENT,
	`product_name`	VARCHAR(50)	NOT NULL,
	`original_name`	VARCHAR(50)	NOT NULL,
	`original_class`	VARCHAR(4)	NOT NULL,
	`manufacturer_no`	INT	NOT NULL,
	`class_no`	INT	NOT NULL	DEFAULT 30,
	`class_month`	VARCHAR(20),
	`reg_date`	DATETIME	NOT NULL,
	`sales_cost`	INT	NOT NULL,
	`purchase_cost`	INT	NOT NULL,
	`discount_rate`	INT,
	`current_qty`	INT,
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

CREATE TABLE `cart` (
	`cart_no`	INT	NOT NULL AUTO_INCREMENT,
	`uuid`	VARCHAR(36)	NOT NULL,
	`product_no`	INT	NOT NULL,
	`quantity`	INT,
	PRIMARY KEY (`cart_no`)
);

CREATE TABLE `board` (
	`board_no`	INT	NOT NULL AUTO_INCREMENT,
	`category_no`	INT	NOT NULL,
	`header_no`	INT,
	`board_title`	VARCHAR(100)	NOT NULL,
	`board_content`	VARCHAR(2000)	NOT NULL,
	`uuid`	VARCHAR(36)	NOT NULL,
	`write_date`	DATETIME	NOT NULL,
	`board_like`	INT,
	`board_read`	INT,
	PRIMARY KEY (`board_no`),
	FOREIGN KEY (`category_no`) REFERENCES `category` (`category_no`),
	FOREIGN KEY (`header_no`) REFERENCES `header` (`header_no`)
);

CREATE TABLE `board_writelog` (
	`write_no`	INT	NOT NULL AUTO_INCREMENT,
	`uuid`	VARCHAR(36)	NOT NULL,
	`board_no`	INT	NOT NULL,
	`write_date`	DATETIME	NOT NULL,
	PRIMARY KEY (`write_no`),
	FOREIGN KEY (`uuid`) REFERENCES `customers` (`uuid`),
	FOREIGN KEY (`board_no`) REFERENCES `board` (`board_no`)
);

CREATE TABLE `reply` (
	`reply_no`	INT	NOT NULL AUTO_INCREMENT,
	`reply_content`	VARCHAR(1000)	NOT NULL,
	`reply_date`	DATE	NOT NULL,
	`board_no`	INT	NOT NULL,
	`uuid`	VARCHAR(36)	NOT NULL,
	PRIMARY KEY (`reply_no`),
	FOREIGN KEY (`board_no`) REFERENCES `board` (`board_no`),
	FOREIGN KEY (`uuid`) REFERENCES `customers` (`uuid`)
);

CREATE TABLE `board_likelog` (
	`boardlike_no`	INT	NOT NULL AUTO_INCREMENT,
	`uuid`	VARCHAR(36)	NOT NULL,
	`board_no`	INT	NOT NULL,
	`boardlike_date`	DATETIME	NOT NULL,
	PRIMARY KEY (`boardlike_no`),
	FOREIGN KEY (`uuid`) REFERENCES `customers` (`uuid`),
	FOREIGN KEY (`board_no`) REFERENCES `board` (`board_no`)
);

CREATE TABLE `read_log` (
	`read_no`	INT	NOT NULL AUTO_INCREMENT,
	`id_addr`	VARCHAR(50)	NOT NULL,
	`board_no`	INT	NOT NULL,
	`read_date`	DATE	NOT NULL,
	PRIMARY KEY (`read_no`),
	FOREIGN KEY (`board_no`) REFERENCES `board` (`board_no`)
);

CREATE TABLE `image` (
	`img_no`	INT	NOT NULL AUTO_INCREMENT,
	`img_ext`	VARCHAR(10),
	`img_size`	INT,
	`img_path`	VARCHAR(100)	NOT NULL,
	`img_new_name`	VARCHAR(100),
	`img_origin_name`	VARCHAR(100),
	`sv_board_no`	INT,
	`review_no`	INT,
	`cs_no`	INT,
	`board_no`	INT,
	`product_no`	INT	NOT NULL,
	PRIMARY KEY (`img_no`),
	FOREIGN KEY (`sv_board_no`) REFERENCES `service_board` (`sv_board_no`),
	FOREIGN KEY (`review_no`) REFERENCES `review` (`review_no`),
	FOREIGN KEY (`cs_no`) REFERENCES `order_cs` (`cs_no`),
	FOREIGN KEY (`board_no`) REFERENCES `board` (`board_no`),
	FOREIGN KEY (`product_no`) REFERENCES `products` (`product_no`)
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
);

CREATE TABLE `service_board` (
	`sv_board_no`	INT	NOT NULL AUTO_INCREMENT,
	`sv_board_regiDate`	DATETIME	NOT NULL,
	`sv_board_content`	VARCHAR(1000),
	`sv_isHidden`	VARCHAR(1),
	`sv_isDelete`	VARCHAR(1),
	`sv_type`	VARCHAR(20),
	`sv_board_answer`	VARCHAR(1000),
	`product_no`	INT,
	`uuid`	VARCHAR(36),
	`order_no`	VARCHAR(10),
	PRIMARY KEY (`sv_board_no`),
	FOREIGN KEY (`product_no`) REFERENCES `products` (`product_no`),
	FOREIGN KEY (`uuid`) REFERENCES `customers` (`uuid`),
	FOREIGN KEY (`order_no`) REFERENCES `order` (`order_no`)
);

CREATE TABLE `message_Log` (
	`message_no`	INT	NOT NULL AUTO_INCREMENT,
	`message_content`	VARCHAR(200),
	`uuid`	VARCHAR(36)	NOT NULL,
	PRIMARY KEY (`message_no`),
	FOREIGN KEY (`uuid`) REFERENCES `customers` (`uuid`)
);

CREATE TABLE `review` (
	`review_no`	INT	NOT NULL AUTO_INCREMENT,
	`product_no`	INT	NOT NULL,
	`customer_id`	VARCHAR(36)	NOT NULL,
	`original_name`	VARCHAR(50)	NOT NULL,
	`review_content`	VARCHAR(1000),
	`review_star`	INT	NOT NULL,
	`review_date`	DATE	NOT NULL,
	PRIMARY KEY (`review_no`),
	FOREIGN KEY (`product_no`) REFERENCES `products` (`product_no`),
	FOREIGN KEY (`customer_id`) REFERENCES `customers` (`uuid`)
);

CREATE TABLE `ecommerce_policy` (
	`no`	INT	NOT NULL AUTO_INCREMENT,
	`title`	VARCHAR(50)	NOT NULL,
	`content`	LONGTEXT	NOT NULL,
	PRIMARY KEY (`no`)
);

CREATE TABLE `order_cs` (
	`cs_no`	INT	NOT NULL AUTO_INCREMENT,
	`cs_date`	DATETIME,
	`reason`	VARCHAR(100),
	`is_admin`	VARCHAR(1),
	`product_quantity`	INT,
	`cs_type`	VARCHAR(20)	NOT NULL,
	`order_no`	VARCHAR(10)	NOT NULL,
	`product_no`	INT	NOT NULL,
	PRIMARY KEY (`cs_no`),
	FOREIGN KEY (`order_no`) REFERENCES `order` (`order_no`)
);



ALTER TABLE `order_products` ADD CONSTRAINT `FK_order_TO_order_products_1` FOREIGN KEY (`order_no`) REFERENCES `order` (`order_no`);

ALTER TABLE `order_products` ADD CONSTRAINT `FK_products_TO_order_products_1` FOREIGN KEY (`product_no`) REFERENCES `products` (`product_no`);

ALTER TABLE `shipping` ADD CONSTRAINT `FK_order_TO_shipping_1` FOREIGN KEY (`order_no`) REFERENCES `order` (`order_no`);

ALTER TABLE `order_billing` ADD CONSTRAINT `FK_order_TO_order_billing_1` FOREIGN KEY (`order_no`) REFERENCES `order` (`order_no`);

ALTER TABLE `pointlog` ADD CONSTRAINT `FK_pointpolicy_TO_pointlog_1` FOREIGN KEY (`why`) REFERENCES `pointpolicy` (`why`);

ALTER TABLE `withdraw_customers` ADD CONSTRAINT `FK_customers_TO_withdraw_customers_1` FOREIGN KEY (`email`) REFERENCES `customers` (`email`);

ALTER TABLE `cart` ADD CONSTRAINT `FK_customers_TO_cart_1` FOREIGN KEY (`uuid`) REFERENCES `customers` (`uuid`);

ALTER TABLE `products` ADD CONSTRAINT `FK_manufacturers_TO_products_1` FOREIGN KEY (`manufacturer_no`) REFERENCES `manufacturers` (`manufacturer_no`);

ALTER TABLE `product_likelog` ADD CONSTRAINT `FK_customers_TO_product_likelog_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`uuid`);

ALTER TABLE `product_likelog` ADD CONSTRAINT `FK_products_TO_product_likelog_1` FOREIGN KEY (`product_no`) REFERENCES `products` (`product_no`);

ALTER TABLE `review` ADD CONSTRAINT `FK_customers_TO_review_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`uuid`);

ALTER TABLE `review` ADD CONSTRAINT `FK_products_TO_review_1` FOREIGN KEY (`product_no`) REFERENCES `products` (`product_no`);

ALTER TABLE `image` ADD CONSTRAINT `FK_board_TO_image_1` FOREIGN KEY (`sv_board_no`) REFERENCES `service_board` (`sv_board_no`);

ALTER TABLE `image` ADD CONSTRAINT `FK_review_TO_image_1` FOREIGN KEY (`review_no`) REFERENCES `review` (`review_no`);

ALTER TABLE `image` ADD CONSTRAINT `FK_order_TO_image_1` FOREIGN KEY (`cs_no`) REFERENCES `order_cs` (`cs_no`);

ALTER TABLE `image` ADD CONSTRAINT `FK_board_TO_image_2` FOREIGN KEY (`board_no`) REFERENCES `board` (`board_no`);

ALTER TABLE `image` ADD CONSTRAINT `FK_products_TO_image_1` FOREIGN KEY (`product_no`) REFERENCES `products` (`product_no`);

ALTER TABLE `service_board` ADD CONSTRAINT `FK_products_TO_service_board_1` FOREIGN KEY (`product_no`) REFERENCES `products` (`product_no`);

ALTER TABLE `service_board` ADD CONSTRAINT `FK_customers_TO_service_board_1` FOREIGN KEY (`uuid`) REFERENCES `customers` (`uuid`);

ALTER TABLE `service_board` ADD CONSTRAINT `FK_order_TO_service_board_1` FOREIGN KEY (`order_no`) REFERENCES `order` (`order_no`);

ALTER TABLE `board` ADD CONSTRAINT `FK_category_TO_board_1` FOREIGN KEY (`category_no`) REFERENCES `category` (`category_no`);

ALTER TABLE `board` ADD CONSTRAINT `FK_header_TO_board_1` FOREIGN KEY (`header_no`) REFERENCES `header` (`header_no`);

ALTER TABLE `read_log` ADD CONSTRAINT `FK_board_TO_read_log_1` FOREIGN KEY (`board_no`) REFERENCES `board` (`board_no`);

ALTER TABLE `board_likelog` ADD CONSTRAINT `FK_customers_TO_board_likelog_1` FOREIGN KEY (`uuid`) REFERENCES `customers` (`uuid`);

ALTER TABLE `board_likelog` ADD CONSTRAINT `FK_board_TO_board_likelog_1` FOREIGN KEY (`board_no`) REFERENCES `board` (`board_no`);

ALTER TABLE `reply` ADD CONSTRAINT `FK_board_TO_reply_1` FOREIGN KEY (`board_no`) REFERENCES `board` (`board_no`);

ALTER TABLE `reply` ADD CONSTRAINT `FK_customers_TO_reply_1` FOREIGN KEY (`uuid`) REFERENCES `customers` (`uuid`);

ALTER TABLE `product_img` ADD CONSTRAINT `FK_products_TO_product_img_1` FOREIGN KEY (`product_no`) REFERENCES `products` (`product_no`);

SELECT p.*, m.manufacturer_name, o.class_name
  FROM products p 
	inner join manufacturers m on p.manufacturer_no = m.manufacturer_no
    inner join originals o on p.original_class = o.original_class
 WHERE class_no = 20;
 
select img_url
  from product_img
 where product_no = 37293;
 
 SET SQL_SAFE_UPDATES = 1;
update products set current_qty = CAST(RAND() * 30 AS UNSIGNED);

update products set reserve_qty = CAST(RAND() * 30 AS UNSIGNED);

select * from products where class_no = 20;
update products set reserve_qty = 0 where class_no = 20;

SELECT count(*) FROM products
WHERE class_no = 20;