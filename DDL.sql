/*CREATE TABLE self(
href VARCHAR(100) NOT NULL,
PRIMARY KEY (href))

CREATE TABLE collection(
href VARCHAR(100) NOT NULL,
PRIMARY KEY (href))

CREATE TABLE up(
href VARCHAR(100) NOT NULL,
PRIMARY KEY (href))

CREATE TABLE _links(
id DOUBLE PRECISION NOT NULL,
FOREIGN KEY (id) REFERENCES products(id)
)

CREATE TABLE _links(
id DOUBLE PRECISION NOT NULL,
FOREIGN KEY (id) REFERENCES categories(id)
)

CREATE TABLE _links(
id DOUBLE PRECISION NOT NULL,
FOREIGN KEY (id) REFERENCES tags(id)
)

CREATE TABLE _links(
id DOUBLE PRECISION NOT NULL,
FOREIGN KEY (id) REFERENCES reviews(id)
)

CREATE TABLE meta_data(
id DOUBLE PRECISION NOT NULL,
id DOUBLE PRECISION NOT NULL,
key VARCHAR(50) NOT NULL,
PRIMARY KEY (id),
FOREIGN KEY (id) REFERENCES products(id)
)

CREATE TABLE value(
id DOUBLE PRECISION NOT NULL,
FOREIGN KEY (id) REFERENCES meta_data(id)
)

CREATE TABLE vc_grid_id(
)

CREATE TABLE downloads(
id DOUBLE PRECISION NOT NULL,
FOREIGN KEY (id) REFERENCES products(id)
)

*/

CREATE TABLE image(
	id bigint not null,
	date_created TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	date_modified TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	src VARCHAR(300),
	name VARCHAR(100),
	alt VARCHAR(50),
	PRIMARY KEY (id)
);

CREATE TABLE categories(
	id bigserial not null,
	name VARCHAR(100),
	slug VARCHAR(100),
	parent smallint NOT NULL DEFAULT 0,
	description VARCHAR(2000),
	display VARCHAR(50),
	menu_order smallint NOT NULL DEFAULT 0,
	count smallint NOT NULL DEFAULT 0,
	PRIMARY KEY (id),
	FOREIGN KEY (id) REFERENCES image(id)
);

CREATE TABLE tags(
	id bigserial not null,
	name VARCHAR(100),
	slug VARCHAR(100),
	description VARCHAR(5000),
	count smallint NOT NULL DEFAULT 0,
	PRIMARY KEY (id)
);

CREATE TABLE dimensions(
	id bigserial not null,
	id_product bigint not null,
	length VARCHAR(50),
	width VARCHAR(50),
	height VARCHAR(50),
	PRIMARY KEY (id)
);

CREATE TABLE products(
	id bigserial not null,
	name VARCHAR(100),
	slug VARCHAR(100),
	permalink VARCHAR(1000),
	date_created TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	date_modified TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	type VARCHAR(50),
	status VARCHAR(50),
	featured boolean DEFAULT false,
	catalog_visibility VARCHAR(50),
	description VARCHAR(5000),
	short_description VARCHAR(1000),
	sku VARCHAR(50),
	price VARCHAR(50),
	regular_price VARCHAR(50),
	sale_price VARCHAR(50),
	price_html VARCHAR(350),
	on_sale boolean DEFAULT true,
	purchasable boolean DEFAULT true,
	total_sales NUMERIC,
	virtual boolean DEFAULT false,
	downloadable boolean DEFAULT false,
	download_limit smallint NOT NULL DEFAULT -1,
	download_expiry smallint NOT NULL DEFAULT -1,
	external_url VARCHAR(5000),
	button_text VARCHAR(50),
	tax_status VARCHAR(50),
	tax_class VARCHAR(50),
	manage_stock boolean DEFAULT true,
	stock_quantity smallint NOT NULL DEFAULT 0,
	in_stock boolean DEFAULT true,
	backorders VARCHAR(50),
	backorders_allowed boolean DEFAULT false,
	backordered boolean DEFAULT false,
	sold_individually boolean DEFAULT false,
	weight VARCHAR(50),
	shipping_required boolean DEFAULT true,
	shipping_taxable boolean DEFAULT true,
	shipping_class VARCHAR(50),
	shipping_class_id bigint,
	reviews_allowed boolean DEFAULT true,
	average_rating NUMERIC (3, 2) DEFAULT 0,
	rating_count smallint NOT NULL DEFAULT 0,
	parent_id smallint NOT NULL DEFAULT 0,
	purchase_note VARCHAR(500),
	menu_order smallint NOT NULL DEFAULT 0,
	PRIMARY KEY (id),
	FOREIGN KEY (id) REFERENCES dimensions(id)
);

