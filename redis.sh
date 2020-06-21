setup_redis() {
    build_cache_command='build 
        -t '${REDIS_CONTAINER_NAME}'
        -f '${REDIS_DOCKERFILE}' .'

    docker $build_cache_command

    create_cache_command='create
        -t
        -v '${PROJECT_DIR}'/cache_data:/data
        -w /data
        --hostname '${REDIS_CONTAINER_NAME}'
        --name '${REDIS_CONTAINER_NAME}'
        --network '${NETWORK_NAME}'
        --ip 173.20.1.5
        '${REDIS_CONTAINER_NAME}' redis-server --appendonly yes'
    
    docker $create_cache_command
}


start_redis() {
    docker start ${REDIS_CONTAINER_NAME}
}

stop_redis() {
    docker stop ${REDIS_CONTAINER_NAME}
}

remove_redis() {
    docker rm ${REDIS_CONTAINER_NAME}
    docker rmi ${REDIS_CONTAINER_NAME}
}