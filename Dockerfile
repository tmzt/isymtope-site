FROM nginx:mainline-alpine

ADD site/_site /usr/share/nginx/html

# Override default config from nginx image
ADD nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf
