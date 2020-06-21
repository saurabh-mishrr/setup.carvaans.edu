CURRENT_PATH="$(pwd)"
API_DOCKERFILE=${CURRENT_PATH}/setup/api/Dockerfile
PHP_DOCKERFILE=${CURRENT_PATH}/setup/api/Dockerfile-PHP.dockerfile
API_CONTAINER_NAME=edu.carvaans.api
PHP_CONTAINER_NAME=edu.carvaans.php
CARVAANS_NGINX_CONF=${CURRENT_PATH}/setup/api
API_DIR=${CURRENT_PATH}/api
API_SETUP_FOLDER=${CURRENT_PATH}/setup/api
CARVAANS_EDU_DIR=$CURRENT_PATH/../carvaans.edu
NETWORK_NAME="carvaans_network" 


create_all_services() {
    # mkdir -p $CARVAANS_EDU_DIR
    # git clone git@github.com:saurabh-mishrr/carvaans.edu.git $CARVAANS_EDU_DIR
    create_network_command='network create 
            --subnet "173.20.1.0/10" '${NETWORK_NAME}

    docker $create_network_command
            

    build_php_command='build 
                --force-rm
                --no-cache
                --build-arg carvaans_edu_dir='${CARVAANS_EDU_DIR}' 
                -t '${PHP_CONTAINER_NAME}' 
                -f '${PHP_DOCKERFILE}' .'

    build_api_command='build 
                --force-rm
                --no-cache
                --build-arg carvaans_edu_dir='${CARVAANS_EDU_DIR}'
                -t '${API_CONTAINER_NAME}'
                -f '${API_DOCKERFILE}' .'


    docker $build_api_command
    docker $build_php_command

    run_php_command='create 
            -it 
            -p 9000 
            -v '${CARVAANS_EDU_DIR}'/api:/app:rw 
            -v '${HOME}'/.ssh:/root/.ssh:ro
            -w /app 
            --hostname '${PHP_CONTAINER_NAME}' 
            --name '${PHP_CONTAINER_NAME}' 
            --network '${NETWORK_NAME}'
            --ip 173.20.1.3
            '${PHP_CONTAINER_NAME}

    run_api_command='create 
            -it
            -p 5000:80 
            -v '${CARVAANS_EDU_DIR}'/api:/app:rw 
            -v '${CARVAANS_NGINX_CONF}'/default.conf:/etc/nginx/conf.d/default.conf:ro 
            -v '${CARVAANS_EDU_DIR}'/api/public:/usr/share/nginx/html:rw 
            -w /app 
            --hostname '${API_CONTAINER_NAME}' 
            --name '${API_CONTAINER_NAME}' 
            --network '${NETWORK_NAME}'
            --ip 173.20.1.2
            '${API_CONTAINER_NAME}

    docker $run_php_command
    docker $run_api_command

    start_all_services

    docker exec -it ${PHP_CONTAINER_NAME} composer install
}

start_all_services() {
    docker start ${PHP_CONTAINER_NAME}
    docker start ${API_CONTAINER_NAME}
}

stop_all_services() {
    docker stop ${API_CONTAINER_NAME}
    docker stop ${PHP_CONTAINER_NAME}
}

remove_all_services() {
    stop_all_services
    docker rm ${API_CONTAINER_NAME}
    docker rm ${PHP_CONTAINER_NAME}
    docker rmi ${API_CONTAINER_NAME}
    docker rmi ${PHP_CONTAINER_NAME}
    docker network rm ${NETWORK_NAME}
}