#!/bin/bash

whoami
sudo -i -u db2inst1 bash << EOF
whoami
. ~/.profile
db2start
db2 connect to coredb
db2 "create table account(id varchar(100) NOT NULL, timestamp varchar(100), amount varchar(300))"
db2 "insert into account (id) values(1)"
EOF
echo "Completed"
