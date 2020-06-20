#!/bin/bash 

source_path=$(pwd)
export API_DOCKERFILE=${source_path}/setup/api/Dockerfile
export API_CONTAINER_NAME=edu.carvaans.api
export PHP_CONTAINER_NAME=edu.carvaans.php
export CARVAANS_NGINX_CONF=${source_path}/setup/api
export API_DIR=${source_path}/api
export API_SETUP_FOLDER=${source_path}/setup/api
#setting up API
docker-compose up -d
