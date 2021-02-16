#!/bin/bash

set -o errexit
set -o pipefail
set -o xtrace

docker build --tag jclulow/buildomat:latest .
docker push jclulow/buildomat:latest
