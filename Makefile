ENV_FILE := .env
PROJECT_PATH = $(shell pwd)

# initializes the repository, imports data, vocabularies and creates indexes
init:
	PROJECT_PATH=${PROJECT_PATH} docker compose --file ./infra/docker-compose.yml --env-file ${ENV_FILE} up init

up:
	PROJECT_PATH=${PROJECT_PATH} docker compose --file ./infra/docker-compose.yml --env-file ${ENV_FILE} --profile service up -d

down:
	PROJECT_PATH=${PROJECT_PATH} docker compose --file ./infra/docker-compose.yml --env-file ${ENV_FILE} --profile service down

stop:
	PROJECT_PATH=${PROJECT_PATH} docker compose --file ./infra/docker-compose.yml --env-file ${ENV_FILE} --profile service stop

restart_metaphactory:
	PROJECT_PATH=${PROJECT_PATH} docker compose --file ./infra/docker-compose.yml --env-file ${ENV_FILE} restart metaphactory

ps:
	PROJECT_PATH=${PROJECT_PATH} docker compose --file ./infra/docker-compose.yml --env-file ${ENV_FILE} ps
