# `dl_pkgstats_data`

Download latest version of 'pkgstats' data


## Description

Download latest version of 'pkgstats' data


## Usage

```r
dl_pkgstats_data(current = TRUE, path = tempdir(), quiet = FALSE)
```


## Arguments

Argument      |Description
------------- |----------------
`current`     |     If 'FALSE', download data for all CRAN packages ever released, otherwise (default) download data only for current CRAN packages.
`path`     |     Local path to download file.
`quiet`     |     If `FALSE` , display progress information on screen.


## Value

(Invisibly) A `data.frame` of `pkgstats` results, one row for each
 package.


## Seealso

Other archive:
 [`pkgstats_fns_from_archive`](#pkgstatsfnsfromarchive) ,
 [`pkgstats_from_archive`](#pkgstatsfromarchive)


