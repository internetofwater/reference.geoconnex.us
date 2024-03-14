# Contributor Onboarding
This document serves as a prerequisite knowledge checklist for Open Source contributors (Contributor(s)) to the Geoconnex system (System). The System is composed of multiple components which in turn leverage various Open Source software projects and their toolchains.

The system works as follows:

![reference-server](/docs/img/reference_feature_server_diagram.png)

## Topics
For specific contributor documentation on a particular software, follow the contributor spepcific documentation:
- [Hydrodump Action](./hydrodump.md)
- [pygeoapi](./pygeoapi.md)

# Prerequisite Knowledge

The Contributor should become proficient with the following programming languages, data models, file formats, toolchains, and the Geoconnex Components and related dependent services that comprise the System.

## Programming Languages

### [Python](https://python.org)
What the [Hydrodump Action](https://github.com/cgs-earth/hydrodump-action) and [pygeoapi](https://github.com/geopython/pygeoapi) for the Geoconnex Reference Feature Server is written in.

### [Bash](https://www.gnu.org/software/bash/manual/bash.html)
Used to create various scripts in the [Geoconnex component](#geoconnex-components) toolchain.

## File Formats

### JSON-LD
File format used to structure and represent linked data, facilitating the expression of context and relationships within the data, commonly employed for enhanced data interoperability and semantics on the web.

### GeoPackage
The GeoPackage file format is a lightweight, open, and platform-independent spatial data interchange standard that combines vector, raster, and attribute data in a single SQLite database container.

### [Dockerfile](https://docs.docker.com/engine/reference/builder/) 
File format used to build Docker images. Specifies how to package all [Geoconnex components](#geoconnex-components).

## Tool(chain)s

[Geoconnex components](#geoconnex-components) are invariably deployed and orchestrated as Docker containers at runtime. 

### [docker](https://docs.docker.com/engine/reference/commandline/cli/) 
### [docker compose](https://docs.docker.com/compose/)
*See Also* [Yaml](#yaml), 

## Software Frameworks

[pygeoapi](https://pygeoapi.io/) is an open source Reference Implementation for OGC API, which the [Reference Feature Server](#reference-feature-server) is built upon and used by [Publishers](https://github.com/internetofwater/harvest.geoconnex.us/blob/main/README.md#persona-publisher). The data pipeline created by the System which connects [Publishers](https://github.com/internetofwater/harvest.geoconnex.us/blob/main/README.md#persona-publisher) to common features known by [Users](https://github.com/internetofwater/harvest.geoconnex.us/blob/main/README.md#persona-user) is performed here.

## System Components 

### Geoconnex Components

#### [Reference Feature Server](https://github.com/internetofwater/reference.geoconnex.us) 

Reference Feature Server is used to host Geoconnex Reference Features and provide a [Reference Sitemap](https://reference.geoconnex.us/stac/sitemap) of JSON-LD pages that [Gleaner](https://github.com/gleanerio/gleaner) ingests to geoconnex. It is implemented using cloud native services, leveraging GCP's Cloud Run and Cloud SQL.

#### [Hydrodump Action](https://github.com/cgs-earth/hydrodump-action)

Builds the Postgres database from GeoPackages location in the [Geconnex Refereence Features Hydroshare Resource](https://www.hydroshare.org/resource/3295a17b4cc24d34bd6a5c5aaf753c50/). It is run as a part of the GitHub Actions build to stage the environment and deploy to the live server.

### Dependent (Cloud) Services 

See also [PID Server](https://github.com/internetofwater/pids.geoconnex.us)
See also [Harvest Service](https://github.com/internetofwater/harvest.geoconnex.us)

#### [pygeoapi](/pygeoapi.config.yml) on Cloud Run

Used by [pygeoapi](https://pygeoapi.io/) to serve OGC API - Features to all [Publishers](https://github.com/internetofwater/harvest.geoconnex.us/blob/main/README.md#persona-publisher) and [Users](https://github.com/internetofwater/harvest.geoconnex.us/blob/main/README.md#persona-publisher). The implementation used by [reference.geoconnex.us](https://pids.geoconnex.us) is pygeoapi on Cloud Run to scale the number of instances as requests are recieved.

#### Postgres Database on Cloud SQL

Used by [pygeoapi](https://pygeoapi.io/) to host all Reference Features in Geoconnex. Built using [Hydrodump Action](#hydrodump-action).
