teardown:
	docker-compose down --remove-orphans --volumes --timeout=5

start:
	docker-compose pull
	docker-compose build
	docker-compose run kafka-cli
	docker-compose up --detach kafka-rest-proxy

produce-messages:
	docker-compose run -e CREATE_TOPICS="" kafka-cli bash /app/produce_messages_via_cli.sh
