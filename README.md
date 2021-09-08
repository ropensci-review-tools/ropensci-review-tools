
# ropensci-review-tools


This repository is used to build and store the central documentation for the
`ropensci-review-tools` organization, which contains a suite of tools developed
and used by rOpenSci to support their software peer-review processes. The
documentation uses [`readthedocs`](https://readthedocs.org), and is hosted at
[`ropensci-review-tools.readthedocs.io`](https://ropensci-review-tools.readthedocs.io/).

## How the site is built

Most of you should just head straight to
[`ropensci-review-tools.readthedocs.io`](https://ropensci-review-tools.readthedocs.io/).
The rest of this is technical detail on how that site is actually created. It
will work only on Linux-type systems. The
[`readthedocs`](https://readthedocs.org) site bundles documentation from all
repositories within the `ropensci-review-tools` organisation, a process
executed by the single [`pkgdocs-script.R`
file](https://github.com/ropensci-review-tools/ropensci-review-tools/blob/main/pkgdocs-script.R).
The [`readthedocs`](https://readthedocs.org) files all reside in the `docs`
folder of this repository, and can be recreated anew with the following steps:

1. Install the following python packages (`pip install` or equivalent):

    - `sphinx`, `myst-parser`, `sphinx-rtd-theme`, `recommonmark`

1. Clone the following repositories from this GitHub organization in a single directory:

    - [`autotest`](https://github.com/ropensci-review-tools/autotest)
    - [`pkgcheck`](https://github.com/ropensci-review-tools/pkgcheck)
    - [`pkgstats`](https://github.com/ropensci-review-tools/pkgstats)
    - [`roreviewapi`](https://github.com/ropensci-review-tools/roreviewapi)
    - [`ropensci-review-tools`](https://github.com/ropensci-review-tools/ropensci-review-tools)
    - [`srr`](https://github.com/ropensci-review-tools/srr)

2. Within the directory of this repository (`cd ropensci-review-tools`), run
   `make clean` to remove all of the actual documentation files, leaving only
   the [`readthedocs`](https://readthedocs.org) configuration files. That
   should reduce 300 individual files down to just over ten. (There's even a
   `make count` to check those numbers).

4. Type `make` to rebuild everything.

5. Finally `make open` will open the locally-generated documentation in your default web browser.

Check out the contents of the
[`makefile`](https://github.com/ropensci-review-tools/ropensci-review-tools/blob/main/makefile)
to see how it works, or just type `make help`:

``` bash
$ make help
all                  The default `make` command = grab + build
build                readthedocs 'make html' command
clean                Run readthedocs 'make clean' + clean all 'grab' targets (R pkg files)
count                count some stuff
grab                 Grab all files from the R packages by calling 'pkgdocs-script'
help                 Show this help
open                 Open the main 'html' page
```
