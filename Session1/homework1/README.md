# Домашнее задание 1
1.Создайте базу данных example, разместите в ней таблицу users, состоящую из двух столбцов, числового id и строкового name.

    DROP DATABASE IF EXISTS example;
    CREATE DATABASE example CHARACTER SET utf8 COLLATE utf8_general_ci; 
    DROP TABLE IF EXISTS users;
    CREATE TABLE users (
        id INT,
        name VARCHAR(50)
    );

2. Создайте дамп базы данных example из предыдущего задания, разверните содержимое дампа в новую базу данных sample.

    DROP DATABASE IF EXISTS sample;
    CREATE DATABASE sample CHARACTER SET utf8 COLLATE utf8_general_ci;

    mysql sample < example.sql

3. Ознакомьтесь более подробно с документацией утилиты mysqldump. Создайте дамп единственной таблицы help_keyword базы данных mysql. Причем добейтесь того, чтобы дамп содержал только первые 100 строк таблицы.

    Дамп находится в папке homework1. Название файла help_keyword.sql.

