# stage 1: build
FROM node:14.16.1-alpine3.13 AS build

#USER node

WORKDIR /app

COPY --chown=node:node . .
RUN npm ci && npm run build

# stage 2: result image
FROM node:14.16.1-alpine3.13

USER node

WORKDIR /app
COPY --chown=node:node --from=build /app/package.json /app/package-lock.json ./
COPY --chown=node:node --from=build /app/dist ./dist

RUN npm ci --production

EXPOSE 3000

CMD ["node", "dist/main.js"]
