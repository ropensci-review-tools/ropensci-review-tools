# roreviewapi

<!-- badges: start -->

[![R build
status](https://github.com/ropensci-review-tools/roreviewapi/workflows/R-CMD-check/badge.svg)](https://github.com/ropensci-review-tools/roreviewapi/actions?query=workflow%3AR-CMD-check)
[![Project Status:
Concept](https://www.repostatus.org/badges/latest/concept.svg)](https://www.repostatus.org/#concept)
<!-- badges: end -->

Plumber API to generate reports on package structure and function for
the [`@ropensci-review-bot`](https://github.com/ropensci-review-bot).
The package is not intended for general use, and these documents are
primarily intended for maintainers of this package, although they may
serve as useful templates for similar endeavours. Please contact us if
you have any questions.

Uses functionality provided by the
[`pkgcheck`](https://github.com/ropensci-review-tools/pkgcheck) and
[`pkgstats`](https://github.com/ropensci-review-tools/pkgstats)
packages. This suite of three packages requires a few system installs,
two for [`pkgstats`](https://github.com/ropensci-review-tools/pkgstats)
of [`ctags`](https://ctags.io) and [GNU
`global`](https://www.gnu.org/software/global/). Procedures to install
these libraries on various operating systems are described in the
[`pkgstats` package](https://docs.ropensci.org/pkgstats). This package
itself also requires both the [GitHub command-line-interface (cli),
`gh`](https://cli.github.com/) and
[`dos2unix`](https://sourceforge.net/projects/dos2unix/).

A local GitHub token also needs to be stored as an environment variable
named `GITHUB_TOKEN`, and not `GITHUB_PAT` or anything else; the `gh`
cli only recognises the former name.

The package also works by locally caching previously analysed packages,
in a `pkgcheck` subdirectory of the location determined by

``` r
rappdirs::user_cache_dir()
```

You may manually erase the contents of this subdirectory at any time at
no risk.

## Dockerfile

The server associated with this package can be built by cloning this
repository, and modifying the associated
[`Dockerfile`](https://github.com/ropensci-review-tools/roreviewapi/blob/master/Dockerfile)
by inserting a GitHub token, and associated `git config` options.

## Functions

```eval_rst
.. toctree::
   :maxdepth: 1

   roreviewapi/check_cache.md
   roreviewapi/dl_gh_repo.md
   roreviewapi/editor_check.md
   roreviewapi/pkgrep_install_deps.md
   roreviewapi/post_to_issue.md
   roreviewapi/push_to_gh_pages.md
   roreviewapi/roreviewapi-package.md
   roreviewapi/serve_api.md
   roreviewapi/stats_badge.md
   roreviewapi/stdout_stderr_cache.md
   roreviewapi/symbol_crs.md
   roreviewapi/symbol_tck.md
```