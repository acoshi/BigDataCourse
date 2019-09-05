# Тема "Сложные запросы"
1.Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.

    Решение:
        SELECT name , count(o.user_id) AS count FROM users u RIGHT JOIN orders o ON u.id=o.user_id GROUP BY name HAVING COUNT(user_id) > 1;


2. Выведите список товаров products и разделов catalogs, который соответствует товару.
    
    Решение:

        SELECT p.name, p.desription, p.price, c.name FROM products AS p JOIN catalogs as c WHERE p.catalog_id=c.id;

3. Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). 
   Поля from, to и label содержат английские названия городов, поле name — русское. 
   Выведите список рейсов flights с русскими названиями городов.

    Решение:
