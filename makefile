INDEX=docs/_build/html/index
SCRIPT=pkgdocs-script

all: ## The default 'make' command = grab + build
	make grab; make build

grab: ## Grab all files from the R packages by calling 'pkgdocs-script'
	Rscript $(SCRIPT).R

build: ## readthedocs 'make html' command
	cd docs;	\
	make html;	\
	cd ..

open: $(INDEX).html ## Open the main 'html' page
	xdg-open $(INDEX).html &

clean: ## Run readthedocs 'make clean' + clean all 'grab' targets (R pkg files)
	rm -rf docs/autotest* docs/pkgcheck* docs/pkgstats* docs/roreviewapi* docs/srr*; \
	cd docs;	\
	make clean;	\
	cd ..

count: ## count some stuff
	find * -type f | wc -l

# Lots of variants at:
# https://gist.github.com/prwhite/8168133
# https://stackoverflow.com/questions/35730218/how-to-automatically-generate-a-makefile-help-command

help: ## Show this help
		@egrep '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
	
# Phony targets:
.PHONY: all
.PHONY: grab
.PHONY: build
.PHONY: open
.PHONY: clean
.PHONY: count
.PHONY: help
