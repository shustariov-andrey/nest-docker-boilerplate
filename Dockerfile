# stage 1: build
FROM node:14.16.1-alpine3.13 AS build

USER node
RUN mkdir -p /home/node/app
WORKDIR /home/node/app

COPY --chown=node:node . .
RUN npm ci && npm run build

# stage 2: result image
FROM node:14.16.1-alpine3.13

USER node

RUN mkdir -p /home/node/app
WORKDIR /home/node/app
COPY --chown=node:node --from=build /home/node/app/package.json /home/node/app/package-lock.json ./
COPY --chown=node:node --from=build /home/node/app/dist ./dist

RUN npm ci --production

EXPOSE 3000

CMD ["node", "dist/main.js"]
