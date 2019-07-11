# Домашнее задание 3
1. Пусть в таблице users поля created_at и updated_ad оказались незаполненными. Заполните их текущей датой и временем.
    
    Решение:
    
        UPDATE users SET created_at=NOW(), updated_at=NOW();


2. Таблица users была неудачно спроектирована. Записи created_at и  updated_at были заданы типом VARCHAR и в них долгое время помещались значениея в формате "20.10.2017 8:10". Необходимо преобразовать поля к типу DATETIME, сохранив введеные ранее значения.

    Решение:

        1. Создаю новую таблицу users_new
          
        CREATE TABLE users_new (
            id SERIAL PRIMARY KEY,
            name VARCHAR(255) COMMENT 'Имя покупателя',
            birthday_at DATE COMMENT 'Дата рождения',
            created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
            updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
        ) COMMENT = 'Покупатели';

        2. Приважу записи в created_at и  updated_at к стандарту как в DATETIME

        UPDATE users SET created_at=DATE_FORMAT(STR_TO_DATE(created_at, '%d.%m.%Y %H:%m'), '%Y-%m-%d %H:%m:%s'), 
                         updated_at=DATE_FORMAT(STR_TO_DATE(updated_at, '%d.%m.%Y %H:%m'), '%Y-%m-%d %H:%m:%s');
        
        3. Вставляю данные из таблицы users в users_new

        INSERT INTO users_new (id, name, birthday_at, created_at, updated_at) SELECT id, name, birthday_at, created_at, updated_at FROM users;

        4. Удаляю таблицу users

        DROP TABLE users;

        5. Переименовываю users_new в users

        RENAME TABLE users_new TO users;

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



