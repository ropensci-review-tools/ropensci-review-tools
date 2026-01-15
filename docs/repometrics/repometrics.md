<!-- badges: start -->

[![R build
status](https://github.com/ropensci-review-tools/repometrics/workflows/R-CMD-check/badge.svg)](https://github.com/ropensci-review-tools/repometrics/actions?query=workflow%3AR-CMD-check)
[![codecov](https://codecov.io/gh/ropensci-review-tools/repometrics/branch/main/graph/badge.svg)](https://app.codecov.io/gh/ropensci-review-tools/repometrics)
[![Project Status:
Active](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
<!-- badges: end -->

# repometrics

Metrics for your code repository. A single function collates a wealth of data
from commit histories and GitHub interactions, converts it all to standardised
metrics, and displays the result as a single, interactive dashboard of your
repository.

## How?

### Installation

First, install the package either via [`r-universe`](https://r-universe.dev):

``` r
options (repos = c (
    ropenscireviewtools = "https://ropensci-review-tools.r-universe.dev",
    CRAN = "https://cloud.r-project.org"
))
install.packages ("repometrics")
```
or directly from GitHub with one of these two lines:

``` r
remotes::install_github ("ropensci-review-tools/repometrics")
pak::pkg_install ("ropensci-review-tools/repometrics")
```

### Use

The `repometrics` package has one main function for collating all data for a
repository:
[`repometrics_data()`](https://docs.ropensci.org/repometrics/reference/repometrics_data.html).
This function has one main parameter, specifying the `path` to a local
directory containing an R package.

``` r
data <- repometrics_data (path)
```

A `repometrics` dashboard for the repository can then be launched by passing
those `data` to [the `repometrics_dashboard()`
function](https://docs.ropensci.org/repometrics/reference/repometrics_dashboard.html):

``` r
repometrics_dashboard (data)
```

The dashboard will automatically open in your default browser.

## Prior Art

There are lots of tools for collating metrics of software repositories, most of
which are commercial and not open source. Notable open source tools include
those in the [github.com/chaoss organization](https://github.com/chaoss),
especially their [augur](https://github.com/chaoss/augur) and
[grimoirelab](https://github.com/chaoss/grimoirelab) tools. Both of these tools
are huge and comprehensive. Although intended to be highly configurable and
customizable, they can be difficult both to set up and to use. The [OpenSSF
Scorecard](https://github.com/ossf/scorecard) is a lightweight system focussed
on metrics of "security health".

Plus a host of semi-private and commercial offerings like
[codescene](https://codescene.com/), [SonarQube](https://www.sonarsource.com/),
[SonarGraph](https://www.hello2morrow.com/products/sonargraph),
[Teamscale](https://teamscale.com/), and [Understand](https://scitools.com/).

## Code of Conduct

Please note that this package is released with a [Contributor Code of
Conduct](https://ropensci.org/code-of-conduct/). By contributing to this
project, you agree to abide by its terms.

## Functions

```{toctree}
:maxdepth: 1

functions/repo_pkgstats_history.md
functions/repometrics_dashboard.md
functions/repometrics_data_repo.md
functions/repometrics_data_user.md
functions/repometrics_data.md
functions/repometrics-package.md
functions/rm_metrics_list.md
```

## Vignettes

```{toctree}
:maxdepth: 1

vignettes/chaoss-metrics.md
vignettes/metrics-models.md
```
