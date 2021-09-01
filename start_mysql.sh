#!/bin/bash
docker stop docker_mysql
docker rm docker_mysql
docker run -d --name docker_mysql -p 3306 murzinvit/mysqlserver:latest sleep 60000000000