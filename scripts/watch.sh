#!/bin/bash
#
# Author: Brian Beck <exogen@gmail.com>
# Usage: watch PATH COMMAND...
#
# This script watches PATH and runs COMMAND whenever PATH or a descendent
# of PATH is modified. COMMAND is everything after the first argument.
#
# If PATH is "-", then the list of paths comes from standard input.
#
# Directories are always watched recursively.
#
# The modification check runs every half second.
#

set -e

usage () {
    cat << USAGE

usage:
  $0 PATH COMMAND...
  <stdin> | $0 - COMMAND...

examples:
  watch ~/Desktop echo "who touched my stuff?"
  watch lib make
  watch . make test
  ls config* make* | watch - make clean

USAGE
}

# Show usage if there are no arguments.
if [ $# -lt 1 ]; then
    usage
    exit 1
fi

# If the first argument is "-", read a list of paths from stdin.
# Otherwise, the first argument is a single path.
if [ "$1" = "-" ]; then
    i=0
    while read path; do
        paths[$i]="$path"
        (( i++ ))
    done
else
    paths=( "$1" )
fi

while true; do
    # Create a new "checksum" (modification times, sizes, filenames).
    new=$(find "${paths[@]}" \
        -not \( -type d -name ".?*" -prune \) \
        -print0 2>/dev/null | xargs -0 stat -c "%m %z %N")

    if [ "$new" != "$old" ]; then
        # Run the remaining arguments as a single command.
        "${@:2}" || echo # Don't exit if the command fails.
        old=$new
    fi

    sleep 0.5
done
