setup_nginx() {
    build_api_command='build 
        --no-cache
        -t '${NGINX_CONTAINER_NAME}'
        -f '${NGINX_DOCKERFILE}' .'


    docker $build_api_command

    create_api_command='create 
            -it
            -p '${NGINX_PORT}' 
            -v '${PROJECT_DIR}':/app:rw 
            -v '${NGINX_CONF}'/default.conf:/etc/nginx/conf.d/default.conf:ro 
            -w /app 
            --hostname '${NGINX_CONTAINER_NAME}' 
            --name '${NGINX_CONTAINER_NAME}' 
            --network '${NETWORK_NAME}'
            --ip '${NGINX_IP}'
            '${NGINX_CONTAINER_NAME}

    
    docker $create_api_command
}

start_nginx() {
    docker start ${NGINX_CONTAINER_NAME}
}

stop_nginx() {
    docker stop ${NGINX_CONTAINER_NAME}
}

remove_nginx() {
    docker rm ${NGINX_CONTAINER_NAME}
    docker rmi ${NGINX_CONTAINER_NAME}
}