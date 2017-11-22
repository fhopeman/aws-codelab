#!/bin/bash -xe
yum install -y docker
/etc/init.d/docker start
docker run -dp 8080:8080 felixb/yocto-httpd
