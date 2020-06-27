setup_node() {
    build_node_command='build 
        --no-cache
        -t '${NODE_CONTAINER_NAME}'
        -f '${NODE_DOCKERFILE}' .'
    
    docker $build_node_command

    create_node_command='create 
            -it
            -p '${NODE_PORT}'
            -v '${PROJECT_DIR}'/app:/app:rw
            -w /app
            --hostname '${NODE_CONTAINER_NAME}'
            --name '${NODE_CONTAINER_NAME}'
            --network '${NETWORK_NAME}'
            --ip '${NODE_IP}'
            '${NODE_CONTAINER_NAME}

    docker $create_node_command

    
}

start_node() {
    docker start ${NODE_CONTAINER_NAME}
}

stop_node() {
    docker stop ${NODE_CONTAINER_NAME}
}

remove_node() {
    docker rm ${NODE_CONTAINER_NAME}
    docker rmi ${NODE_CONTAINER_NAME}
}