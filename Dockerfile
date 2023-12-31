FROM internetofwater/pygeoapi:latest
#pygeoapi last updated 2023-07-31

#add requirements and mods
COPY ./pygeoapi.config.yml /pygeoapi/local.config.yml

# COPY ./schemas.opengis.net /opt/schemas.opengis.net
COPY ./pygeoapi-skin-dashboard /skin-dashboard

COPY ./sitemap /sitemap
RUN mv /sitemap/_sitemap.xml /sitemap/sitemap.xml
