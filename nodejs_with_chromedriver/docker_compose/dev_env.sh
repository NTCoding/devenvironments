#! /bin/bash

set -ex

docker-compose up -d --build --force-recreate
docker-compose exec app /bin/bash
