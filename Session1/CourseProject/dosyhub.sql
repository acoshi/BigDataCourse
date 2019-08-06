
DROP TABLE IF EXISTS domains;
CREATE TABLE domains (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  domain VARCHAR(255) NOT NULL,
  country_group_id SMALLINT UNSIGNED NOT NULL,
  country_by_ip_id SMALLINT UNSIGNED NOT NULL,
  country_by_html_id SMALLINT UNSIGNED NOT NULL,
  webserver_id TINYINT UNSIGNED NOT NULL,
  domain_type_id TINYINT UNSIGNED NOT NULL,
  domain_owner_id INT UNSIGNED NOT NULL,
  created_at DATETIME DEFAULT NOW(),
  updated_at DATETIME DEFAULT NOW() ON UPDATE NOW(),
  INDEX domains_domain_idx (domain),
  CONSTRAINT domains_country_group_id_fk FOREIGN KEY (country_group_id) REFERENCES countries(id),
  CONSTRAINT domains_country_by_ip_id_fk FOREIGN KEY (country_by_ip_id) REFERENCES countries(id),
  CONSTRAINT domains_country_by_html_id_fk FOREIGN KEY (country_by_html_id) REFERENCES countries(id),
  CONSTRAINT domains_webserver_id_fk FOREIGN KEY (webserver_id) REFERENCES webserver(id),
  CONSTRAINT domains_domain_type_id_fk FOREIGN KEY (domain_type_id) REFERENCES domain_type(id),
  CONSTRAINT domains_domain_owner_id_fk FOREIGN KEY (domain_owner_id) REFERENCES domain_owner_profiles(id)
);

DROP TABLE IF EXISTS countries;
CREATE TABLE countries (
	id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	country_code varchar(2) NOT NULL,
	country_name varchar(100) NOT NULL
);

DROP TABLE IF EXISTS webserver;
CREATE TABLE webserver (
	id TINYINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	webserver_name varchar(50) NOT NULL
);

DROP TABLE IF EXISTS dns_records;
CREATE TABLE dns_records (
	domain_id INT UNSIGNED NOT NULL,
	mx_record varchar(255) NOT NULL,
	ns_record varchar(255) NOT NULL,
	a_record varchar(255) NOT NULL,
	INDEX dns_records_domain_id_idx(domain_id),
	CONSTRAINT dns_records_domain_id_fk FOREIGN KEY (domain_id) REFERENCES domains(id)
);

DROP TABLE IF EXISTS domain_types;
CREATE TABLE domain_type (
	id TINYINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	type varchar(20) NOT NULL
);

DROP TABLE IF EXISTS domain_owner_profiles;
CREATE TABLE domain_owner_profiles (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  firstname VARCHAR(50) NOT NULL,
  lastname VARCHAR(50) NOT NULL,
  phone varchar(100) NOT NULL,
  fax varchar(255) NOT NULL,
  email varchar(100) NOT NULL,
  INDEX domain_owner_profiles_firstname_lastname_idx (firstname, lastname)
 );