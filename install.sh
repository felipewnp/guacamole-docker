#!/bin/bash
set -euxo pipefail
source .env
#

guacamole_initdb='guacamole-initdb.sql'

docker run --rm guacamole/guacamole /opt/guacamole/bin/initdb.sh --mysql > $guacamole_initdb

sed -i '1s/^/CREATE DATABASE IF NOT EXISTS guac_db;\n/' $guacamole_initdb
sed -i '2s/^/USE guac_db;\n/' $guacamole_initdb

docker compose up -d
