#!/bin/bash

set -e

unset CDPATH

function follow_links() {
  cd -P "${1%/*}"
  local file="$PWD/${1##*/}"
  while [[ -h "$file" ]]; do
    # On Mac OS, readlink -f doesn't work.
    cd -P "${file%/*}"
    file="$(readlink "$file")"
    cd -P "${file%/*}"
    file="$PWD/${file##*/}"
  done
  echo "$PWD/${file##*/}"
}
# Convert a filesystem path to a format usable by Dart's URI parser.
function path_uri() {
  # Reduce multiple leading slashes to a single slash.
  echo "$1" | sed -E -e "s,^/+,/,"
}

PROG_NAME="$(path_uri "$(follow_links "$BASH_SOURCE")")"
BIN_DIR="$(cd "${PROG_NAME%/*}" ; pwd -P)"
cd $BIN_DIR

pub get

# FIRST. generate output
./test_cli.sh

# SECOND. generate part file
flutter packages pub run build_runner build --delete-conflicting-outputs
dartfmt -w .

# test
pub run test