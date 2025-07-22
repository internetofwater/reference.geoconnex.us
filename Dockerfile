FROM internetofwater/pygeoapi:latest
# pygeoapi last updated 2025-07-22

COPY ./pygeoapi-skin-dashboard/templates /pygeoapi/pygeoapi/templates
COPY ./pygeoapi-skin-dashboard/static /pygeoapi/pygeoapi/static

COPY ./pygeoapi.config.yml /pygeoapi/local.config.yml

COPY ./sitemap /sitemap
RUN pip install "shapely<2"
