FROM geopython/pygeoapi:latest
# pygeoapi last updated 2025-01-15

COPY ./pygeoapi-skin-dashboard /skin-dashboard

COPY ./pygeoapi.config.yml /pygeoapi/local.config.yml

RUN pip3 install --no-cache-dir --no-deps https://github.com/cgs-earth/pygeoapi-plugins/archive/refs/heads/master.zip \
    && pip3 install SPARQLWrapper

COPY ./sitemap /sitemap
RUN mv /sitemap/_sitemap.xml /sitemap/sitemap.xml

COPY ./tiles /tmp/tiles/
RUN apt-get update \
    && apt-get install -y unzip \
    && mkdir -p /data/tiles \
    && unzip /tmp/tiles/* -d /data/tiles/
