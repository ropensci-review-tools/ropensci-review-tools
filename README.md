
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

    - `sphinx`, `myst-parser`, `sphinx-rtd-theme`

1. Clone the repositories list in "packages.md" from this GitHub organization
   in a single directory

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

## Updating

This site can be updated in response to any changes in any of the respective
packages by simply running `make`. All changes should then be listed in `git
status`, with the exception of any new files which have been added, and are not
yet tracked by git. It is thus good practice to either:

1. Run `make clean` first prior to `make`, and then `git add` everything in all
   sub-directories of `docs`; or
2. Using `git clean -n` to list files not tracked by git, and add any `*.md`
   files listed in any sub-folders of `docs.

## Adding new packages

New packages in the [`ropensci-review-tools` GitHub
organization](https://github.com/ropensci-review-tools) can be added to
readthedocs site with the following modifications:

1. Add the package name to [the `packages.md`
   file](https://github.com/ropensci-review-tools/ropensci-review-tools/blob/main/packages.md)
   (and ensure that the repository to be added is locally cloned to the same
   root directory as this, and all other, repositories).
2. Run `make` to automatically compile the package documentation into the
   `/docs` folder of this repository.
3. Add the newly compiled sub-folder of `/docs` to the git tree, commit the
   files, push to GitHub, and documentation for the new package will be
   added to this readthedocs site.

