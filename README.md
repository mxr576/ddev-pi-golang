[![add-on registry](https://img.shields.io/badge/DDEV-Add--on_Registry-blue)](https://addons.ddev.com)
[![tests](https://github.com/mxr576/ddev-pi-golang/actions/workflows/tests.yml/badge.svg?branch=main)](https://github.com/mxr576/ddev-pi-golang/actions/workflows/tests.yml?query=branch%3Amain)
[![last commit](https://img.shields.io/github/last-commit/mxr576/ddev-pi-golang)](https://github.com/mxr576/ddev-pi-golang/commits)
[![release](https://img.shields.io/github/v/release/mxr576/ddev-pi-golang)](https://github.com/mxr576/ddev-pi-golang/releases/latest)

# DDEV Pi Golang

## Overview

This add-on integrates Pi Golang into your [DDEV](https://ddev.com/) project.

## Installation

```bash
ddev add-on get mxr576/ddev-pi-golang
ddev restart
```

After installation, make sure to commit the `.ddev` directory to version control.

## Usage

| Command | Description |
| ------- | ----------- |
| `ddev describe` | View service status and used ports for Pi Golang |
| `ddev logs -s pi-golang` | Check Pi Golang logs |

## Advanced Customization

To change the Docker image:

```bash
ddev dotenv set .ddev/.env.pi-golang --pi-golang-docker-image="ddev/ddev-utilities:latest"
ddev add-on get mxr576/ddev-pi-golang
ddev restart
```

Make sure to commit the `.ddev/.env.pi-golang` file to version control.

All customization options (use with caution):

| Variable | Flag | Default |
| -------- | ---- | ------- |
| `PI_GOLANG_DOCKER_IMAGE` | `--pi-golang-docker-image` | `ddev/ddev-utilities:latest` |

## Credits

**Contributed and maintained by [@mxr576](https://github.com/mxr576)**
