
# rOpenSci Software Review Dashboard

This repository contains the source code for [rOpenSci's *Software Review
Dashboard*](https://ropensci-review-tools.github.io/dashboard). This includes
both a local R package named "dashboard", and a [quarto
directory](https://github.com/ropensci-review-tools/dashboard/tree/main/quarto)
which includes the source files for the website. This README is intended only
for developers. Anybody solely interested in the dashboard should [head
straight to the website](https://ropensci-review-tools.github.io/dashboard).

## renv and local usage

The quarto website uses [`renv`](https://rstudio.github.io/renv/) to manage
package dependencies in the [GitHub
workflow](https://github.com/ropensci-review-tools/dashboard/blob/main/.github/workflows/publish.yaml).
The environment will be automatically built the first time R is started in the
root directory of this repository. This environment will nevertheless not
include the package itself, and so the package needs to be manually installed
using:

``` r
remotes::install_github ("ropensci-review-tools/dashboard")
```

## makefile commands

This repository includes [a
makefile](https://github.com/ropensci-review-tools/dashboard/blob/main/makefile)
with several commands. Typing `make` in the root directory will display all
available options:

```bash
Usage: make [target]
build               'quarto build' command
check               Run `R CMD check` on package
dev                 alias for 'serve'
doc                 Update package documentation with `roxygen2`
help                Show this help
recache             Start local quarto server with '--cache-refresh' to force cache refresh
renv-snapshot       Update the 'renv.lock' file, generally run after `renv-update`
renv-update         Update 'renv' dependencies to latest versions
serve               Start local quarto server
```

The last of these commands runs the `quarto dev` command in the `quarto`
directory, and will by default open a local server in the default web browser.
The resultant dashboard will use functionality of the locally-installed version
of the "dashboard" package. This means that any updates to the package itself
will only be rendered on the locally-served website once those changes have
been pushed and the package locally re-installed using the `install_github`
command above.

## Maintenance

The [`publish` workflow in this
repository](https://github.com/ropensci-review-tools/dashboard/blob/main/.github/workflows/publish.yaml)
requires a GitHub token stored as an environment variable named `MY_GH_TOKEN`.
This token needs full write access to this organization (which the default
workflow token does not have), as well as read access to the `ropensci`
organization. The easiest way to obtain, set, or re-set this token is thus to
use a personal token from somebody with "owner" rights both here and in the
`ropensci` organization.

## Functions

```{toctree}
:maxdepth: 1

functions/add_editor_airtable_data.md
functions/dashboard-package.md
functions/editor_status.md
functions/editor_vacation_status.md
functions/review_history.md
functions/review_status.md
```
