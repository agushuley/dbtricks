SERVICE=dbbackups
USER_ID=$(shell id -u)

up:
	USER_ID=$(USER_ID) USER=$(USER) docker-compose -p $(SERVICE) build
	USER_ID=$(USER_ID) USER=$(USER) docker-compose -p $(SERVICE) create

backup:
	USER_ID=$(USER_ID) USER=$(USER) docker-compose -p $(SERVICE) start backup

shell:
	USER_ID=$(USER_ID) USER=$(USER) docker-compose -p $(SERVICE) run --rm --entrypoint bash backup 

