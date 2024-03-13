# Quickstart

## About

This document provides a quick set up for an up-to-date version of the Reference Feature Service. For a quickstart on pygeoapi, see https://pygeoapi.io/. For a quickstart as a contributor, see [Contributor](./contributor/) for the set up of a development environment.

## Install and Run

```bash
git clone https://github.com/internetofwater/reference.geoconnex.us
cd reference.geoconnex.us
```

Setup [Hydroshare](https://www.hydroshare.org/landingPage) Credentials, you may need to create an account:
```bash
cp default.env .env
vi .env
```

Start database on localhost:
```bash
docker compose build
docker compose up -d database
```

Populate database with hydrodump:
```bash
docker compose up hydrodump
```

Start pygeoapi:
```bash
docker compose up -d pygeoapi
```

The Reference Feature server will be running on port 5000.
