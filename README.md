### 6.3.-MySQL </br>
----------------------------------------------------------------------------------
Используя docker поднимите инстанс MySQL (версию 8). Данные БД сохраните в volume: </br>
1) Загрузка контейнера: `docker pull mysql:latest` </br>
2) Запуск контейнера: `docker run -d -e MYSQL_ROOT_PASSWORD=pass -v ~/mysql-data:/var/lib/mysql --name mysrv mysql` </br>
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
![screen](https://github.com/murzinvit/screen/blob/abc2a3f6db5769308e626e899ca6fe028c36a206/mysql_status_result.jpg)</br>
