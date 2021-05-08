# Script for Linting / Working with Atlas

This folder contains a few scripts I'm using to validate my files at least a little bit before pushing to Atlas.

## atlas-lint.sh

Checks that all referenced files in `atlas.json` are available.

Must be called with the root book folder as first argument.

Requires `jq`.

## figures-lint.sh

Checks all referenced figures to be available.

Must be called with the root book folder as first argument.

## figures-convert.sh

I use ASCII-based figures while working on the draft, but I convert them to PNGs.
This way, I can reference them correctly as figures.

Must be called with the figures folder as first argument.

Requires `convert` (ImageMagick).

## cross-ref-lint.sh

Validates that all used cross-references are found.

Must be called with the figures folder as first argument.

## Makefile

Glueing it all together.

The scripts should reside in a folder called `scripts` and the Makefile is supposed to be at root level.
