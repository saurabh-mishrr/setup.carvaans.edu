FROM node:10
RUN mkdir /usr/src/cache
WORKDIR /usr/src/cache
COPY package*.json ./
RUN npm install
WORKDIR /app
VOLUME [ "/app", "/app/node_modules"]
EXPOSE 3000
ENTRYPOINT [ "/bin/bash", "entrypoint.sh" ]
# CMD [ "npm", "start" ]