#!/bin/bash

docker run -itd --name auditdb --privileged=true -p 50000:50000 -e LICENSE=accept -e DB2INST1_PASSWORD=passw0rd -e DBNAME=auditdb ibmcom/db2
sleep 180s
docker exec -it -u db2inst1 auditdb bash -c '. ~/.profile; db2 connect to auditdb; db2 "create table auditlog(id varchar(100) NOT NULL, timestamp varchar(100), details varchar(300))";db2 "insert into auditlog (id) values(1)"'
