# `desc_stats`

Statistics from DESCRIPTION files


## Description

Statistics from DESCRIPTION files


## Usage

```r
desc_stats(path)
```


## Arguments

Argument      |Description
------------- |----------------
`path`     |     Directory to package being analysed


## Seealso

Other stats:
 [`loc_stats`](#locstats) ,
 [`pkgstats_summary`](#pkgstatssummary) ,
 [`pkgstats`](#pkgstats) ,
 [`rd_stats`](#rdstats)


## Examples

```r
f <- system.file ("extdata", "pkgstats_9.9.tar.gz", package = "pkgstats")
path <- extract_tarball (f)
desc_stats (path)
```


