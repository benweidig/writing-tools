#!/usr/bin/env bash

if [[ -n "$DEBUG" ]]; then
    set -x
fi

set -e

if [[ ! "$#" -eq 1 ]]; then
    >&2 printf "1 argument must be provided (book-folder), but found '%s'.\n" "$#"
    exit 1
fi

RC=0

for BOOK_FILE in "$1"/*.asciidoc; do
    while IFS=: read -r FIGURE_PATH; do
        if [[ ! -f "$FIGURE_PATH" ]]; then
            >&2 printf "%s: figure '%s' is missing.\n" "$BOOK_FILE" "$FIGURE_PATH"
            RC=1
        fi
    done < <(sed -n 's/image::\(.*\)\[.*\]/\1/p' "$BOOK_FILE")

    while IFS=: read -r FIGURE_PATH_WITH_ALT; do
        if [[ $FIGURE_PATH_WITH_ALT =~ .*\[\".*(<|>).*\"\] ]]; then
            >&2 printf "%s: figure '%s' alt contains invalid char.\n" "$BOOK_FILE" "$FIGURE_PATH_WITH_ALT"
            RC=1
        fi
    done < <(sed -n 's/image::\(.*\)/\1/p' "$BOOK_FILE")
done

exit $RC
