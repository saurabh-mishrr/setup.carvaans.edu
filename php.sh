setup_php() {
    build_php_command='build 
        --no-cache
        --build-arg PROJECT_DIR='${PROJECT_DIR}' 
        -t '${PHP_CONTAINER_NAME}' 
        -f '${PHP_DOCKERFILE}' .'
    
    docker $build_php_command

    create_php_command='create 
            -it 
            -v '${PROJECT_DIR}'/api:/app:rw 
            -v '${HOME}'/.ssh:/root/.ssh:ro
            -w /app 
            --hostname '${PHP_CONTAINER_NAME}' 
            --name '${PHP_CONTAINER_NAME}' 
            --network '${NETWORK_NAME}'
            --ip 173.20.1.3
            '${PHP_CONTAINER_NAME}
    
    docker $create_php_command
    
}

start_php() {
    docker start ${PHP_CONTAINER_NAME}
}

stop_php() {
    docker stop ${PHP_CONTAINER_NAME}
}

remove_php() {
    docker rm ${PHP_CONTAINER_NAME}
    docker rmi ${PHP_CONTAINER_NAME}
}