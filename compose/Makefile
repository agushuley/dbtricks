SERVICE=dbbackups

up:
	docker-compose -p $(SERVICE) build
	docker-compose -p $(SERVICE) create

backup:
	docker-compose -p $(SERVICE) start backup
