### 6.3.-MySQL </br>
----------------------------------------------------------------------------------
Используя docker поднимите инстанс MySQL (версию 8). Данные БД сохраните в volume: </br>
1) Загрузка контейнера: `docker pull mysql:latest` </br>
2) Запуск контейнера с volume: `docker run -d -e MYSQL_ROOT_PASSWORD=pass -v ~/mysql-data:/var/lib/mysql --name mysrv mysql` </br>
Изучите бэкап БД и восстановитесь из него: </br>
