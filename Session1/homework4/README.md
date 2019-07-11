# Домашнее задание 4
1. Подсчитайте средний возраст пользователей в таблице users

    Решение:

        SELECT AVG(YEAR(CURDATE()) - YEAR(birthday_at)) AS birthday_mid FROM users;
    
2. Подсчитайте количество дней рождения, которые приходятся на каждую из дней недели. Следует учесть, что необходимы дни недели текущего года, а не годы рождения.

    Решение:

        ![image](https://raw.githubusercontent.com/acoshi/BigDataCourse/master/Session1/homework4/image1.png)

3. Подсчитать произведение чисел в слолбце таблицы.

    Решение:

        В процессе решения