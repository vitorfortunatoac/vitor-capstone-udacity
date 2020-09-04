FROM nginx:alpine

RUN rm /usr/share/nginx/html/index.html

COPY /app/index.html /usr/share/nginx/html/