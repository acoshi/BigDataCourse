# Урок 6. "Транзакции, переменные, представления. Администрирование MySQL"

### Запросы по БД vk. Запросы необходимо строить с использованием JOIN !

1. Пусть задан некоторый пользователь.Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим пользоваетелем.

    Решение:
        
        SELECT
            u.firstname 
        FROM
            users u 
        INNER JOIN 
            friendship f 
        ON 
            u.id=f.friend_id 
        INNER JOIN 
            messages 
        AS 
            m
        ON 
            f.friend_id=m.to_user_id 
        WHERE 
            f.user_id=1 
        GROUP BY 
            u.id;
Коментарий. Данные генерировал занова для JOIN запросов есть расхождение с SELECT запросами.


2. Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей.

    Решение:

        SELECT 
            sum(Total) 
        AS 
            TotalLikes 
        FROM 
            (
                SELECT 
                    COUNT(*)  
                AS 
                    Total 
                FROM 
                    likes l
                INNER JOIN 
                    profiles 
                AS 
                    p
                ON 
                    l.to_user_id=p.user_id 
                GROUP BY 
                    TIMESTAMPDIFF(DAY, p.birthday, NOW()) 
                LIMIT
                    10
            ) 
        AS 
            src;

3. Определить кто больше поставил лайков (всего) - мужчины или женщины?

    Решение:
        
        SELECT 
            COUNT(p1.sex) 
        AS 
            f_likes, COUNT(p2.sex)
        AS 
            m_likes 
        FROM 
            likes l 
        LEFT JOIN 
            profiles p1 
        ON 
            l.from_user_id = p1.user_id 
        AND 
            p1.sex='F' 
        LEFT JOIN 
            profiles p2 
        ON 
            l.from_user_id = p2.user_id 
        AND 
            p2.sex='M';


4. Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети.

    Решение:
