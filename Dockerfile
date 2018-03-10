FROM nginx:mainline-alpine

ADD site/_site /usr/share/nginx/html
