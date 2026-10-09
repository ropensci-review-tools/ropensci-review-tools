
# pkgstats

Maintenance of `pkgstats` package is now described in the [`pkgstats-data`
vignette](https://docs.ropensci.org/pkgstats/articles/pkgstats-data.html).
The major maintenance issue is the daily updates of `pkgstats` from all CRAN
and rOpenSci packages. These data are updated automatically on a [GitHub
action](https://github.com/ropensci-review-tools/pkgstats/blob/main/.github/workflows/update.yaml).
It's important to keep an eye on this action, as it will be automatically
suspended after 60 days of inactivity in the repository. The
[vignette](https://docs.ropensci.org/pkgstats/articles/pkgstats-data.html)
describes procedures for manually updating the data if and when necessary.
