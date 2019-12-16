FROM node:alpine3.10 AS build
RUN mkdir -p /app/code
WORKDIR /app/code
COPY ./package.json .
ADD ./src ./src
ADD ./public ./public
RUN npm install
RUN npm run build

# Layer for building only hosting content
FROM nginx
COPY --from=build /app/code/build /usr/share/nginx/html
EXPOSE 80
