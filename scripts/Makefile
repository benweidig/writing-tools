BOOK_FOLDER := .
FIGURES_FOLDER := figures

.PHONY: lint
lint: atlas-lint figures-lint

.PHONY: atlas-lint
atlas-lint:
	#
	# ################################################################################
	# >>> TARGET: atlas-lint
	# ################################################################################
	#
	./scripts/atlas-lint.sh ${BOOK_FOLDER}


.PHONY: figures-convert
figures-convert:
	#
	# ################################################################################
	# >>> TARGET: figures-convert
	# ################################################################################
	#
	./scripts/figures-convert.sh ${FIGURES_FOLDER}

.PHONY: figures-lint
figures-lint:
	#
	# ################################################################################
	# >>> TARGET: figures-lint
	# ################################################################################
	#
	./scripts/figures-lint.sh ${BOOK_FOLDER}
