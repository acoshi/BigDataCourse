DROP TABLE IF EXISTS tags;
CREATE TABLE tags (
  id SERIAL PRIMARY KEY,
  tag_id INT UNSIGNED,
  name VARCHAR(50) COMMENT 'Название категории',
  UNIQUE unique_name(name(10))
) COMMENT = 'Категории медиа контента';


DROP TABLE IF EXISTS media_list;
CREATE TABLE media_list (
  id SERIAL PRIMARY KEY,
  user_id INT UNSIGNED,
  tag_id INT UNSIGNED,
  path_id INT UNSIGNED,  
  name VARCHAR(255) COMMENT 'Нащвание мелиа файла',
  description VARCHAR(255) COMMENT 'Описание файла', 
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY index_of_user_id(user_id),
  KEY index_of_tag_id(tag_id),
  KEY index_of_path_id(path_id),
) COMMENT = 'Список медиа файлов';



DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  user_id INT UNSIGNED,
  name VARCHAR(255) COMMENT 'Пользователь',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Пользователь';

DROP TABLE IF EXISTS path;
CREATE TABLE path (
  id SERIAL PRIMARY KEY,
  path_id INT UNSIGNED,
  name VARCHAR(255) COMMENT 'путь к файлу'
); COMMENT = 'полный путь к файлу';