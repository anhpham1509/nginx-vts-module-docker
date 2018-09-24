# Nginx Docker image with vts module

<!-- toc -->

* [Features](#features)
* [Development tools](#development-tools)
* [Update markdown TOC](#update-markdown-toc)
* [Update Docker image configurations](#update-docker-image-configurations)
* [Push image to Docker Hub](#push-image-to-docker-hub)

<!-- tocstop -->

## Features

* Nginx Docker image including vts module

## Development tools

* [GNU-sed](https://www.gnu.org/software/sed/)
    ```bash
    make gnu-sed
    ```
* [blackbox](https://github.com/StackExchange/blackbox#installation-instructions)
* [Docker](https://www.docker.com/get-started)

* [gcloud v211.0.0](https://cloud.google.com/sdk/docs/downloads-versioned-archives)

## Update markdown TOC

```bash
make md-toc
```

## Update Docker image configurations

```bash
make update
```

## Push image to Docker Hub

```bash
make push
```