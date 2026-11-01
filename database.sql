CREATE TABLE IF NOT EXISTS hotels (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  description VARCHAR(250) DEFAULT '',
  image VARCHAR(1000) DEFAULT '',
  is_open TINYINT(1) NOT NULL DEFAULT 1,
  sort_order INT NOT NULL DEFAULT 0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS menu_items (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  hotel_id INT UNSIGNED NOT NULL,
  name VARCHAR(100) NOT NULL,
  description VARCHAR(250) DEFAULT '',
  image VARCHAR(1000) DEFAULT '',
  variants_json JSON NOT NULL,
  available TINYINT(1) NOT NULL DEFAULT 1,
  sort_order INT NOT NULL DEFAULT 0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_menu_hotel FOREIGN KEY (hotel_id) REFERENCES hotels(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS token_counters (
  counter_date DATE PRIMARY KEY,
  last_number INT UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS orders (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  token VARCHAR(32) NOT NULL UNIQUE,
  hotel_id INT UNSIGNED NOT NULL,
  hotel_name VARCHAR(100) NOT NULL,
  item_id INT UNSIGNED NOT NULL,
  item_name VARCHAR(100) NOT NULL,
  variant VARCHAR(50) NOT NULL,
  quantity INT UNSIGNED NOT NULL,
  unit_price DECIMAL(10,2) NOT NULL,
  total DECIMAL(10,2) NOT NULL,
  customer_name VARCHAR(80) NOT NULL,
  phone VARCHAR(10) NOT NULL,
  address VARCHAR(500) NOT NULL,
  payment ENUM('COD','UPI') NOT NULL DEFAULT 'COD',
  status ENUM('received','preparing','ready','completed','cancelled') NOT NULL DEFAULT 'received',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEX idx_orders_created(created_at),
  INDEX idx_orders_status(status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS settings (
  setting_key VARCHAR(80) PRIMARY KEY,
  setting_value VARCHAR(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT IGNORE INTO settings(setting_key,setting_value) VALUES('shop_status','open');
INSERT INTO hotels(name,description,image,is_open)
SELECT 'Village Food Point','Fresh local favourites · Basavakalyan','',1
WHERE NOT EXISTS (SELECT 1 FROM hotels);
