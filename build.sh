#!/bin/bash

version="$1"

if [[ -z $version ]]; then
  echo "No version set."
  exit 1
fi

rm .build/*

creator_name="amalgamated-tools"
package_name="tautulli-exporter"
full_package_name="docker.pkg.github.com/amalgamated-tools/tautulli-exporter/tautulli-exporter"

output_name='tautulli-exporter-linux-amd64'
GOOS=linux GOARCH=amd64 go build -a -ldflags "-w -s -X main.version=5" -o .build/tautulli-exporter-linux-amd64

docker build -t docker.pkg.github.com/amalgamated-tools/tautulli-exporter/tautulli-exporter .
docker tag docker.pkg.github.com/amalgamated-tools/tautulli-exporter/tautulli-exporter docker.pkg.github.com/amalgamated-tools/tautulli-exporter/tautulli-exporter:$version
docker push docker.pkg.github.com/amalgamated-tools/tautulli-exporter/tautulli-exporter
docker push docker.pkg.github.com/amalgamated-tools/tautulli-exporter/tautulli-exporter:$version

git tag -a $version -m "$version"
git push origin tag $version
