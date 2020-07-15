CURRENT_PATH="$(pwd)"
GIT_REPO_LINK="https://github.com/saurabh-mishrr/htmltopdf.git"
DOMAIN="api.cactuspdfgen.com"
NETWORK_NAME="docbridge" 
NETWORK_SUBNET="192.168.31.0/26"
PHP_IP="172.16.12.8"
NGINX_IP="172.16.12.9"
POSTGRES_IP="172.16.12.19"
NODE_IP="192.168.31.21"
REDIS_IP="172.16.12.10"

PHP_PORT="9000"
NGINX_PORT="5000:80"
POSTGRES_PORT="5432:5432"
NODE_PORT="5001:5001"
REDIS_PORT="6379"

NGINX_DOCKERFILE=${CURRENT_PATH}/setup/nginx/Dockerfile
NGINX_CONF=${CURRENT_PATH}/setup/nginx
NGINX_CONTAINER_NAME=${DOMAIN}.nginx
# API_DIR=${CURRENT_PATH}/node-php
# API_SETUP_FOLDER=${CURRENT_PATH}/setup/node-php

PHP_DOCKERFILE=${CURRENT_PATH}/setup/php/Dockerfile
PHP_CONTAINER_NAME=${DOMAIN}.php
PHP_INI=${CURRENT_PATH}/setup/php/php.ini

NODE_DOCKERFILE=${CURRENT_PATH}/setup/node/Dockerfile
NODE_CONTAINER_NAME=${DOMAIN}.node

REDIS_DOCKERFILE=${CURRENT_PATH}/setup/redis/Dockerfile
REDIS_CONTAINER_NAME=${DOMAIN}.redis

POSTGRES_DOCKERFILE=${CURRENT_PATH}/setup/postgres/Dockerfile
POSTGRES_CONTAINER_NAME=${DOMAIN}.postgres
POSTGRES_ENV_PATH=${CURRENT_PATH}/setup/postgres
SERVICES_LIST=(node)

PROJECT_DIR=$CURRENT_PATH/../${DOMAIN}