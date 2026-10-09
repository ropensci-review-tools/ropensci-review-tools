# Generating and updating `pkgstats` data.
Mark Padgham
2026-10-09

The `pkgstats` package is also intended to compare the statistics of an
R package to equivalent statistics from all R packages that are, or ever
were, on CRAN. For these comparisons, the package also includes
developer-only functions to generate `pkgstats_summary()` results.

These results are uploaded with [GitHub release version
0.1.6](https://github.com/ropensci-review-tools/pkgstats/releases/tag/v0.1.6).
A [GitHub
workflow](https://github.com/ropensci-review-tools/pkgstats/blob/main/.github/workflows/update.yaml)
calls the update function every day.

<div class="admonition warning">

<div class="admonition-title">

Warning

</div>

This workflow is automatically disabled after 60 days of inactivity on
the repository.

</div>

There are two main ways the data can be manually updated on a local
machine.

## 1. Direct calls of the update functions

The easiest way is to ensure the latest data have been cached (by
calling `dl_pkgstats_data()`). Then call `pkgstats_update()`.

That function will download any updates from CRAN and rOpenSci which are
not present in the latest version, and extract all `pkgstats` from
those. Package tarballs are downloaded in to the temporary directory of
the current R session, and so are automatically removed afterwards.

If enormous numbers of packages need to be updated, any bugs in package
structure – which do happen! – may cause that function to fail. Even
though every effort has been made to ensure that it will recover from
every kind of error encountered thus far, R packages can break things in
unexpected ways. For this reason, the second approach is recommended if
at all possible, and it will always enable complete recovery without
having to repeatedly download new packages.

## 2. Update from a local CRAN mirror

Functions to clone local mirrors of both CRAN and rOpenSci are in the
[`ropensci-review-tools/mirrors`
repository](https://github.com/ropensci-review-tools/mirrors). The
rOpenSci mirror is currently (Oct 2026) around 13GB, while CRAN is 160GB
including all archived versions of all packages. These mirrors can be
created or updated by calling `bash mirror-ropensci.sh` or
`bash mirror-cran.sh`.

Data can then be updated by passing those local-mirror paths to
`pkgstats_from_archive()`.

<div class="admonition note">

<div class="admonition-title">

Data upload

</div>

The `pkgstats_update()` function will automatically upload data to the
[GitHub
release](https://github.com/ropensci-review-tools/pkgstats/releases/tag/v0.1.6).
The `pkgstats_from_archive()` returns the data without uploading, so you
then have to do that manually – either via
[`piggyyback`](https://docs.ropensci.org/piggyback), or through the
GitHub website.

</div>
