# Update pkgmatch corpus data on GitHub

## Description

This function is intended for internal rOpenSci use only. Usage
by any unauthorized users will error and have no effect unless run with
`upload = FALSE`, in which case updated data will be created in the
sub-directory "pkgmatch-results" of R's current temporary directory. This
updating may take a very long time!
The function does not update the BioConductor data. Because those are fixed
to specific BioConductor releases, they are only updated manually with the
internal `pkgmatch_generate_bioc()` function.
Note that this function is categorically different from
[pkgmatch_update_cache](pkgmatch_update_cache). This function updates the internal data used
by the `pkgmatch` package, and should only ever be run by package
maintainers. The [pkgmatch_update_cache](pkgmatch_update_cache) downloads the latest versions
of these data to a local cache for use in this package.

## Usage

```r
pkgmatch_update_data(
  upload = TRUE,
  local_cran_mirror = NULL,
  local_ropensci_mirror = NULL
)
```

## Arguments

* `upload`: If `TRUE`, upload updated results to GitHub release.
* `local_cran_mirror`: Optional path to a local directory with full CRAN
mirror. If specified, data will use packages from this local source for
updating. Default behaviour if not specified is to download new packages
into tempdir, and delete once data have been updated.
* `local_ropensci_mirror`: Optional path to a local directory with full
rOpenSci mirror. If specified, data will use repositories from this local
source for updating. Default behaviour if not specified is to clone new
repositories into tempdir, and delete once data have been updated.

## Concept

data

## Value

Local path to directory containing updated results.

## Examples

```r
pkgmatch_update_data (upload = FALSEE)
```


