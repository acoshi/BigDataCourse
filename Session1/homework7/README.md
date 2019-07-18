# Тема "Транзакции, переменные, представления"

1. В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных. Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции.

    Решение:
        
        START TRANSACTION;
        INSERT INTO sample.users  SELECT * FROM shop.users AS su WHERE su.id=1;
        COMMIT;

2. Создайте представление, которое выводит название name товарной позиции из таблицы products и соответствующее название каталога name из таблицы catalogs.

    Решение:
 
        CREATE VIEW producsts_v_catalogs AS  SELECT p.name AS mothebords, c.name AS names FROM products AS p JOIN catalogs as c WHERE p.catalog_id=c.id;
