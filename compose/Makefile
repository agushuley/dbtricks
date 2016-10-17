SERVICE=dbbackups
USER_ID=$(shell id -u)

up:
	docker-compose -p $(SERVICE) build
	USER_ID=$(USER_ID) docker-compose -p $(SERVICE) create

backup:
	docker-compose -p $(SERVICE) start backup
