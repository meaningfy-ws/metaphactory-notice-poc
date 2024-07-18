ENV_FILE := .env
PROJECT_PATH = $(shell pwd)

init_repo:
	PROJECT_PATH=${PROJECT_PATH} docker compose --file ./infra/docker-compose.yml --env-file ${ENV_FILE} --profile data-import up

start:
	PROJECT_PATH=${PROJECT_PATH} docker compose --file ./infra/docker-compose.yml --env-file ${ENV_FILE} --profile service up -d

stop:
	PROJECT_PATH=${PROJECT_PATH} docker compose --file ./infra/docker-compose.yml --env-file ${ENV_FILE} --profile service stop

restart_metaphactory:
	PROJECT_PATH=${PROJECT_PATH} docker compose --file ./infra/docker-compose.yml --env-file ${ENV_FILE} restart metaphactory

ps:
	PROJECT_PATH=${PROJECT_PATH} docker compose --file ./infra/docker-compose.yml --env-file ${ENV_FILE} ps

down:
	PROJECT_PATH=${PROJECT_PATH} docker compose --file ./infra/docker-compose.yml --env-file ${ENV_FILE} --profile service down
