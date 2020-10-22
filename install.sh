#!/bin/bash

set -e

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
swift build --package-path "${SCRIPTPATH}" -c release
cp -f "${SCRIPTPATH}/.build/release/image-resizer" /usr/local/bin/image-resizer
rm -r "${SCRIPTPATH}/.build/release"

echo "Installed image-resizer into /usr/local/bin/"

