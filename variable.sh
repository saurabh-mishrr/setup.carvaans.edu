CURRENT_PATH="$(pwd)"
NETWORK_NAME="carvaans_network" 

API_DOCKERFILE=${CURRENT_PATH}/setup/api/Dockerfile
CARVAANS_NGINX_CONF=${CURRENT_PATH}/setup/api
API_CONTAINER_NAME=edu.carvaans.api
API_DIR=${CURRENT_PATH}/api
API_SETUP_FOLDER=${CURRENT_PATH}/setup/api

PHP_DOCKERFILE=${CURRENT_PATH}/setup/api/Dockerfile-PHP.dockerfile
PHP_CONTAINER_NAME=edu.carvaans.php

NODE_DOCKERFILE=${CURRENT_PATH}/setup/app/Dockerfile
NODE_CONTAINER_NAME=edu.carvaans.app

REDIS_DOCKERFILE=${CURRENT_PATH}/setup/cache/Dockerfile
REDIS_CONTAINER_NAME=edu.carvaans.cache

DB_DOCKERFILE=${CURRENT_PATH}/setup/db/Dockerfile
DB_CONTAINER_NAME=edu.carvaans.db
DB_ENV_PATH=${CURRENT_PATH}/setup/db

CARVAANS_EDU_DIR=$CURRENT_PATH/../carvaans.edu