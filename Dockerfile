FROM geopython/pygeoapi:latest
# pygeoapi last updated 2025-09-23

RUN /venv/bin/python3 -m pip install --no-cache-dir \
        https://github.com/internetofwater/pygeoapi/archive/refs/heads/dev.zip \
        https://github.com/cgs-earth/pygeoapi-plugins/archive/refs/heads/master.zip

COPY ./pygeoapi-skin-dashboard/templates /pygeoapi/pygeoapi/templates
COPY ./pygeoapi-skin-dashboard/static /pygeoapi/pygeoapi/static

COPY ./pygeoapi.config.yml /pygeoapi/local.config.yml

COPY ./sitemap /sitemap
