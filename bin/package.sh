#!/usr/bin/env bash
set -euo pipefail

sha=$(git rev-parse --short HEAD)
branch=$(git rev-parse --abbrev-ref HEAD)
root=$(git rev-parse --show-toplevel)
uberjar=$root/target/uberjar
version="app-$branch-$sha"
target="$uberjar/$version.zip"

if [ ! -f $uberjar/my-app.jar ]; then
  echo "You first need to generate the application .jar."
  echo "Run: lein package"
  exit 1
fi

zip -rj $target $uberjar/my-app.jar $root/Dockerfile
echo $version > "$uberjar/app-version.txt"

echo "Created zip file with application in: $target"
