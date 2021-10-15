# `pkgstats`

Collates statistics from one local tarball


## Description

Collates statistics from one local tarball


## Usage

```r
pkgstats(path = ".")
```


## Arguments

Argument      |Description
------------- |----------------
`path`     |     Either a path to a local source repository, or a local '.tar.gz' file containing code for an R package.


## Value

List of statistics


## Seealso

Other stats:
 [`desc_stats`](#descstats) ,
 [`loc_stats`](#locstats) ,
 [`pkgstats_summary`](#pkgstatssummary) ,
 [`rd_stats`](#rdstats)


## Examples

```r
tarball <- "magrittr_2.0.1.tar.gz"
u <- paste0 ("https://cran.r-project.org/src/contrib/",
tarball)
f <- file.path (tempdir (), tarball)
download.file (u, f)
pkgstats (f)
```


