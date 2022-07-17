FROM  node:16-alpine as builder
USER node
RUN mkdir -p /home/node/app
WORKDIR '/home/node/app'

COPY --chown=node:node ./package.json ./
RUN npm install
COPY --chown=node:node ./ ./
COPY . .
RUN npm run build

#Run pahse
#EXPOSE 80 #its do nth at lcoal env

FROM nginx
EXPOSE 80 
COPY --from=builder  /home/node/app/build usr/share/nginx/html
