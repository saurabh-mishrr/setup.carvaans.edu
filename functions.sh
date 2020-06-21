clone_repo() {
    mkdir -p $PROJECT_DIR
    git clone git@github.com:saurabh-mishrr/carvaans.edu.git $PROJECT_DIR
}

create_network() {
    create_network_command='network create 
            --subnet "173.20.1.0/10" '${NETWORK_NAME}
    
    docker $create_network_command
}

execute_services() {
    docker exec -it ${NODE_CONTAINER_NAME} npm install
    docker exec -it ${PHP_CONTAINER_NAME} composer install
}

create_all_services() {
    # clone_repo
    create_network
    for i in ${SERVICES_LIST[@]}
    do 
        setup_${i}
    done
    start_all_services
    # execute_services
}

start_all_services() {
    for i in ${SERVICES_LIST[@]}
    do 
        start_${i}
    done
}

stop_all_services() {
    for i in ${SERVICES_LIST[@]}
    do 
        stop_${i}
    done
}

remove_all_services() {
    stop_all_services

    for i in ${SERVICES_LIST[@]}
    do 
        remove_${i}
    done
    
    docker network rm ${NETWORK_NAME}
}