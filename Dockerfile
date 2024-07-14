FROM node:lts-alpine as builds-stage

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

FROM nginx:stable-alpine as production-stage

COPY --from=builds-stage /app/dist  /usr/share/nginx/html

EXPOSE 80


CMD ["nginx", "-g", "daemon off;"]
