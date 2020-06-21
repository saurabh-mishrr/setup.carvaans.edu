CURRENT_PATH="$(pwd)"
NETWORK_NAME="carvaans_network" 

NGINX_DOCKERFILE=${CURRENT_PATH}/setup/api/Dockerfile
NGINX_CONF=${CURRENT_PATH}/setup/api
NGINX_CONTAINER_NAME=edu.carvaans.api
API_DIR=${CURRENT_PATH}/api
API_SETUP_FOLDER=${CURRENT_PATH}/setup/api

PHP_DOCKERFILE=${CURRENT_PATH}/setup/api/Dockerfile-PHP.dockerfile
PHP_CONTAINER_NAME=edu.carvaans.php

NODE_DOCKERFILE=${CURRENT_PATH}/setup/app/Dockerfile
NODE_CONTAINER_NAME=edu.carvaans.app

REDIS_DOCKERFILE=${CURRENT_PATH}/setup/cache/Dockerfile
REDIS_CONTAINER_NAME=edu.carvaans.cache

POSTGRES_DOCKERFILE=${CURRENT_PATH}/setup/db/Dockerfile
POSTGRES_CONTAINER_NAME=edu.carvaans.db
POSTGRES_ENV_PATH=${CURRENT_PATH}/setup/db

SERVICES_LIST=(php nginx node redis postgres)

PROJECT_DIR=$CURRENT_PATH/../carvaans.edu