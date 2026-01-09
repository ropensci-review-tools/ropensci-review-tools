# Update pkgstats` data on GitHub release

## Description

This function is intended for internal rOpenSci use only. Usage by any
unauthorized users will error and have no effect unless run with `upload = FALSE`, in which case updated data will be created in the sub-directory
"pkgstats-results" of R's current temporary directory.

## Usage

```r
pkgstats_update(upload = TRUE)
```

## Arguments

* `upload`: If `TRUE`, upload updated results to GitHub release.

## Seealso

Other archive: 
`[dl_pkgstats_data](dl_pkgstats_data)()`,
`[pkgstats_cran_current_from_full](pkgstats_cran_current_from_full)()`,
`[pkgstats_fns_from_archive](pkgstats_fns_from_archive)()`,
`[pkgstats_fns_update](pkgstats_fns_update)()`,
`[pkgstats_from_archive](pkgstats_from_archive)()`

## Concept

archive

## Value

Local path to directory containing updated results.


