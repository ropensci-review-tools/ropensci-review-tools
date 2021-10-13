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

## Code of Conduct

Please note that this package is released with a [Contributor Code of
Conduct](https://ropensci.org/code-of-conduct/). By contributing to this
project, you agree to abide by its terms.

## Functions

```eval_rst
.. toctree::
   :maxdepth: 1

   functions/check_cache.md
   functions/check_issue_template.md
   functions/collate_editor_check.md
   functions/dl_gh_repo.md
   functions/editor_check.md
   functions/file_pkgcheck_issue.md
   functions/pkgrep_install_deps.md
   functions/post_to_issue.md
   functions/push_to_gh_pages.md
   functions/roreviewapi-package.md
   functions/serve_api.md
   functions/stats_badge.md
   functions/stdout_stderr_cache.md
   functions/symbol_crs.md
   functions/symbol_tck.md
```

## Vignettes

```eval_rst
.. toctree::
   :maxdepth: 1

   vignettes/debugging.md
   vignettes/endpoints.md
```
