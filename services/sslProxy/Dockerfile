# Can be located at https://archive.org/details/nginx_1.9.8.tar if needed
FROM nginx:1.27.0@sha256:9c367186df9a6b18c6735357b8eb7f407347e84aea09beb184961cb83543d46e as base

COPY nginx.conf /etc/nginx/nginx.conf
COPY mcouniverse.pem /etc/nginx/mcouniverse.pem
COPY private_key.pem /etc/nginx/private_key.pem
COPY fullchain1.pem /etc/nginx/fullchain1.pem
COPY privkey1.pem /etc/nginx/privkey1.pem
