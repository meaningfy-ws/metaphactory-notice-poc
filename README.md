This repository contains a proof of concept demonstrating capabilities of [Metaphactory](https://metaphacts.com/product) platform. 
The created application covers public procurement notices from the EU and allows to display, browse and navigate through notices data.

- [Live demo](#live-demo)
- [Project structure](#project-structure)
- [Data](#data)
  - [notices](#notices)
  - [EPO ontology](#epo-ontology)
  - [Authority tables](#authority-tables)
- [Running the application](#running-the-application)
  - [Prerequisites](#prerequisites)
  - [Initialize the environment](#initialize-the-environment)
  - [Launch the application](#launch-the-application)
- [Development](#development)
- [Configuration](#configuration)
- [Infrastructure](#infrastructure)

# Live demo
Metaphactory server with the delpoyed application can be accessed here: **TBD**

# Project structure
- `apps/notice-app`: directory containing the application implementation and configuration. The directory organization conforms to the [Metaphactory project structure](https://help.metaphacts.com/resource/Help:Apps#apps-basic-folder-structure).
- `infra`: definition of the infrastructure
    - `infra/docker-compose.yml`: automation scripts
    - `infra/scripts`: automation scripts
    - `infra/import`: references to remote RDF files to be imported
    - `infra/config`: Metaphactory configuration files
- `Makefile`: defines a convenient interface for working with the project
- `.env`: environment variables for runtime environment

# Data
This repository doesn't store RDF data. Instead, URLs of data files are stored in [infra/import-full](infra/import-full) and are used to download and load the data during the environment initialization. 

Note that there is another [infra/import-min](infra/import-min) directory declaring minimal amount of needed data which can be used instead of _import-full_ to e.g. save time during setting up the environment. To do that, value of `IMPORT_SPEC_DIR` key in [.env](.env) needs to be changed.

## notices
For the demonstration purposes, a set of 36 notices is used ([infra/import-full](infra/import-full)). The data is taken from [ted-rdf-mapping](https://github.com/OP-TED/ted-rdf-mapping) GitHub repository.

## EPO ontology
The application uses [version 4.0.2 of EPO ontology](https://github.com/OP-TED/ePO/tree/v4.0.2/implementation/ePO_core/owl_ontology). The ontology is used to lookup for definitions and lables of the ontology terms.

## Authority tables
[EPO Authority tables](https://op.europa.eu/en/web/eu-vocabularies/e-procurement/tables) are used to used to lookup for lables of terms used in notice data.

# Running the application
## Prerequisites
- Docker
- Make
- docker image of Metaphactory server present on the host machine

## Initialize the environment
Execute `make init` command to initialize the server and the application. The command initializes the GraphDB repository, downloads and imports RDF data (notice data, EPO ontology, EPO authority tables) and creates indexes

## Launch the application
1. `make up`
1. open `http://HOST:8088/resource/StartPage` page in your web browser (_where the `HOST` is the IP/domain name of the machine where the server is running_). You should see the main page with a search bar and two big buttons for accessing notice and organization instances.

# Development
Once the application is running, the code can be edited either directly on the server or by editing source files in the local file system (changes will be reflected on the server as the app directory is mounted in the server container).

# Configuration
Following files keep configuration which can be adjusted if needed:
- [.env](.env): environment variables for runtime environment
- [infra/config/notices-graphdb_repo-config.ttl](infra/config/notices-graphdb_repo-config.ttl): GraphDB `notices` repository definition
- [infra/config/mp-graphdb-config.ttl](infra/config/mp-graphdb-config.ttl): Metaphactory configuration for the `notices` repository

# Infrastructure
The complete working solution consists of the following tools, services and artifacts:
- Metaphactory server
- GraphDB server storing Metaphactory data
- application code together with Metaphactory configuration
- initialization service together with automation scripts
- RDF data specification (notices and vocabularies)

The infrastructure is defined as a set of docker compose services. Predefined Make commands can be used to interact with the solution.

