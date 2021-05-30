#!/bin/bash

version="$1"

if [[ -z $version ]]; then
  echo "No version set."
  exit 1
fi

rm .build/*

creator_name="amalgamated-tools"
package_name="tautulli_exporter"
full_package_name="$creator_name/$package_name"
output_name=$package_name'-linux-amd64'
GOOS=linux GOARCH=amd64 go build -a -installsuffix cgo -ldflags "-w -s -X main.version=$version" -o .build/$output_name



# docker build -t $full_package_name .
# docker tag $full_package_name $full_package_name:$version
# docker push $full_package_name
# docker push $full_package_name:$version

# git tag -a $version -m "$version"
# git push origin tag $version
