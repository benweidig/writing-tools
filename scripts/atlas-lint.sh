#!/usr/bin/env bash

if [[ -n "$DEBUG" ]]; then
    set -x
fi

command -v "jq" > /dev/null 2>&1
# shellcheck disable=SC2181
if [[ $? -ne 0 ]]; then
    >&2 printf 'jq is not available.\n'
    exit 1
fi

set -e

if [[ ! "$#" -eq 1 ]]; then
    >&2 printf "1 argument must be provided (book-folder), but found '%s'.\n" "$#"
    exit 1
fi

RC=0

while IFS=: read -r ATLAS_FILE; do
    if [[ ! -f "$ATLAS_FILE" ]]; then
        >&2 printf "atlas.json: referenced file '%s' is missing.\n" "$ATLAS_FILE"
    RC=1
    fi
done < <( jq -r '.files[]' "$1"/atlas.json)

exit $RC
