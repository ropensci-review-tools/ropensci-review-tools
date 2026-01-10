# roreviewapi

<!-- badges: start -->

[![R build
status](https://github.com/ropensci-review-tools/roreviewapi/workflows/R-CMD-check/badge.svg)](https://github.com/ropensci-review-tools/roreviewapi/actions?query=workflow%3AR-CMD-check)
[![Project Status:
Concept](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
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
<a href="https://github.com/ropensci-review-tools/roreviewapi/commits?author=mpadge">mpadge</a>
</td>
<td align="center">
<a href="https://github.com/maelle">
<img src="https://avatars.githubusercontent.com/u/8360597?v=4" width="100px;" alt=""/>
</a><br>
<a href="https://github.com/ropensci-review-tools/roreviewapi/commits?author=maelle">maelle</a>
</td>
<td align="center">
<a href="https://github.com/sckott">
<img src="https://avatars.githubusercontent.com/u/577668?v=4" width="100px;" alt=""/>
</a><br>
<a href="https://github.com/ropensci-review-tools/roreviewapi/commits?author=sckott">sckott</a>
</td>
<td align="center">
<a href="https://github.com/noamross">
<img src="https://avatars.githubusercontent.com/u/571752?v=4" width="100px;" alt=""/>
</a><br>
<a href="https://github.com/ropensci-review-tools/roreviewapi/commits?author=noamross">noamross</a>
</td>
</tr>

</table>


### Issue Authors

<table>

<tr>
<td align="center">
<a href="https://github.com/xuanxu">
<img src="https://avatars.githubusercontent.com/u/6528?u=415877b00c554982144cb6708028656e8c9ec8e2&v=4" width="100px;" alt=""/>
</a><br>
<a href="https://github.com/ropensci-review-tools/roreviewapi/issues?q=is%3Aissue+author%3Axuanxu">xuanxu</a>
</td>
</tr>

</table>


### Issue Contributors

<table>

<tr>
<td align="center">
<a href="https://github.com/gaborcsardi">
<img src="https://avatars.githubusercontent.com/u/660288?u=677db9b09ed7b9ca76a2fc24622a9ca433ce05d5&v=4" width="100px;" alt=""/>
</a><br>
<a href="https://github.com/ropensci-review-tools/roreviewapi/issues?q=is%3Aissue+commenter%3Agaborcsardi">gaborcsardi</a>
</td>
<td align="center">
<a href="https://github.com/wlandau">
<img src="https://avatars.githubusercontent.com/u/1580860?u=6ed1edc717e0853259312206ae59a3aa81fe3bbc&v=4" width="100px;" alt=""/>
</a><br>
<a href="https://github.com/ropensci-review-tools/roreviewapi/issues?q=is%3Aissue+commenter%3Awlandau">wlandau</a>
</td>
<td align="center">
<a href="https://github.com/wlandau-lilly">
<img src="https://avatars.githubusercontent.com/u/22958003?u=588673163e201f2f908ba75190a2d88d3971fa9e&v=4" width="100px;" alt=""/>
</a><br>
<a href="https://github.com/ropensci-review-tools/roreviewapi/issues?q=is%3Aissue+commenter%3Awlandau-lilly">wlandau-lilly</a>
</td>
<td align="center">
<a href="https://github.com/adamhsparks">
<img src="https://avatars.githubusercontent.com/u/3195906?u=ff1ca92ae028fe7eb18d006f92cb8a725625e69c&v=4" width="100px;" alt=""/>
</a><br>
<a href="https://github.com/ropensci-review-tools/roreviewapi/issues?q=is%3Aissue+commenter%3Aadamhsparks">adamhsparks</a>
</td>
<td align="center">
<a href="https://github.com/s3alfisc">
<img src="https://avatars.githubusercontent.com/u/19531450?u=26be80705a31079d973246c98bf3b26d9131e7d3&v=4" width="100px;" alt=""/>
</a><br>
<a href="https://github.com/ropensci-review-tools/roreviewapi/issues?q=is%3Aissue+commenter%3As3alfisc">s3alfisc</a>
</td>
</tr>

</table>

<!-- markdownlint-enable -->
<!-- prettier-ignore-end -->
<!-- ALL-CONTRIBUTORS-LIST:END -->

## Functions

```{toctree}
:maxdepth: 1

functions/check_cache.md
functions/check_issue_template.md
functions/collate_editor_check.md
functions/dl_gh_repo.md
functions/editor_check.md
functions/get_branch_from_url.md
functions/get_subdir_from_url.md
functions/is_user_authorized.md
functions/pkgrep_install_deps.md
functions/post_to_issue.md
functions/push_to_gh_pages.md
functions/readme_badge.md
functions/readme_has_peer_review_badge.md
functions/roreviewapi-package.md
functions/serve_api.md
functions/srr_counts_from_report.md
functions/srr_counts_summary.md
functions/srr_counts.md
functions/stats_badge.md
functions/stdout_stderr_cache.md
functions/symbol_crs.md
functions/symbol_tck.md
functions/url_is_r_pkg.md
```

## Vignettes

```{toctree}
:maxdepth: 1

vignettes/debugging.md
vignettes/endpoints.md
```
