# Тема 8 "Хранимые процедуры и функции, триггеры"

1. Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток. С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".

    Решение:

        DELIMITER //
        CREATE FUNCTION hello()
        RETURNS VARCHAR (50) NOT DETERMINISTIC
        
        BEGIN
	        DECLARE time TINYINT;
	        SET time = HOUR(NOW());
	    CASE
		    WHEN time >= 0 AND time <= 6 THEN RETURN "Good night";
		    WHEN time >= 6 AND time <= 12 THEN RETURN "Good morning";
		    WHEN time >= 12 AND time <= 18 THEN RETURN "Good day";
		    WHEN time >= 18 AND time <= 24 THEN RETURN "Good evening";
  	    END CASE;
        END//


        SELECT NOW(), hello()//

        
2. В таблице products есть два текстовых поля: name с названием товара и description с его описанием. Допустимо присутствие обоих полей или одно из них. Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема. Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены. При попытке присвоить полям NULL-значение необходимо отменить операцию.

    Решение:

        Для того что бы таблиуа products приняла параметры мы должны импользовать либо 
        INSERT либо UPDATE. 
        Нужно создать два тригера.

        DELIMITER //
        CREATE TRIGGER name_validation_insert BEFORE INSERT ON products
        FOR EACH ROW BEGIN
        IF NEW.name IS NULL AND NEW.desription IS NULL THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Warning!! Name and desription are NULL';
        END IF;
        END// 


        DELIMITER //
        CREATE TRIGGER name_validation_update BEFORE UPDATE ON products
        FOR EACH ROW BEGIN
        IF NEW.name IS NULL AND NEW.desription IS NULL THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Warning!! Name and desription are NULL';
        END IF;
        END//
    
3. (по желанию) Напишите хранимую функцию для вычисления произвольного числа Фибоначчи. Числами Фибоначчи называется последовательность в которой число равно сумме двух предыдущих чисел. Вызов функции FIBONACCI(10) должен возвращать число 55.

    Решение:


# Тема 9 "Оптимизация запросов"

1. Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, catalogs и products в таблицу logs помещается время и дата создания записи, название таблицы, идентификатор первичного ключа и содержимое поля name.

    Решение:

        CREATE TABLE logs (
            tablename VARCHAR(255),
            tablename_id INT,
            tablename_data VARCHAR(255),
            created_at DATETIME DEFAULT CURRENT_TIMESTAMP
        ) ENGINE=Archive;

    &nbsp;

        CREATE TRIGGER after_insert_users AFTER INSERT ON users
        FOR EACH ROW BEGIN
        INSERT INTO 
            logs (tablename, tablename_id, tablename_data) 
        VALUES 
            ('users', NEW.id, NEW.name);
        END//
    &nbsp;

        CREATE TRIGGER after_insert_products AFTER INSERT ON products
        FOR EACH ROW BEGIN
            INSERT INTO     logs (tablename, tablename_id, tablename_data) 
        VALUES 
            ('products', NEW.id, NEW.name);
        END//
    &nbsp;

        CREATE TRIGGER after_insert_catalogs AFTER INSERT ON catalogs
        FOR EACH ROW BEGIN
            INSERT INTO     logs (tablename, tablename_id, tablename_data) 
        VALUES 
            ('catalogs', NEW.id, NEW.name);
        END//
2. (по желанию) Создайте SQL-запрос, который помещает в таблицу users миллион записей.

    Решение:
    
# Тема 10 "NoSQL"

1. В базе данных Redis подберите коллекцию для подсчета посещений с определенных IP-адресов.

    Решение:

        HINCRBY ipaddress '192.168.0.12' 1
        HINCRBY ipaddress '192.168.0.111' 1
        HINCRBY ipaddress '192.168.0.111' 2
        HGETALL ipaddress
        Output:
        1) "192.168.0.12"
        2) "1"
        3) "192.168.0.111"
        4) "3"

        С IP 192.168.0.12 было одно посищение, с IP 192.168.0.111 было 3.
        

    
2. При помощи базы данных Redis решите задачу поиска имени пользователя по электронному адресу и наоборот, поиск электронного адреса пользователя по его имени.

    Решение:

        HSET user alex alex@gmail.com
        HSET user diana diana@email.com
        HSET user dasha dasha@data.com

        Выводим все записи по ключу user
        HGETALL user
        1) "alex"
        2) "alex@gmail.com"
        3) "diana"
        4) "diana@email.com"
        5) "dasha"
        6) "dasha@data.com"

        Поиск емайла по имени
        HGET user alex
        "alex@gmail.com"

        Поиск пользователя по емайлу
        HSET email alex@gmail.com alex
        HSET email diana@email.com diana
        HSET email dasha@data.com dasha

        HGETALL email
        1) "alex@gmail.com"
        2) "alex"
        3) "diana@email.com"
        4) "diana"
        5) "dasha@data.com"
        6) "dasha"

        HGET email alex@gmail.com
        "alex"

    
3. Организуйте хранение категорий и товарных позиций учебной базы данных shop в СУБД MongoDB.

    Решение:

        use shop

        db.createCollection('catalogs')
        db.createCollection('products')

        db.catalogs.insert({name: 'Процессоры'})
        db.catalogs.insert({name: 'Мат.платы'})
        db.catalogs.insert({name: 'Видеокарты'})

        db.catalogs.find()
        { "_id" : ObjectId("5d3ebe1b3b5e1ac84a3325f7"), "name" : "Процессоры" }
        { "_id" : ObjectId("5d3ebe373b5e1ac84a3325f8"), "name" : "Мат.платы" }
        { "_id" : ObjectId("5d3ebe3b3b5e1ac84a3325f9"), "name" : "Видеокарты" }

        db.products.insert(
            {
                name: 'Intel Core i5-7400',
                description: 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.',
                price: 12700.00,
                catalog_id: new ObjectId("5d3ebe1b3b5e1ac84a3325f7")
            }
        );
        db.products.insert(
            {
                name: 'Intel Core i5-7400',
                description: 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.',
                price: 12700.00,
                catalog_id: new ObjectId("5d3ebe1b3b5e1ac84a3325f7")
            }
        );
        db.products.insert(
            {
                name: 'Gigabyte H310M S2H',
                description: 'Материнская плата Gigabyte H310M S2H, H310, Socket 1151-V2, DDR4, mATX',
                price: 12700.00,
                catalog_id: new ObjectId("5d3ebe373b5e1ac84a3325f8")
            }
        );

        db.products.find()
            { "_id" : ObjectId("5d3ebf273b5e1ac84a3325fa"), "name" : "Intel Core i3-8100", "description" : "Процессор для настольных персональных компьютеров, основанных на платформе Intel.", "price" : 7890, "catalog_id" : ObjectId("5d3ebe1b3b5e1ac84a3325f7") }
            { "_id" : ObjectId("5d3ebf593b5e1ac84a3325fb"), "name" : "Intel Core i5-7400", "description" : "Процессор для настольных персональных компьютеров, основанных на платформе Intel.", "price" : 12700, "catalog_id" : ObjectId("5d3ebe1b3b5e1ac84a3325f7") }
            { "_id" : ObjectId("5d3ebfac3b5e1ac84a3325fc"), "name" : "Gigabyte H310M S2H", "description" : "Материнская плата Gigabyte H310M S2H, H310, Socket 1151-V2, DDR4, mATX", "price" : 12700, "catalog_id" : ObjectId("5d3ebe373b5e1ac84a3325f8") }


