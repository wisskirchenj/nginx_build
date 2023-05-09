FROM alpine:latest as builder

RUN apk update && apk add --no-cache build-base make wget && \
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

FROM alpine:latest
COPY --from=builder /usr/local/nginx /usr/local/nginx
EXPOSE 80
CMD ["/usr/local/nginx/nginx", "-g", "daemon off;"]
