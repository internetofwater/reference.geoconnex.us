FROM geopython/pygeoapi:latest
#pygeoapi last updated 2023-07-31

# COPY ./schemas.opengis.net /opt/schemas.opengis.net
COPY ./pygeoapi-skin-dashboard /skin-dashboard

RUN pip3 install https://github.com/cgs-earth/pygeoapi-plugins/archive/refs/heads/master.zip

COPY ./sitemap /sitemap
RUN mv /sitemap/_sitemap.xml /sitemap/sitemap.xml
