# pygeoapi Quickstart

This document serves to familiarize the *Contributor* with pygeoapi by showing how to build and run it from source in a local build environment (*Environment*). This software builds the Geoconnex [Reference Feature Server](https://reference.geoconnex.us). This is used to serve HTML representations of all Geoconnex.us reference features using OGC API - Features.

# Prerequisites

In order to run pygeoapi you must have the following installed in your *Environment*. 

## Python and Pip
Python and Pip can be downloaded and installed from the official [Python website](https://python.org/). Ensure you select the appropriate version for your operating system.

As of the last update, the Sitemap Generator requires Python 3.6 or later. Check the system's documentation or codebase for the specific version requirements.

This documentation may refer to the ``PYTHONPATH`` environment variable, which indicates the directories where Python looks for modules. If not set, Python will use a default path.

Please refer to the Python official documentation for comprehensive information on Python installation, configuration, and development practices.

```bash
python3 --version
pip3 --version
```

## Git

### Installation
Git can be downloaded and installed from the official [Git website](https://git-scm.com/). Follow the installation instructions for your specific operating system.

### Version Check
To check the installed Git version, use the following command:

```bash
git --version
```

## Docker
Docker is used here to functionally deploy pygeoapi and for local developer environments as the database (MySQL). 

### Installation
Docker can be downloaded and installed from the official Docker website. Follow the installation instructions for your specific operating system.

### Validation
Once Docker is installed, you can verify that it's running correctly by executing the following command:

```bash
docker --version
docker info
```

Note: To run docker on alpine, you must have sudo privileges.

# Building pygeoapi

Choose a starting location to work on your computer:

```bash
export SRC_BASE_DIR=/path/to/dev/directory
```

## Clone
Clone [pygeoapi](https://github.com/geopython/pygeoapi.git) from the CGS GitHub repository to your *Environment* in a predefined directory location. We maintain a fork of pygeoapi at [internetofwater/pygeoapi](https://github.com/internetofwater/pygeoapi.git) which includes [pygeoapi-plugins](https://github.com/cgs-earth/pygeoapi-plugins)

```bash
mkdir $SRC_BASE_DIR
cd $SRC_BASE_DIR
git clone git@github.com:<GH_USER>/pygeoapi.git
```


### Set up pygeoapi environment

First install the python package pygeoapi and its dependencies.

```bash
cd $SRC_BASE_DIR/pygeoapi
pip3 install -r requirements.txt
# if user has sudo privileges
python3 setup.py install
# else
pip3 install -e .
```

Note: Ensure the location you install pygeoapi is on your `$PATH`, otherwise you
won't be able to use the pygeoapi CLI.

## Runtime Dependencies

### Setup Configuration:

Create a environment variables for the location of the pygeoapi configuration and openapi file.

```bash
export PYGEOAPI_CONFIG=example-config.yml
export PYGEOAPI_OPENAPI=example-openapi.yml
```

Edit ``example-config.yml`` as required.

```bash
cp pygeoapi-config.yml $PYGEOAPI_CONFIG
vi $PYGEOAPI_CONFIG
```

Generate OpenAPI document

```bash
pygeoapi openapi generate $PYGEOAPI_CONFIG --output-file $PYGEOAPI_OPENAPI
```

# Running pygeoapi

To run pygeoapi, use the CLI:

```bash
pygeoapi serve
```

## Verifying pygeoapi

To verify pygeoapi is up and runnning, curl the root of the server or open in a web browser

```bash
curl http://localhost:5000
```
