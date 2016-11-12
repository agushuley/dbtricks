SERVICE=dbbackups
USER_ID=$(shell id -u)
USER=$(shell id -un)
export USER USER_ID

up:
	docker-compose -p $(SERVICE) build
	docker-compose -p $(SERVICE) create

backup:
	docker-compose -p $(SERVICE) run --rm backup

pull:
	docker pull andriyg/dbtricks

shell:
	docker-compose -p $(SERVICE) run --rm --entrypoint bash backup

