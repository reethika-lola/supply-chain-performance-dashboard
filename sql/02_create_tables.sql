USE supply_chain_analytics;

DROP TABLE IF EXISTS fact_order_items;
DROP TABLE IF EXISTS dim_shipping;
DROP TABLE IF EXISTS dim_geography;
DROP TABLE IF EXISTS dim_customer;
DROP TABLE IF EXISTS dim_product;
DROP TABLE IF EXISTS dim_date;
DROP TABLE IF EXISTS stg_dataco_raw;

CREATE TABLE stg_dataco_raw (
  type VARCHAR(50), days_shipping_real VARCHAR(20), days_shipment_scheduled VARCHAR(20),
  benefit_per_order VARCHAR(30), sales_per_customer VARCHAR(30), delivery_status VARCHAR(50),
  late_delivery_risk VARCHAR(10), category_id VARCHAR(20), category_name VARCHAR(255),
  customer_city VARCHAR(255), customer_country VARCHAR(255), customer_email VARCHAR(255),
  customer_fname VARCHAR(255), customer_id VARCHAR(20), customer_lname VARCHAR(255),
  customer_password VARCHAR(255), customer_segment VARCHAR(100), customer_state VARCHAR(255),
  customer_street VARCHAR(500), customer_zipcode VARCHAR(30), department_id VARCHAR(20),
  department_name VARCHAR(255), latitude VARCHAR(30), longitude VARCHAR(30), market VARCHAR(100),
  order_city VARCHAR(255), order_country VARCHAR(255), order_customer_id VARCHAR(20),
  order_date_raw VARCHAR(50), order_id VARCHAR(20), order_item_cardprod_id VARCHAR(20),
  order_item_discount VARCHAR(30), order_item_discount_rate VARCHAR(30), order_item_id VARCHAR(20),
  order_item_product_price VARCHAR(30), order_item_profit_ratio VARCHAR(30),
  order_item_quantity VARCHAR(20), sales VARCHAR(30), order_item_total VARCHAR(30),
  order_profit_per_order VARCHAR(30), order_region VARCHAR(255), order_state VARCHAR(255),
  order_status VARCHAR(100), product_card_id VARCHAR(20), product_category_id VARCHAR(20),
  product_description TEXT, product_image TEXT, product_name VARCHAR(500), product_price VARCHAR(30),
  product_status VARCHAR(20), shipping_date_raw VARCHAR(50), shipping_mode VARCHAR(100)
) ENGINE=InnoDB;

CREATE TABLE dim_date (
  date_key INT PRIMARY KEY, full_date DATE NOT NULL UNIQUE, calendar_year SMALLINT NOT NULL,
  calendar_quarter TINYINT NOT NULL, calendar_month TINYINT NOT NULL, month_name VARCHAR(12) NOT NULL,
  year_month CHAR(7) NOT NULL, INDEX idx_date_year_month (year_month)
) ENGINE=InnoDB;

CREATE TABLE dim_product (
  product_key INT AUTO_INCREMENT PRIMARY KEY, product_id BIGINT NOT NULL UNIQUE,
  product_name VARCHAR(500) NULL, product_category_id BIGINT NULL, category_id BIGINT NULL,
  category_name VARCHAR(255) NULL, department_id BIGINT NULL, department_name VARCHAR(255) NULL,
  list_price DECIMAL(12,2) NULL, product_status TINYINT NULL
) ENGINE=InnoDB;

CREATE TABLE dim_customer (
  customer_key INT AUTO_INCREMENT PRIMARY KEY, customer_id BIGINT NOT NULL UNIQUE,
  customer_segment VARCHAR(100) NULL, customer_city VARCHAR(255) NULL,
  customer_state VARCHAR(255) NULL, customer_country VARCHAR(255) NULL
) ENGINE=InnoDB;

CREATE TABLE dim_geography (
  geography_key INT AUTO_INCREMENT PRIMARY KEY, market VARCHAR(100) NOT NULL,
  order_region VARCHAR(255) NOT NULL, order_country VARCHAR(255) NOT NULL,
  order_state VARCHAR(255) NOT NULL, order_city VARCHAR(255) NOT NULL,
  latitude DECIMAL(10,6) NULL, longitude DECIMAL(10,6) NULL,
  UNIQUE KEY uq_geography (market, order_region, order_country, order_state, order_city)
) ENGINE=InnoDB;

CREATE TABLE dim_shipping (
  shipping_key INT AUTO_INCREMENT PRIMARY KEY, shipping_mode VARCHAR(100) NOT NULL,
  delivery_status VARCHAR(50) NOT NULL, late_delivery_risk TINYINT NULL,
  actual_shipping_days INT NULL, scheduled_shipping_days INT NULL,
  UNIQUE KEY uq_shipping (shipping_mode, delivery_status, late_delivery_risk, actual_shipping_days, scheduled_shipping_days)
) ENGINE=InnoDB;

CREATE TABLE fact_order_items (
  order_item_id BIGINT PRIMARY KEY, order_id BIGINT NOT NULL, order_date_key INT NOT NULL,
  product_key INT NOT NULL, customer_key INT NOT NULL, geography_key INT NOT NULL, shipping_key INT NOT NULL,
  quantity INT NOT NULL, gross_sales DECIMAL(14,2) NULL, discount_amount DECIMAL(14,2) NULL,
  discount_rate DECIMAL(8,4) NULL, revenue DECIMAL(14,2) NULL, profit DECIMAL(14,2) NULL,
  profit_ratio_pct DECIMAL(10,4) NULL, item_price DECIMAL(14,2) NULL,
  FOREIGN KEY (order_date_key) REFERENCES dim_date(date_key),
  FOREIGN KEY (product_key) REFERENCES dim_product(product_key),
  FOREIGN KEY (customer_key) REFERENCES dim_customer(customer_key),
  FOREIGN KEY (geography_key) REFERENCES dim_geography(geography_key),
  FOREIGN KEY (shipping_key) REFERENCES dim_shipping(shipping_key),
  INDEX idx_fact_order (order_id), INDEX idx_fact_date (order_date_key),
  INDEX idx_fact_product (product_key), INDEX idx_fact_geography (geography_key)
) ENGINE=InnoDB;
