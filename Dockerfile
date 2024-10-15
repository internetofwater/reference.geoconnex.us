FROM internetofwater/pygeoapi:latest
#pygeoapi last updated 2024-10-15

# COPY ./schemas.opengis.net /opt/schemas.opengis.net
COPY ./pygeoapi-skin-dashboard /skin-dashboard

COPY ./pygeoapi.config.yml /pygeoapi/local.config.yml

RUN pip3 install https://github.com/cgs-earth/pygeoapi-plugins/archive/refs/heads/master.zip

COPY ./sitemap /sitemap
RUN mv /sitemap/_sitemap.xml /sitemap/sitemap.xml
