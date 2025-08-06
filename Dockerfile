FROM internetofwater/pygeoapi:latest

COPY ./pygeoapi-skin-dashboard/templates /pygeoapi/pygeoapi/templates
COPY ./pygeoapi-skin-dashboard/static /pygeoapi/pygeoapi/static

COPY ./pygeoapi.config.yml /pygeoapi/local.config.yml
COPY ./sitemap /sitemap
RUN pip install "shapely<2"
# Copy the dev hot-reload script
COPY ./hot-reload-templates.sh /pygeoapi/hot-reload-templates.sh
RUN chmod +x ./hot-reload-templates.sh

# Dont reload by default
ENV HOT_RELOAD_TEMPLATES=0

# switch based on HOT_RELOAD_TEMPLATES for hot reload in development
ENTRYPOINT ["/bin/bash", "-c", "\
  if [[ \"$HOT_RELOAD_TEMPLATES\" == \"1\" ]]; then \
    /pygeoapi/hot-reload-templates.sh; \
  else \
  # default entrypoint if not in hot reload mode
    /entrypoint.sh run; \
  fi \
"]
