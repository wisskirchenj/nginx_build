FROM debian:latest

RUN apt-get update && apt-get install -y build-essential wget && \
wget https://nginx.org/download/nginx-1.15.9.tar.gz && \
mkdir /nginx && \
tar zxf nginx-1.15.9.tar.gz && mv nginx-1.15.9/* /nginx && \
cd /nginx && \
./configure \
--sbin-path=/usr/local/nginx/nginx \
--conf-path=/usr/local/nginx/nginx.conf \
--pid-path=/usr/local/nginx/nginx.pid \
--without-http_rewrite_module \
--without-http_gzip_module && \
make && make install
