FROM nginx:alpine

RUN rm /usr/share/nginx/html/index.html

COPY /app/. /usr/share/nginx/html