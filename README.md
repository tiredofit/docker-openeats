
# hub.docker.com/r/tiredofit/openeats

[![Build Status](https://img.shields.io/docker/build/tiredofit/openeats.svg)](https://hub.docker.com/r/tiredofit/openeats)
[![Docker Pulls](https://img.shields.io/docker/pulls/tiredofit/openeats.svg)](https://hub.docker.com/r/tiredofit/openeats)
[![Docker Stars](https://img.shields.io/docker/stars/tiredofit/openeats.svg)](https://hub.docker.com/r/tiredofit/openeats)
[![Docker Layers](https://images.microbadger.com/badges/image/tiredofit/openeats.svg)](https://microbadger.com/images/tiredofit/openeats)


# Introduction

This will build a container for [OpenEats](https://open-eats.github.io/) - An open source Recipe Manager.

* Automatically installs and sets up installation upon first start
        
This Container uses [tiredofit/alpine:3.9](https://hub.docker.com/r/tiredofit/alpine) and [tiredofit/nodejs:11-alpine](https://hub.docker.com/r/tiredofit/nodejs) as a base.

[Changelog](CHANGELOG.md)

# Authors

- [Dave Conroy](https://github.com/tiredofit)

# Table of Contents

- [Introduction](#introduction)
    - [Changelog](CHANGELOG.md)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Quick Start](#quick-start)
- [Configuration](#configuration)
    - [Data Volumes](#data-volumes)
    - [Environment Variables](#environmentvariables)   
    - [Networking](#networking)
- [Maintenance](#maintenance)
    - [Shell Access](#shell-access)
   - [References](#references)

# Prerequisites

This image assumes that you are using a reverse proxy such as 
[jwilder/nginx-proxy](https://github.com/jwilder/nginx-proxy) and optionally the [Let's Encrypt Proxy 
Companion @ 
https://github.com/JrCs/docker-letsencrypt-nginx-proxy-companion](https://github.com/JrCs/docker-letsencrypt-nginx-proxy-companion) 
in order to serve your pages. However, it will run just fine on it's own if you map appropriate ports. See the examples folder for a docker-compose.yml that does not rely on a reverse proxy.

You will also need an external MySQL/MariaDB Container

# Installation

Automated builds of the image are available on [Docker Hub](https://hub.docker.com/r/tiredofit/openeats) and is the recommended method of installation.


```bash
docker pull tiredofit/openeats:latest
```

# Quick Start

* The quickest way to get started is using [docker-compose](https://docs.docker.com/compose/). See the examples folder for a working [docker-compose.yml](examples/docker-compose.yml) that can be modified for development or production use.

* Set various [environment variables](#environment-variables) to understand the capabilities of this image.
* Map [persistent storage](#data-volumes) for access to configuration and data files for backup.
* Make [networking ports](#networking) available for public access if necessary

*The first boot can take from 2 minutes - 10 minutes depending on your CPU to setup the proper schemas.

Login to the web server and enter in your admin email address, admin password and start configuring the system!

# Configuration

### Data-Volumes

The following directories are used for configuration and can be mapped for persistent storage.

| Directory    | Description                                                 |
|--------------|-------------------------------------------------------------|
| `/app/data` | Uploaded Images/Static Files |
| `/www/logs` | Nginx log files |

### Environment Variables

Along with the Environment Variables from the [Base image](https://hub.docker.com/r/tiredofit/alpine), below is the complete list of available options that can be used to customize your installation.

| Parameter        | Description                            |
|------------------|----------------------------------------|
| `APPLICATION_NAME` | Application Name - Default `Openeats` |
| `ADMIN_USER` | Admin Username - Default `admin` |
| `ADMIN_EMAIL` | Admin Email Address - Default `admin@example.com` |
| `ADMIN_PASS` | Admin Password - Default `openeats` |
| `API_PORT` | API Port - Default `5210` |
| `API_WORKERS | Amount of API Workers to spawn - Default `5` |
| `DB_HOST` | Host or container name of MySQL Server e.g. `openeats-db` |
| `DB_PORT` | MySQL Port - Default `3306` |
| `DB_NAME` | MySQL Database name e.g. `openeats` |
| `DB_USER` | MySQL Username for above Database e.g. `openeats` |
| `DB_PASS` | MySQL Password for above Database e.g. `password` |
| `DEMO_MODE` | Load Demo Data on Initial Setup `TRUE` `FALSE` - Default `FALSE` |
| `ENABLE_SSL_PROXY` | If using SSL reverse proxy force application to return https URLs `TRUE` or `FALSE` |
| `SITE_NAME` | Set this to the host.domainname.tld that this is listening on - Default `openeats.example.com`|


### Networking

The following ports are exposed.

| Port      | Description |
|-----------|-------------|
| `80`      | HTTP        |

# Maintenance

#### Shell Access

For debugging and maintenance purposes you may want access the containers shell. 

```bash
docker exec -it (whatever your container name is e.g. openeats) bash
```

# References

* https://open-eats.github.io/
* https://github.com/open-eats/OpenEats/blob/master/docs/Running_the_App_Without_Docker.md
