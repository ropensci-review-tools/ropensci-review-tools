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

The package may also be installed from locations other than GitHub, with any of
the following options:
``` r
remotes::install_git ("https://codeberg.org/ropensci-review-tools/orgmetrics")
remotes::install_git ("https://codefloe.com/ropensci-review-tools/orgmetrics")
```

## Code of Conduct

Please note that this package is released with a [Contributor Code of
Conduct](https://ropensci.org/code-of-conduct/). By contributing to this
project, you agree to abide by its terms.

## Contributors


<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->

All contributions to this project are gratefully acknowledged using the [`allcontributors` package](https://github.com/ropensci/allcontributors) following the [allcontributors](https://allcontributors.org) specification. Contributions of any kind are welcome!

### Code

<table>

<tr>
<td align="center">
<a href="https://github.com/mpadge">
<img src="https://avatars.githubusercontent.com/u/6697851?v=4" width="100px;" alt=""/>
</a><br>
<a href="https://github.com/ropensci-review-tools/orgmetrics/commits?author=mpadge">mpadge</a>
</td>
<td align="center">
<a href="https://github.com/remlapmot">
<img src="https://avatars.githubusercontent.com/u/3777473?v=4" width="100px;" alt=""/>
</a><br>
<a href="https://github.com/ropensci-review-tools/orgmetrics/commits?author=remlapmot">remlapmot</a>
</td>
</tr>

</table>


### Issues

<table>

<tr>
<td align="center">
<a href="https://github.com/noamross">
<img src="https://avatars.githubusercontent.com/u/571752?u=49b086850e1716aa25615cea39250c51e085a5d8&v=4" width="100px;" alt=""/>
</a><br>
<a href="https://github.com/ropensci-review-tools/orgmetrics/issues?q=is%3Aissue+author%3Anoamross">noamross</a>
</td>
<td align="center">
<a href="https://github.com/etiennebacher">
<img src="https://avatars.githubusercontent.com/u/52219252?u=66331618d799d2d4567ecab2812236c9928be368&v=4" width="100px;" alt=""/>
</a><br>
<a href="https://github.com/ropensci-review-tools/orgmetrics/issues?q=is%3Aissue+author%3Aetiennebacher">etiennebacher</a>
</td>
<td align="center">
<a href="https://github.com/steffilazerte">
<img src="https://avatars.githubusercontent.com/u/14676081?u=579dde6328e94bc3787c99a42f7668a71884cd13&v=4" width="100px;" alt=""/>
</a><br>
<a href="https://github.com/ropensci-review-tools/orgmetrics/issues?q=is%3Aissue+author%3Asteffilazerte">steffilazerte</a>
</td>
<td align="center">
<a href="https://github.com/katrinabrock">
<img src="https://avatars.githubusercontent.com/u/16126168?u=e088a8a9855322c737aba1d3be2269021f816778&v=4" width="100px;" alt=""/>
</a><br>
<a href="https://github.com/ropensci-review-tools/orgmetrics/issues?q=is%3Aissue+author%3Akatrinabrock">katrinabrock</a>
</td>
<td align="center">
<a href="https://github.com/TimTaylor">
<img src="https://avatars.githubusercontent.com/u/43499035?u=db4f4432cbb6c914ee30b1ebffdf1b2af1acd316&v=4" width="100px;" alt=""/>
</a><br>
<a href="https://github.com/ropensci-review-tools/orgmetrics/issues?q=is%3Aissue+author%3ATimTaylor">TimTaylor</a>
</td>
<td align="center">
<a href="https://github.com/zkamvar">
<img src="https://avatars.githubusercontent.com/u/3639446?v=4" width="100px;" alt=""/>
</a><br>
<a href="https://github.com/ropensci-review-tools/orgmetrics/issues?q=is%3Aissue+author%3Azkamvar">zkamvar</a>
</td>
</tr>

</table>

<!-- markdownlint-enable -->
<!-- prettier-ignore-end -->
<!-- ALL-CONTRIBUTORS-LIST:END -->

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
