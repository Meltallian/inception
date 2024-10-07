#!/bin/bash

# Wait for the WordPress container to be ready
while ! curl -s http://wp-php:9000/ > /dev/null; do
  echo "Waiting for wp-php to be ready..."
  sleep 5
done

# Start Nginx
nginx -g "daemon off;"
