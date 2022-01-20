#!/usr/bin/env bash

if [[ -n "$DEBUG" ]]; then
    set -x
fi

if [[ ! "$#" -eq 1 ]]; then
    >&2 printf "1 argument must be provided (book-folder), but found '%s'.\n" "$#"
    exit 1
fi

RC=0

for BOOK_FILE in "$1"/*.asciidoc; do

    readarray -t PROBLEMS < <(grep -nE '^=+ .*\+.+\+.*$' "$BOOK_FILE")

    if [[ $? -eq 0 ]] && [[ ${#PROBLEMS[@]} -gt 0 ]]; then

        for PROBLEM in "${PROBLEMS[@]}"; do
            printf "%s:%s\n" "$BOOK_FILE" "$PROBLEM"
        done

        RC=1
    fi
done

exit $RC
