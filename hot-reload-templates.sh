#!/bin/bash

# Set required environment variables
export PYGEOAPI_CONFIG=/pygeoapi/local.config.yml
export PYGEOAPI_OPENAPI=/pygeoapi/pygeoapi/openapi.yml

echo "[DEV MODE] Generating OpenAPI document..."
pygeoapi openapi generate "$PYGEOAPI_CONFIG" --output-file "$PYGEOAPI_OPENAPI"

# Collect all template files for reload watching
echo "[DEV MODE] Watching template files for reload..."
EXTRA_FILES=$(find /pygeoapi/pygeoapi/templates -type f -exec echo --reload-extra-file {} \; | xargs)

echo "[DEV MODE] Starting Gunicorn with hot reload..."
exec gunicorn --workers 4 \
  --worker-class=gevent \
  --timeout 6000 \
  --name=pygeoapi \
  --bind 0.0.0.0:80 \
  --reload \
  --reload-extra-file "$PYGEOAPI_CONFIG" \
  --reload-extra-file "$PYGEOAPI_OPENAPI" \
  $EXTRA_FILES \
  pygeoapi.flask_app:APP
