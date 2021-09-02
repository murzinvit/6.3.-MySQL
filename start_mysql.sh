#!/bin/bash
docker stop mysrv
docker rm mysrv
docker run -d -p 3306:3306 -e MYSQL_ROOT_PASSWORD=pass -v ~/mysql-data:/var/lib/mysql --name mysrv mysql:latest sleep 600000000