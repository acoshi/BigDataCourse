# Тема "Администрирование MySQL" (эта тема изучается по вашему желанию)

1. Создайте двух пользователей которые имеют доступ к базе данных shop. Первому пользователю shop_read должны быть доступны только запросы на чтение данных, 
   второму пользователю shop — любые операции в пределах базы данных shop.

    Решение:

        GRAND SELECT ON shop.* TO 'shop_read'@'%' IDENTIFIED BY 'password';
        GRANT ALL ON shop.* TO 'shop'@'%' IDENTIFIED BY 'password1'


2. (по желанию) Пусть имеется таблица accounts содержащая три столбца id, name, password, содержащие первичный ключ, имя пользователя и его пароль. 
   Создайте представление username таблицы accounts, предоставляющий доступ к столбца id и name. 
   Создайте пользователя user_read, который бы не имел доступа к таблице accounts, однако, мог бы извлекать записи из представления username.

    Решение:

        CREATE VIEW username AS SELECT id, name FROM accounts;
        REVOKE ALL ON shop.accounts TO 'user_read'@'%' IDENTIFIED BY 'password';
        GRAND SELECT ON shop.username TO 'user_read'@'%' IDENTIFIED BY 'password';

