all:
	@echo "make certs - generate certs"
	@echo "make test - run tests"
	@echo "make build - build the project"
	@echo "make start - start the server"
	@echo "make up - start the ssl proxy in docker"
	@echo "make down - stop the server in docker"
	@echo "make enable-net - enable network binding for the server"
	@echo "make clean - clean the project"

certs:
	@openssl req -x509 -extensions v3_req -config data/mcouniverse.cnf -newkey rsa:1024 -nodes -keyout ./data/private_key.pem -out ./data/mcouniverse.pem -days 365
	@openssl rsa -in ./data/private_key.pem -outform DER -pubout | xxd -ps -c 300 | tr -d '\n' > ./data/pub.key
	@cp ./data/mcouniverse.pem  ./data/private_key.pem ./services/sslProxy/
	@echo "certs regenerated. remember to update pub.key for all clients"

test:
	@cargo test

build:
	@cargo build

start:
	@EXTERNAL_HOST=mcouniverse.com PRIVATE_KEY_FILE=data/private_key.pem CERTIFICATE_FILE=data/mcouniverse.crt PUBLIC_KEY_FILE=data/pub.key LOG_LEVEL=trace cargo run

up:
	docker-compose up -d --build

down:
	docker-compose down

enable-net:
	@sudo setcap cap_net_bind_service=+ep ./target/debug/rusty_server

clean:
	@cargo clean

.PHONY: all certs test build start up down enable-net clean