#!/bin/bash
docker stop mysrv
docker rm mysrv
docker run -d -p 3306:3306 -e MYSQL_ROOT_PASSWORD=password -v /DATABASE/mysql-data:/var/lib/mysql --name mysrv mysql:8
