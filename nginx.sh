setup_nginx() {
    build_api_command='build 
        --no-cache
        -t '${NGINX_CONTAINER_NAME}'
        -f '${NGINX_DOCKERFILE}' .'


    docker $build_api_command

    create_api_command='create 
            -it
            -p 5000:80 
            -v '${PROJECT_DIR}'/api:/app:rw 
            -v '${NGINX_CONF}'/default.conf:/etc/nginx/conf.d/default.conf:ro 
            -v '${PROJECT_DIR}'/api/public:/usr/share/nginx/html:rw 
            -w /app 
            --hostname '${NGINX_CONTAINER_NAME}' 
            --name '${NGINX_CONTAINER_NAME}' 
            --network '${NETWORK_NAME}'
            --ip 173.20.1.2
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