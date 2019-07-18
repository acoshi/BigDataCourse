# Домашнее задание 3
1. Пусть в таблице users поля created_at и updated_ad оказались незаполненными. Заполните их текущей датой и временем.
    
    Решение:
    
        UPDATE users SET created_at=NOW(), updated_at=NOW();


2. Таблица users была неудачно спроектирована. Записи created_at и  updated_at были заданы типом VARCHAR и в них долгое время помещались значениея в формате "20.10.2017 8:10". Необходимо преобразовать поля к типу DATETIME, сохранив введеные ранее значения.

    Решение:

        1. Приважу записи в created_at и  updated_at к стандарту как в DATETIME

        UPDATE users SET created_at=DATE_FORMAT(STR_TO_DATE(created_at, '%d.%m.%Y %H:%m'), '%Y-%m-%d %H:%m:%s'), 
                         updated_at=DATE_FORMAT(STR_TO_DATE(updated_at, '%d.%m.%Y %H:%m'), '%Y-%m-%d %H:%m:%s');
        
        2. Переименовываю users_new в users

        ALTER TABLE users ALTER COLUMN created_at DATATIME;
        ALTER TABLE users ALTER COLUMN updated_at DATATIME; 

3. В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цыфры: 0, если товар закончился и выще нуля, если на складе имеются запасы.
Необходимо отсортировать запасы таким образом, чтобы они выводились в порядке увеличения значения value. Однако, нулевые запасы должны выводится в конце, после всех записей.

    Решение:

    SELECT value FROM storehouses_products ORDER BY value=0, value;

4. Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. Месяца заданы в виде списписка английских названий('may', 'august')

    Решение:

    SELECT * FROM users WHERE month LIKE 'may' OR month LIKE 'august';

5. Из таблицы catalogs извлекаются записи при помощи запроса. SELECT * FROM catalogs WHERE id IN (5, 1, 2);
Отсоптируйте записи в порядке, заданном в списке IN.

    Решение:

    SELECT * FROM catalogs WHERE id IN (5, 1, 2) ORDER BY FIELD(id, 5, 1, 2);



