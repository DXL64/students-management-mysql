#!/bin/bash

docker compose down -v
rm -rf ./data
#docker-compose build
docker compose up -d

until docker exec -it master sh -c 'export MYSQL_PWD=root; mysql -uroot -e";"'
do
    echo "Waiting for mysql_master database connection..."
    sleep 4
done

create_slave1='CREATE USER "slave1"@"%" IDENTIFIED BY "slave";GRANT REPLICATION SLAVE ON *.* TO "slave1"@"%"; FLUSH PRIVILEGES;'
create_slave2='CREATE USER "slave2"@"%" IDENTIFIED BY "slave";GRANT REPLICATION SLAVE ON *.* TO "slave2"@"%"; FLUSH PRIVILEGES;'
docker exec master sh -c "export MYSQL_PWD=root; mysql -u root -e '$create_slave1'"

docker exec master sh -c "export MYSQL_PWD=root; mysql -u root -e '$create_slave2'"

MS_STATUS=`docker exec master sh -c 'export MYSQL_PWD=root; mysql -u root -e "SHOW MASTER STATUS"'`
CURRENT_LOG=`echo $MS_STATUS | awk '{print $6}'`
CURRENT_POS=`echo $MS_STATUS | awk '{print $7}'`

echo $CURRENT_LOG
echo $CURRENT_POS

start_slave1_stmt="CHANGE MASTER TO MASTER_HOST='master',MASTER_USER='slave1',MASTER_PASSWORD='slave',MASTER_LOG_FILE='$CURRENT_LOG',MASTER_LOG_POS=$CURRENT_POS; START SLAVE;"
start_slave1_cmd='export MYSQL_PWD=slave; mysql -u root -e "'
start_slave1_cmd+="$start_slave1_stmt"
start_slave1_cmd+='"'
docker exec slave1 sh -c "$start_slave1_cmd"

docker exec slave1 sh -c "export MYSQL_PWD=slave; mysql -u root -e 'SHOW SLAVE STATUS \G'"

start_slave2_stmt="CHANGE MASTER TO MASTER_HOST='master',MASTER_USER='slave2',MASTER_PASSWORD='slave',MASTER_LOG_FILE='$CURRENT_LOG',MASTER_LOG_POS=$CURRENT_POS; START SLAVE;"
start_slave2_cmd='export MYSQL_PWD=slave; mysql -u root -e "'
start_slave2_cmd+="$start_slave2_stmt"
start_slave2_cmd+='"'
docker exec slave2 sh -c "$start_slave2_cmd"

docker exec slave2 sh -c "export MYSQL_PWD=slave; mysql -u root -e 'SHOW SLAVE STATUS \G'"
import_data='SOURCE db-data/students-management.sql;'
docker exec master sh -c "export MYSQL_PWD=root; mysql -u root -e '$import_data'"

echo $import_data
