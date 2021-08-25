INDEX=docs/_build/html/index

all: grab build

grab:
	Rscript pkgdocs-script.R

build:
	cd docs;	\
	make html;	\
	cd ..

open: $(INDEX).html
	xdg-open $(INDEX).html &

clean:
	rm -rf docs/autotest* docs/pkgcheck* docs/pkgstats* docs/roreviewapi* docs/srr*; \
	cd docs;	\
	make clean;	\
	cd ..

count:
	find * -type f | wc -l
