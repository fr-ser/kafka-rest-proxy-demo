#!/bin/sh

envsubst '${TDA_READINGS_TOPIC} ${TDA_ERRORS_TOPIC}' < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf

nginx -g "daemon off;"
