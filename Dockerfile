FROM nginx:mainline-alpine

ADD site/_site /usr/share/nginx/html

ADD nginx/conf.d/expires.conf /etc/nginx/conf.d/expires.conf
