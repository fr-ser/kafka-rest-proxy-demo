FROM alpine:3.13

RUN apk add --no-cache nginx-mod-http-lua-upstream gettext

COPY ./nginx.conf /etc/nginx/nginx.conf.template
COPY ./nginx-get.conf /etc/nginx/get-proxy.conf
COPY ./nginx-post.conf /etc/nginx/post-proxy.conf
COPY ./nginx.htpasswd /etc/nginx/conf.d/nginx.htpasswd
COPY ./entrypoint.sh /app/entrypoint.sh

RUN mkdir -p /run/nginx
RUN touch /run/nginx/nginx.pid

ENTRYPOINT [ "/app/entrypoint.sh" ]
