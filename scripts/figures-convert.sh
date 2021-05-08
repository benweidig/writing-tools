#!/usr/bin/env bash

# ImageMagick Policy must be changed for this script to work:
# /etc/ImageMagick-6/policy.xml
# Comment out: <policy domain="path" rights="none" pattern="@*"/>

# SETTINGS
FONT="Courier"
FONT_SIZE="14"

if [[ -n "$DEBUG" ]]; then
    set -x
fi

command -v "convert" > /dev/null 2>&1
# shellcheck disable=SC2181
if [[ $? -ne 0 ]]; then
    >&2 printf 'Imagemagick (convert) is not available.\n'
    exit 1
fi

set -e

if [[ ! "$#" -eq 1 ]]; then
    >&2 printf "1 argument must be provided (figure folder), but found '%s'.\n" "$#"
    exit 1
fi

for ASCII_FILE in "$1"/*.txt; do
    BASENAME=$(basename "$ASCII_FILE")
    TARGET_PATH="$1/${BASENAME%.txt}.png"

    printf "Converting '%s'\n" "$BASENAME"

    convert \
        -size 1024 \
        -trim \
        -bordercolor white \
        -border $FONT_SIZE \
        -font $FONT \
        -pointsize $FONT_SIZE \
        -fill black \
        caption:"@$ASCII_FILE" \
        "$TARGET_PATH"
done
