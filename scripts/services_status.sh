#!/bin/bash
SERVICE_URL="http://your-service-url"

if curl --output /dev/null --silent --head --fail "$SERVICE_URL"; then
    echo "Service is up"
else
    echo "Service is down"
fi
