setup_postgres() {
    build_db_command='build 
        --no-cache
        -t '${POSTGRES_CONTAINER_NAME}'
        -f '${POSTGRES_DOCKERFILE}' .'

    docker $build_db_command

    create_db_command='create 
        -t
        --env-file '${POSTGRES_ENV_PATH}'/.env
        -v '${PROJECT_DIR}'/data:/var/lib/postgresql/data
        --hostname '${POSTGRES_CONTAINER_NAME}'
        --name '${POSTGRES_CONTAINER_NAME}'
        --network '${NETWORK_NAME}'
        --ip 173.20.1.6
        '${POSTGRES_CONTAINER_NAME}' postgres'
    
    docker $create_db_command
}


start_postgres() {
    docker start ${POSTGRES_CONTAINER_NAME}
}

stop_postgres() {
    docker stop ${POSTGRES_CONTAINER_NAME}
}

remove_postgres() {
    docker rm ${POSTGRES_CONTAINER_NAME}
    docker rmi ${POSTGRES_CONTAINER_NAME}
}