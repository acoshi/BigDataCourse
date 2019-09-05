# Урок 4. "Агрегация данных. Сложные запросы"

1. Пусть задан некоторый пользователь.
Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим пользоваетелем.

    Решение:

        SELECT firstname 
            FROM users 
            WHERE id 
        IN ( 
            SELECT friend_id 
                FROM friendship 
                WHERE user_id=1 AND friend_id 
            IN (
                SELECT COUNT(*) AS total 
                    FROM messages 
                    WHERE to_user_id=1 
                    GROUP BY from_user_id 
                    ORDER BY total DESC 
                )
            );

2. Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей.

    Решение:

        SELECT COUNT(*) AS Total_Likes 
            FROM likes 
            WHERE to_user_id 
        IN ( 
            SELECT young.user_id 
                FROM (
                    SELECT user_id, TIMESTAMPDIFF(DAY, birthday, NOW()) AS age_day 
                        FROM profiles 
                        ORDER BY age_day 
                        LIMIT 10
                    ) AS young
            );


3. Определить кто больше поставил лайков (всего) - мужчины или женщины?

    Решение:

        SELECT * 
            FROM (
                (SELECT COUNT(*) 
                    AS win 
                    FROM likes 
                    WHERE from_user_id 
                    IN (
                        SELECT user_id 
                            FROM profiles 
                            WHERE sex='F')
                ) UNION
                    (SELECT COUNT(*) 
                        FROM likes 
                        WHERE from_user_id 
                        IN (
                            SELECT user_id 
                                FROM profiles 
                                WHERE sex='M')
                    )
                ) 
        AS i ORDER BY win DESC
        LIMIT 1;


4. Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети.

    Решение:

        SELECT 
            user.id AS id, SUM(user.actions) AS actions 
        FROM (
            SELECT 
                from_user_id AS id, COUNT(*) AS actions 
            FROM 
                likes 
            GROUP BY 
                id 
            UNION ALL 
            SELECT 
                from_user_id AS id, COUNT(*) AS actions 
            FROM 
                messages 
            GROUP BY 
                id) 
        AS 
            user 
        GROUP BY 
            id 
        ORDER BY 
            actions
        LIMIT
             10;