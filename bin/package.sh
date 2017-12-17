#!/usr/bin/env bash
set -euo pipefail

sha=$(git rev-parse --short HEAD)
branch=$(git rev-parse --abbrev-ref HEAD)
root=$(git rev-parse --show-toplevel)
uberjar=$root/target/uberjar
version="app-$branch-$sha"
target="$uberjar/$version.zip"

if [ ! -f $uberjar/app.jar ]; then
  echo "You first need to generate the application .jar."
  echo "Run: lein package"
  exit 1
fi

zip -rj $target $uberjar/app.jar $root/Dockerfile
echo $version > "$uberjar/app-version.txt"

echo "Created zip file with application in: $target"

__IS_MAC=${__IS_MAC:-$(test $(uname -s) == "Darwin" && echo 'true')}
if [ -n "${__IS_MAC}" ]; then
  echo "app-$branch-$sha" | /usr/bin/pbcopy
else
  # copy to selection buffer AND clipboard
  echo "app-$branch-$sha" | xclip -i -sel c -f | xclip -i -sel p
fi


echo "Copied app version app-$branch-$sha to clipboard!"
