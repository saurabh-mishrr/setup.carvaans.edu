clone_repo() {
    # mkdir -p $CARVAANS_EDU_DIR
    # git clone git@github.com:saurabh-mishrr/carvaans.edu.git $CARVAANS_EDU_DIR
    echo "Cloning repo"
}

create_network() {
    create_network_command='network create 
            --subnet "173.20.1.0/10" '${NETWORK_NAME}
    
    docker $create_network_command
}


setup_php() {
    build_php_command='build 
                --build-arg carvaans_edu_dir='${CARVAANS_EDU_DIR}' 
                -t '${PHP_CONTAINER_NAME}' 
                -f '${PHP_DOCKERFILE}' .'
    
    docker $build_php_command

    create_php_command='create 
            -it 
            -v '${CARVAANS_EDU_DIR}'/api:/app:rw 
            -v '${HOME}'/.ssh:/root/.ssh:ro
            -w /app 
            --hostname '${PHP_CONTAINER_NAME}' 
            --name '${PHP_CONTAINER_NAME}' 
            --network '${NETWORK_NAME}'
            --ip 173.20.1.3
            '${PHP_CONTAINER_NAME}
    
    docker $create_php_command

    
}

setup_nginx() {
    build_api_command='build 
                -t '${API_CONTAINER_NAME}'
                -f '${API_DOCKERFILE}' .'


    docker $build_api_command

    create_api_command='create 
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

    
    docker $create_api_command
}

setup_nodejs() {
    build_node_command='build 
        -t '${NODE_CONTAINER_NAME}'
        -f '${NODE_DOCKERFILE}' .'
    
    docker $build_node_command

    create_node_command='create 
            -it
            -p 5001:3000
            -v '${CARVAANS_EDU_DIR}'/app:/app:rw
            -w /app
            --hostname '${NODE_CONTAINER_NAME}'
            --name '${NODE_CONTAINER_NAME}'
            --network '${NETWORK_NAME}'
            --ip 173.20.1.4
            '${NODE_CONTAINER_NAME}

    docker $create_node_command

    
}


setup_redis() {
    build_cache_command='build 
        -t '${REDIS_CONTAINER_NAME}'
        -f '${REDIS_DOCKERFILE}' .'

    docker $build_cache_command

    create_cache_command='create
        -t
        -v '${CARVAANS_EDU_DIR}'/cache_data:/data
        -w /data
        --hostname '${REDIS_CONTAINER_NAME}'
        --name '${REDIS_CONTAINER_NAME}'
        --network '${NETWORK_NAME}'
        --ip 173.20.1.5
        '${REDIS_CONTAINER_NAME}' redis-server --appendonly yes'
    
    docker $create_cache_command
}

setup_db() {
    build_cache_command='build 
        -t '${DB_CONTAINER_NAME}'
        -f '${DB_DOCKERFILE}' .'

    docker $build_cache_command

    create_cache_command='create 
        -t
        --env-file '${DB_ENV_PATH}'/.env
        -v '${CARVAANS_EDU_DIR}'/data:/var/lib/postgresql/data
        --hostname '${DB_CONTAINER_NAME}'
        --name '${DB_CONTAINER_NAME}'
        --network '${NETWORK_NAME}'
        --ip 173.20.1.6
        '${DB_CONTAINER_NAME}' postgres'
    
    docker $create_cache_command
}

execute_services() {
    docker exec -it ${NODE_CONTAINER_NAME} npm install
    docker exec -it ${PHP_CONTAINER_NAME} composer install
}

create_all_services() {
    clone_repo
    create_network
    setup_php
    setup_nginx
    setup_nodejs
    setup_redis
    setup_db
    start_all_services
    execute_services
}

start_all_services() {
    docker start ${PHP_CONTAINER_NAME}
    docker start ${API_CONTAINER_NAME}
    docker start ${NODE_CONTAINER_NAME}
    docker start ${REDIS_CONTAINER_NAME}
    docker start ${DB_CONTAINER_NAME}
}

stop_all_services() {
    docker stop ${API_CONTAINER_NAME}
    docker stop ${PHP_CONTAINER_NAME}
    docker stop ${NODE_CONTAINER_NAME}
    docker stop ${REDIS_CONTAINER_NAME}
    docker stop ${DB_CONTAINER_NAME}
}

remove_all_services() {
    stop_all_services
    docker rm ${API_CONTAINER_NAME}
    docker rm ${PHP_CONTAINER_NAME}
    docker rm ${NODE_CONTAINER_NAME}
    docker rm ${REDIS_CONTAINER_NAME}
    docker rm ${DB_CONTAINER_NAME}
    docker rmi ${API_CONTAINER_NAME}
    docker rmi ${PHP_CONTAINER_NAME}
    docker rmi ${NODE_CONTAINER_NAME}
    docker rmi ${REDIS_CONTAINER_NAME}
    docker rmi ${DB_CONTAINER_NAME}
    docker network rm ${NETWORK_NAME}
}