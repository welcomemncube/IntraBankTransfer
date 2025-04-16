# syntax=docker/dockerfile:1

FROM node:20.1.0-alpine3.17

ENV NODE_ENV=production

WORKDIR /app

COPY code/index.html .
COPY code/server.js .
RUN npm install --save @instana/collector
CMD [ "node", "server.js" ]

# Allow traffic on port 8000
EXPOSE 8000
