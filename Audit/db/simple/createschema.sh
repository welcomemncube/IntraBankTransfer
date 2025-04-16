#!/bin/bash

whoami
sudo -i -u db2inst1 bash << EOF
whoami 
. ~/.profile
db2start
db2 connect to auditdb
db2 "create table auditlog(id varchar(100) NOT NULL, timestamp varchar(100), details varchar(300))"
db2 "insert into auditlog (id) values(1)"
EOF
echo "Completed"
