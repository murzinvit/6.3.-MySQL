### 6.3.-MySQL </br>
-------------------------------------------------------------------------------------
### Задача 1:
Используя docker поднимите инстанс MySQL (версию 8). Данные БД сохраните в volume: </br>
1) Загрузка контейнера: `docker pull mysql:8` </br>
2) Запуск контейнера: `docker run -d -e MYSQL_ROOT_PASSWORD=pass -v /DATABASE/mysql-data:/var/lib/mysql --name mysrv mysql:8` </br>
3) Вход в контейнер: `docker exec -it mysrv /bin/bash` </br>

Изучите [бэкап БД](https://github.com/murzinvit/6.3_MySQL/blob/da7841c0c982eb7c4cddc2f5212a2801cd888445/test_dump.sql) и восстановитесь из него: </br>
1) Скопировать файл дампа в папку контейнера: `cp test_dump.sql ~/mysql-data` </br>
2) Создать базу test_db в контейнере: `mysql -u root -p`, `create database test_db character set utf8;` <\br>
3) Восстановление из test_dump.sql в test_db: `cd /var/lib/mysql`,  `mysql -u root p test_db < test_dump.sql` </br>

Перейдите в управляющую консоль mysql внутри контейнера: </br>
1) `docker exec -it mysrv /bin/bash` </br>
2) `mysql -u root -p` </br>

Используя команду \h получите список управляющих команд: </br>
Найдите команду для выдачи статуса БД и приведите в ответе из ее вывода версию сервера БД. </br>
#### Команда для получения статуса БД: `status;` </br>
![screen](https://github.com/murzinvit/screen/blob/abc2a3f6db5769308e626e899ca6fe028c36a206/mysql_status_result.jpg)</br>

Подключитесь к восстановленной БД и получите список таблиц из этой БД: </br>
1) `mysql -u root -p` </br>
2) `use test_db;` </br>
3) `show tables;` </br>

Приведите в ответе количество записей с price > 300: </br>
1) 1 запись с price > 300, запрос: `select price from orders where price > 300;` </br>
[screen](https://github.com/murzinvit/screen/blob/eeafd190f797ccf2e2680ff75c1bf13904d9026d/Mysql_select_result.jpg)

### Задача 2: </br>
Создайте пользователя test в БД c паролем test-pass, используя: </br> 
Документация по запросу [ALTER USER](https://dev.mysql.com/doc/refman/8.0/en/alter-user.html) </br>
Также запросы хорошо ищуться по названиям полей из таблицы - `use mysql;` , `describe users;` </br>
1) Создать: `CREATE USER 'test'@'localhost'IDENTIFIED WITH mysql_native_password BY 'test-pass';` </br>
2) Срок действия пароля: `ALTER USER 'test'@'localhost' PASSWORD EXPIRE INTERVAL 180 DAY;`</br>
3) Попыток авторизации - 3: `ALTER USER 'test'@'localhost' FAILED_LOGIN_ATTEMPTS 3 PASSWORD_LOCK_TIME 2;`</br>
4) Максимальное кол-во запросов в час - 100: `ALTER USER 'test'@'localhost' WITH MAX_QUERIES_PER_HOUR 100;` [документация](https://dev.mysql.com/doc/refman/8.0/en/alter-user.html#alter-user-resource-limits)</br>
5) Дать права на SELECT: `GRANT SELECT ON test_db.* TO 'test'@'localhost';` </br>
6) Просмотр прав пользователя: `SHOW GRANTS FOR 'test'@'localhost';` </br>
7) Атрибуты пользователя: `ALTER USER 'test'@'localhost' ATTRIBUTE '{"Family": "Pretty", "Name": "James"}';`; </br>
8) Из таблицы INFORMATION_SCHEMA.USER_ATTRIBUTES получите данные по пользователю test: `SELECT * FROM INFORMATION_SCHEMA.USER_ATTRIBUTES WHERE USER = 'test';`</br>
![screen](https://github.com/murzinvit/screen/blob/ed5000860c6c533136c4198aef8d6835afc08cf8/Mysql_Attributes_User_test.png)

### Задача 3: </br>
Установите профилирование SET profiling = 1. Изучите вывод профилирования команд SHOW PROFILES;</br>
Информация по [PROFILES](https://highload.today/kak-ispolzovat-show-profile-v-mysql-3f/) </br> 
1) Включение профилирования: `mysql -u root -p`, `SET profiling = 1;` </br>
2) Вывод списка последних запросов с их ID: `SHOW PROFILES;` </br>
3) Показать профиль запроса c id: `SHOW PROFILE FOR QUERY id;` </br>
4) Дополнительная информация по запросу: `SHOW PROFILE ALL FOR QUERY 2;` </br>

Исследуйте, какой engine используется в таблице БД test_db и приведите в ответе: </br>
1) Узнать используемый engine: `SHOW TABLE STATUS WHERE Name = 'orders'\G;` </br>
Используемый engine - InnoDB; </br>
![screen](https://github.com/murzinvit/screen/blob/a951142a58e72600337ea85951ca5c2d8268897c/Mysql_Engine_type.png)

Измените engine и приведите время выполнения и запрос на изменения из профайлера в ответе: </br>
1) PROFILE для InnoDB для запроса: `select price from orders where price > 300;` </br> 
2) `SHOW PROFILES;`   `SHOW PROFILE FOR QUERY id;` </br>
3) Запрос на изменение engine для таблицы: `ALTER TABLE orders ENGINE = MyISAM;` </br>
### Результаты запроса с InnoDB: </br>
![screen](https://github.com/murzinvit/screen/blob/2c4c648b3e7c22027b6b61961e21aa1ff5ce5e38/Mysql_show_profile_InnoDB.png) </br>

### Результаты запроса с MyISAM: </br>
![screen](https://github.com/murzinvit/screen/blob/198d5b5902ef6a970333f2657bedaaa82ef7cf23/Mysql_show_query_MyISAM.png)

### Задача 4: </br>
Изучите файл my.cnf в директории /etc/mysql. Измените его согласно ТЗ (движок InnoDB): </br>
[my.cnf](https://github.com/murzinvit/6.3_MySQL/blob/13b8449f47a5da7217de4d6f5ab3d8d2afa16948/my.cnf) </br>
Скорость IO важнее сохранности данных: `innodb_flush_log_at_trx_commit = 2`</br>
Нужна компрессия таблиц для экономии места на диске: `innodb_file_per_table` </br>
Буффер кеширования 30% от ОЗУ: `innodb_buffer_pool_size = объем_ОЗУ * 0,3` </br>
Размер буффера с незакомиченными транзакциями 1 Мб: `innodb_log_buffer_size = 1M`</br>
Размер файла логов операций 100 Мб: `innodb_log_file_size = 100M` </br></br>

-------------------------------------------------------------------------------------------------------------------------------------
1) Для анализа работы БД, чтобы увидеть медленные запросы, в рвздел [mysqld] добавить(в лог попадёт всё что медленнее 2 секунд): </br>
`log-slow-queries=/var/log/mariadb/slow_queries.log`  </br>
`long_query_time=2` </br>
Также проанализировать работу СУБД можно с помощью скрипта:`mysqltuner` <\br>  
