#!/bin/bash
# This will remove all images that are not being used.
docker rmi $(docker images -f "dangling=true" -q)
