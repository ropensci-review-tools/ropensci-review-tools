
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

The website can be locally previewed by running `quarto preview` in the
`quarto` directory, using the locally-installed version of the "dashboard"
package. This means that any updates to the package itself will only be
rendered on the quarto website once those changes have been pushed and the
package locally re-installed using the `install_github` command above.

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
