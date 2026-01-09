# Download latest version of 'pkgstats' data

## Description

Download latest version of 'pkgstats' data

## Usage

```r
dl_pkgstats_data(current = TRUE, path = tempdir(), quiet = FALSE)
```

## Arguments

* `current`: If 'FALSE', download data for all CRAN packages ever released,
otherwise (default) download data only for current CRAN packages.
* `path`: Local path to download file.
* `quiet`: If `FALSE`, display progress information on screen.

## Seealso

Other archive: 
`[pkgstats_cran_current_from_full](pkgstats_cran_current_from_full)()`,
`[pkgstats_fns_from_archive](pkgstats_fns_from_archive)()`,
`[pkgstats_fns_update](pkgstats_fns_update)()`,
`[pkgstats_from_archive](pkgstats_from_archive)()`,
`[pkgstats_update](pkgstats_update)()`

## Concept

archive

## Value

(Invisibly) A `data.frame` of `pkgstats` results, one row for each
package.


