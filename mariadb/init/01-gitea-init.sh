#!/bin/bash
set -e

mysql --protocol=socket -uroot -p$MYSQL_ROOT_PASSWORD <<EOSQL
SET old_passwords=0;
CREATE USER '$GITEA_DB_USER'@'%' IDENTIFIED BY '$GITEA_DB_PASSWORD';
CREATE DATABASE IF NOT EXISTS \`$GITEA_DB_NAME\` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
GRANT ALL ON \`$GITEA_DB_NAME\`.* TO '$GITEA_DB_USER'@'%';
FLUSH PRIVILEGES;
EOSQL