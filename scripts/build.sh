#!/usr/bin/env bash

set -euo pipefail

GOOS="linux" go build -ldflags='-s -w' -o bin/helper github.com/paketo-buildpacks/libjvm/cmd/helper
GOOS="linux" go build -ldflags='-s -w' -o bin/main github.com/initializ-buildpacks/bellsoft-liberica/v9/cmd/main

if [ "${STRIP:-false}" != "false" ]; then
  strip bin/helper bin/main
fi

if [ "${COMPRESS:-none}" != "none" ]; then
  $COMPRESS bin/helper bin/main
fi

ln -fs main bin/build
ln -fs main bin/detect
