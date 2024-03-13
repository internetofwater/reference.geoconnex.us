# Hydrodump Action Quickstart

This document serves to familiarize the *Contributor* with Hydrodump Action by showing how to build and run it from source in a local build environment (*Environment*). This software builds the Geoconnex [Reference Feature Postgres Database](https://reference.geoconnex.us). This is used to load GeoPackages in a [Hydroshare](https://www.hydroshare.org/) resource into one PostGIS Table of all Geoconnex.us reference features.

# Prerequisites

In order to run Hydrodump Action you must have a [Hydroshare Account](https://www.hydroshare.org/home/) and the following installed in your *Environment*. 

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
Docker is used here to launch YOURLS developer runtime service dependencies YOURLS and its database (MySQL). 

### Installation
Docker can be downloaded and installed from the official Docker website. Follow the installation instructions for your specific operating system.

### Validation
Once Docker is installed, you can verify that it's running correctly by executing the following command:

```bash
docker --version
docker info
```

Note: To run docker on alpine, you must have sudo privileges.

## GDAL
GDAL is used to ETL the features from the GeoPackage to PostGIS database

### Installation
GDAL can be installed on various operating systems, including Linux, macOS, and Windows. Follow the installation instructions for your specific operating system. The gdal plugin for PostgreSQL must also be installed.


# Building Hydrodump Action

Choose a starting location to work on your computer:

```bash
export SRC_BASE_DIR=/path/to/dev/directory
```

## Clone
Clone [Hydrodump Action](https://github.com/cgs-earth/hydrodump-action.git) from the CGS GitHub repository to your *Environment* in a predefined directory location.

```bash
mkdir $SRC_BASE_DIR
cd $SRC_BASE_DIR
git clone git@github.com:<GH_USER>/hydrodump-action.git
```

## Runtime Dependencies

### Setup Environment Variables:

Create a file called ``.env`` based on [default.env](/default.env) with Hydroshare credentials, and save this to your local env
```bash
vi $SRC_BASE_DIR/.env
```

Export the ``.env`` file to your terminal:
```bash
. $SRC_BASE_DIR/.env
``` 

### Start Database:

Start the PostGIS Database

```bash
docker run -d -p 5432:5432 --name database --env-file .env postgis/postgis:14-3.2-alpine
# If running on an ARM64 chip
docker run -d -p 5432:5432 --name database --env-file .env tobi312/rpi-postgresql-postgis:14-3.4-alpine-arm64
```

### Set up Hydrodump Action environment

First install the python package Sitemap Generator, which loads the directory tree into the a sitemap index hierarchy.

```bash
cd $SRC_BASE_DIR/hydrodump-action/hydrodump
# if user has sudo privileges
python3 setup.py install
# else
pip3 install -e .
```

Note: Ensure the location you install hydrodump-action is on your `$PATH`, otherwise you
won't be able to use the hydrodump-action CLI.

# Running Hydrodump Action

To run Sitemap Generator, use the CLI:

```bash
hydrodump run
```

## Verifying Hydrodump Action Output

To verify Hydrodump Action has inserted the GeoPackages run the following...

```bash
docker exec -it database \
   sh -c 'psql -U root -d reference -c "\dt public.*"'
```

The table should appear as follows (as of 2024-03-13):

| Schema |      Name       | Type  | Owner |
|--------|-----------------|-------|-------|
| public | aiannh          | table | root  |
| public | cbsa            | table | root  |
| public | counties        | table | root  |
| public | hu02            | table | root  |
| public | hu04            | table | root  |
| public | hu06            | table | root  |
| public | hu08            | table | root  |
| public | hu10            | table | root  |
| public | mainstems       | table | root  |
| public | nat_aq          | table | root  |
| public | places          | table | root  |
| public | princi_aq       | table | root  |
| public | ref_dams        | table | root  |
| public | ref_gages       | table | root  |
| public | ref_pws         | table | root  |
| public | sec_hydrg_reg   | table | root  |
| public | spatial_ref_sys | table | root  |
| public | states          | table | root  |
| public | ua10            | table | root  |
