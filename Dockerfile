#In AWS the as nuilder must be eliminate
FROM node:16-alpine as builder

USER node

RUN mkdir -p /home/node/app
WORKDIR /home/node/app

COPY --chown=node:node ./package.json ./
RUN npm install
COPY --chown=node:node . .
 
RUN npm run build


#the builder must be replaced with 0 in AWS
FROM nginx
EXPOSE 80
COPY --from=builder /home/node/app/build /usr/share/nginx/html