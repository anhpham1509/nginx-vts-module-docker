# [Nginx Docker image with vts module](https://hub.docker.com/r/anhpham1509/nginx-vts-module/)

[![CircleCI](https://circleci.com/gh/anhpham1509/nginx-vts-module-docker/tree/master.svg?style=svg)](https://circleci.com/gh/anhpham1509/nginx-vts-module-docker/tree/master)

<!-- toc -->

* [Features](#features)
* [Development tools](#development-tools)
* [Update markdown TOC](#update-markdown-toc)
* [Update Docker image configurations](#update-docker-image-configurations)
* [Push image to Docker Hub](#push-image-to-docker-hub)

<!-- tocstop -->

## Features

* Nginx Docker image including [vts module]((https://github.com/vozlt/nginx-module-vts))

## Development tools

* [GNU-sed](https://www.gnu.org/software/sed/)
    ```bash
    make gnu-sed
    ```
* [Docker](https://www.docker.com/get-started)

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
