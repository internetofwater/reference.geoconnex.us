# https://reference.geoconnex.us

The geoconnex reference data server is an implementation of OGC API - Features using [pygeoapi.](https://pygeoapi.io/)
The server configuration exists at [pygeoapi.config.yml](pygeoapi.config.yml), using data hosted on [Hydroshare](https://www.hydroshare.org/resource/3295a17b4cc24d34bd6a5c5aaf753c50/)
This server provides permanent identifiers and HTML representations of real world things that multiple agencies may be collecting and publishing data about.

## Contributing new content

Three pieces of information are required for a new contribution:

1. [Spatial Features](#spatial-features): Contribution of spatial feature geometry and attributes in the [Hydroshare resource](https://www.hydroshare.org/resource/3295a17b4cc24d34bd6a5c5aaf753c50/) as a GeoPackage.
2. [pygeoapi Configuration](#pygeoapi-configuration): Creation of the corresponding pygeoapi resource configuration in [pygeoapi.config.yml](pygeoapi.config.yml). 
3. [Permanent Identifiers](#permanent-identifiers): PIDs registered within the `ref` namespace in `geoconnex.us`.

### Spatial Features

Spatial feature data should be contributed in `SQLite GeoPackage` (preferably) and be optimized for simple web-preview. This means the geometry should be simplified as much as is practical and attributes should be useful to a general audience.

At a minimum, the features should include attributes containing a name for the features and the PIDs of the features. The PIDs should be in an attribute titled `uri`.

### pygeoapi Configuration

Once the spatial feature has been contributed to Hydroshare, the next step is creating a pygeoapi configuration. 
Any time a change is made to the resource in Hydroshare or to the pygeoapi configuration, update the comment to the date of last modification.

```
    mainstems: # updated 2023-04-11
        type: collection
        title: Reference Mainstems
        description: US Reference Mainstem Rivers
        keywords:
            - Mainstem
        linked-data:
            item_template: jsonld/mainstems.jsonld
            context:
                - schema: https://schema.org/
                  name_at_outlet: schema:name
        links:
            - type: application/html
              rel: canonical
              title: data source
              href: https://github.com/internetofwater/ref_rivers
              hreflang: en-US
        extents: *extents
        providers:
            - type: feature
              name: PostgreSQL
              data: *provider-data
              id_field: id
              table: mainstems
              uri_field: uri
              geom_field: geom
```

The configuration should include linked data context that associate attributes of the data to JSON-LD properties.

Note that in the configuration, the `providers` configuration entry should specify in `table` the same string as the lowercase name of the GeoPackage in Hydroshare, minus `.gpkg`.
For example, the configuration for collection mainstems, is `mainstems.gpkg` in Hydroshare.
The `uri` element is required and ensures that the attributes get associated with the feature's PID rather than the URL of the https://reference.geoconnex.us reference data server.

Many other context elements are possible. The [ELFIE project](https://opengeospatial.github.io/ELFIE/) has focused on that topic and can be a source of inspiration.

It is expected that the attributes and richness of these contexts will expand over time but getting some basic content in the system is better than nothing, so please don't hesitate to get something started and open a pull request. The geoconnex crew is more than happy to help get things across the finish line!

### Permanent Identifiers

The features hosed in the https://reference.geoconnex.us are intended to provide landing pages for PIDs registered in the `https://geoconnex.us/ref/` namespace, more info on those features can be found [here](https://github.com/internetofwater/geoconnex.us/tree/master/namespaces/ref)

These reference features are intended to be ["community reference locations"](https://github.com/internetofwater/geoconnex.us/wiki/Community-Reference-Locations) and will be created based on broadly-recognized reference data or by a community group interested in registering a wholistic set of reference identifiers that unify multiple organization's identifiers of a similar type. Please [open a new general issue](https://github.com/internetofwater/geoconnex.us/issues/new?template=general.md&title=%5Bgeneral%5D) to discuss an idea for a new set of reference identifiers.

## Install

Generate a SQL Dump of the Hydroshare resource using [Hydrodump Action](https://github.com/cgs-earth/hydrodump-action).

Then use docker compose to bring up the containers:

```
docker compose up -d database
docker compose up -d pygeoapi
```
