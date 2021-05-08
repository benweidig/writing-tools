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

IDS=()
CROSS_REFS=()

for BOOK_FILE in "$1"/*.asciidoc; do

    BASENAME=$(basename "$BOOK_FILE")

    mapfile -t FILE_IDS < <(sed -n 's/\[\[\(.*\)\]\]/\1/p' "$BOOK_FILE")
    IDS+=("${FILE_IDS[@]}")

    mapfile -t FILE_CROSS_REFS < <(sed -n 's/.*<<\(.*\)>>.*/\1/p' "$BOOK_FILE")
    for CROSS_REF in "${FILE_CROSS_REFS[@]}"; do
        CROSS_REFS+=("$BASENAME:$CROSS_REF")
    done
done

UNIQUE_IDS=$(tr ' ' '\n' <<< "${IDS[@]}" | sort -u | tr '\n' ' ')
UNIQUE_CROSS_REFS=$(tr ' ' '\n' <<< "${CROSS_REFS[@]}" | sort -u | tr '\n' ' ')

RC=0

for CROSS_REF in $UNIQUE_CROSS_REFS; do
    ID=${CROSS_REF##*:}
    BOOK_FILE=${CROSS_REF%:*}

    # shellcheck disable=SC2076,SC2199
    if [[ ! " ${UNIQUE_IDS[@]} " =~ " ${ID} " ]]; then
        >&2 printf "%s: Unknown id '%s'\n" "$BOOK_FILE" "$ID"
        RC=1
    fi
done

exit $RC