CREATE TABLE images(
	id bigserial not null,
	id_product bigint not null,
	date_created TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	date_modified TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	src VARCHAR(300),
	name VARCHAR(100),
	alt VARCHAR(50),
	position smallint NOT NULL DEFAULT 0,
	PRIMARY KEY (id),
	FOREIGN KEY (id_product) REFERENCES products(id)
);

CREATE TABLE related_products(
	id bigserial not null,
	id_product bigint not null,
	id_product_relative bigint not null,
	PRIMARY KEY (id),
	FOREIGN KEY (id_product) REFERENCES products(id),
	FOREIGN KEY (id_product_relative) REFERENCES products(id)
);

CREATE TABLE cross_sell_ids(
	id bigserial not null,
	id_product bigint not null,
	id_product_relative bigint not null,
	PRIMARY KEY (id),
	FOREIGN KEY (id_product) REFERENCES products(id),
	FOREIGN KEY (id_product_relative) REFERENCES products(id)
);

CREATE TABLE upsell_ids(
	id bigserial not null,
	id_product bigint not null,
	id_product_relative bigint not null,
	PRIMARY KEY (id),
	FOREIGN KEY (id_product) REFERENCES products(id),
	FOREIGN KEY (id_product_relative) REFERENCES products(id)
);

CREATE TABLE tag_product(
	id bigserial not null,
	id_tag bigint not null,
	id_product bigint not null,
	PRIMARY KEY (id),
	FOREIGN KEY (id_tag) REFERENCES tags(id),
	FOREIGN KEY (id_product) REFERENCES products(id)
);

CREATE TABLE reviews(
	id bigserial not null,
	id_product bigint not null,
	date_created TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	review VARCHAR(2000),
	rating NUMERIC (3, 2) DEFAULT 0.00,
	name VARCHAR(50),
	email VARCHAR(50),
	verified boolean DEFAULT false,
	PRIMARY KEY (id),
	FOREIGN KEY (id_product) REFERENCES products(id)
);

CREATE TABLE variations(
	id bigserial not null,
	id_product bigint not null,
	variations smallint,
	PRIMARY KEY (id),
	FOREIGN KEY (id_product) REFERENCES products(id)
);

CREATE TABLE groups(
	id bigserial not null,
	name VARCHAR(100),
	PRIMARY KEY (id)
);

CREATE TABLE grouped_products(
	id bigserial not null,
	id_product bigint not null,
	id_group bigint not null,
	PRIMARY KEY (id),
	FOREIGN KEY (id_product) REFERENCES products(id),
	FOREIGN KEY (id_group) REFERENCES groups(id)
);

CREATE TABLE brands(
	id bigserial not null,
	name VARCHAR(100),
	slug VARCHAR(100),
	PRIMARY KEY (id)
);

CREATE TABLE brands_products(
	id bigserial not null,
	id_product bigint not null,
	id_brand bigint not null,	
	PRIMARY KEY (id),
	FOREIGN KEY (id_product) REFERENCES products(id),
	FOREIGN KEY (id_brand) REFERENCES brands(id)
);

CREATE TABLE options(
	id bigserial not null,
	options VARCHAR(500),
	PRIMARY KEY (id)
);

CREATE TABLE attributes(
	id bigserial not null,
	id_product bigint not null,
	name VARCHAR(100),
	position smallint NOT NULL DEFAULT 0,
	visible VARCHAR(50),
	variation VARCHAR(50),
	PRIMARY KEY (id),
	FOREIGN KEY (id_product) REFERENCES products(id)
);

CREATE TABLE attributes_options(
	id bigserial not null,
	id_attribute bigint not null,
	id_option bigint not null,	
	PRIMARY KEY (id),
	FOREIGN KEY (id_attribute) REFERENCES attributes(id),
	FOREIGN KEY (id_option) REFERENCES options(id)
);

CREATE TABLE default_attributes(
	id bigserial not null,
	id_product bigint not null,
	id_option bigint not null,
	name VARCHAR(100),
	PRIMARY KEY (id),
	FOREIGN KEY (id_product) REFERENCES products(id),
	FOREIGN KEY (id_option) REFERENCES options(id)
);
 