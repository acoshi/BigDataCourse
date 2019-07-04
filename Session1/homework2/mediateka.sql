DROP TABLE IF EXISTS tags;
CREATE TABLE tags (
  id SERIAL PRIMARY KEY,
  tag VARCHAR(50) NOT NULL COMMENT 'Название категории',
  UNIQUE unique_name(tag(10))
) COMMENT = 'Категории медиа контента';


DROP TABLE IF EXISTS media;
CREATE TABLE media (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL COMMENT 'Нащвание мелиа файла',
  description VARCHAR(255) NOT NULL COMMENT 'Описание файла', 
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
) COMMENT = 'Список медиа файлов';



DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL COMMENT 'Пользователь',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE unique_name(name(10))
) COMMENT = 'Пользователь';

DROP TABLE IF EXISTS paths;
CREATE TABLE paths (
  id SERIAL PRIMARY KEY,
  path VARCHAR(255) NOT NULL COMMENT 'путь к файлу',
  UNIQUE unique_name(path(10))
); COMMENT = 'полный путь к файлу';