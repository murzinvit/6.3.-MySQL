FROM centos:latest
RUN yum -y update && yum -y install wget sudo initscripts
RUN cd /opt && wget http://repo.mysql.com/mysql80-community-release-el8-1.noarch.rpm
RUN cd /opt && yum -y install *.rpm && dnf -y install mysql-server
EXPOSE 3306
