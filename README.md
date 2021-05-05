# app-gn-embeddable
Backend systems and editor built on top of the Besluit and Mandaat model and application profile as defined on:

    http://data.vlaanderen.be/ns/besluit
    http://data.vlaanderen.be/doc/applicatieprofiel/besluit-publicatie/
    http://data.vlaanderen.be/ns/mandaat
    http://data.vlaanderen.be/doc/applicatieprofiel/mandatendatabank/

This repository is a [mu-project](https://github.com/mu-semtech/mu-project), it includes the minimal set of services required to run the embeddable editor. In essence this repository is the minimal version of app-gelinkt-notuleren.

## requirements and assumptions
This project was tested on ubuntu 18.04 and 20.04, but should work on most systems that run docker and docker-compose. A linux based system is recommended, but we welcome any feedback you might have when running this system on macOS or windows.

 * a recent version of [docker needs to be installed](https://docs.docker.com/get-docker/)
 * a recent version of [docker-compose needs to be installed](https://docs.docker.com/compose/install/)
 * some basic shell experience is recommended
 
## getting started
 
 1. make sure all [requirements](#requirements-and-assumptions) are met
 2. clone this repository
 ```
 $ git clone https://github.com/lblod/app-gn-embeddable
 ```
 3. run the project
 ```
$ cd app-gn-embeddable
$ docker-compose up -d
 ```

After running these commands you should have a basic version of embeddable running on port 80.

## providing a custom version of embeddable
This stack contains the default build of embeddable. It's recommended to build your own custom version with the plugins that are interesting to your use case.

The [frontend-embeddable-notule-editor](https://github.com/lblod/frontend-embeddable-notule-editor#frontend-embeddable-notule-editor) has detailed instructions on building your own version of embeddable. Once build you should have a dist folder with the necessary files. 

Add the dist folder to the data directory of this project and add create a `docker-compose.override.yml` file with the following contents:

```
version: "3.4"
services:
  editor:
    volumes:
      - ./data/dist:/app
```

Finally run `docker-compose up -d` again to have your custom version running.

## adding SSL [BETA]
We've provided a configuration that automatically creates and configures ssl certificates through letsencrypt.

edit the included `.env` file to include the https docker-compose file:
```
COMPOSE_FILE=docker-compose.yml:docker-compose.https.yml:docker-compose.override.yml
```
next edit the docker-compose.override.yml file to add your domain name:

```
version: "3.4"
x-logging: &default-logging
  driver: "json-file"
  options:
    max-size: "10m"
    max-file: "3"
services:
  editor:
    environment:
      VIRTUAL_HOST: "editor.awesomecorp.com"
      LETSENCRYPT_HOST: "editor.awesomecorp.com"
      LETSENCRYPT_EMAIL: "info@awesomecorp.com" # get an email if your ssl certificate expires or something else goes wrong
```

## overview of services
TODO


