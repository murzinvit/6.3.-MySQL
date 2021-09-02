### 6.3.-MySQL </br>
----------------------------------------------------------------------------------
Используя docker поднимите инстанс MySQL (версию 8). Данные БД сохраните в volume: </br>
1) Загрузка контейнера: `docker pull mysql:latest` </br>
2) Запуск контейнера: `docker run -d -e MYSQL_ROOT_PASSWORD=pass -v ~/mysql-data:/var/lib/mysql --name mysrv mysql` </br>
Изучите [бэкап БД](https://github.com/murzinvit/6.3_MySQL/blob/da7841c0c982eb7c4cddc2f5212a2801cd888445/test_dump.sql) и восстановитесь из него: </br>
