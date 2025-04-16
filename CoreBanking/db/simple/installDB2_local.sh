#!/bin/bash

docker run -itd --name coredb --privileged=true -p 50000:50000 -e LICENSE=accept -e DB2INST1_PASSWORD=passw0rd -e DBNAME=coredb ibmcom/db2
sleep 180s
docker exec -it -u db2inst1 coredb bash -c '. ~/.profile; db2 connect to coredb; db2 "create table account(id varchar(100) NOT NULL, timestamp varchar(100), amount varchar(300))";db2 "insert into account (id,amount) values(1234567890,1000)"'
