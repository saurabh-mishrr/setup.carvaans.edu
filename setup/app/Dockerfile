FROM node:10
WORKDIR /app
# RUN groupadd --gid 1000 node \
#   && useradd --uid 1000 --gid node --shell /bin/bash --create-home node
VOLUME [ "/app" ]
EXPOSE 3000
CMD [ "npm", "start" ]