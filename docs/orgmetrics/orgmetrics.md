<!-- badges: start -->

[![R build
status](https://github.com/ropensci-review-tools/orgmetrics/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/ropensci-review-tools/orgmetrics/actions?query=workflow%3AR-CMD-check.yaml)
[![codecov](https://codecov.io/gh/ropensci-review-tools/orgmetrics/branch/main/graph/badge.svg)](https://app.codecov.io/gh/ropensci-review-tools/orgmetrics)
[![Project Status:
Active](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
<!-- badges: end -->

# orgmetrics

Metrics for your GitHub organization, collated from applying accompanying
[`repometrics` package](https://docs.ropensci.org/repometrics/)
across all organization repositories, enhanced with additional
organization-level data. Live demonstration for the entire rOpenSci organization currently at
[ropensci-review-tools.github.io/orgmetrics-ropensci/](https://ropensci-review-tools.github.io/orgmetrics-ropensci/).

## How?

### Installation

First, install the package either via [`r-universe`](https://r-universe.dev):

``` r
options (repos = c (
    ropenscireviewtools = "https://ropensci-review-tools.r-universe.dev",
    CRAN = "https://cloud.r-project.org"
))
install.packages ("orgmetrics")
```
or directly from GitHub with one of these two lines:

``` r
remotes::install_github ("ropensci-review-tools/orgmetrics")
pak::pkg_install ("ropensci-review-tools/orgmetrics")
```

## Code of Conduct

Please note that this package is released with a [Contributor Code of
Conduct](https://ropensci.org/code-of-conduct/). By contributing to this
project, you agree to abide by its terms.

## Functions

```{toctree}
:maxdepth: 1

functions/clone_gh_org_repos.md
functions/om_packages_json.md
functions/orgmetrics_dashboard.md
functions/orgmetrics_deploy_r_univ.md
functions/orgmetrics_generate_yaml.md
functions/orgmetrics-package.md
```
