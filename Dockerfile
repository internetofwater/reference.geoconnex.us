FROM geopython/pygeoapi:latest
# pygeoapi last updated 2025-01-15

COPY ./pygeoapi-skin-dashboard/templates /pygeoapi/pygeoapi/templates
COPY ./pygeoapi-skin-dashboard/static /pygeoapi/pygeoapi/static

COPY ./pygeoapi.config.yml /pygeoapi/local.config.yml

RUN pip3 install --no-cache-dir --no-deps https://github.com/cgs-earth/pygeoapi-plugins/archive/refs/heads/master.zip \
    && pip3 install SPARQLWrapper
