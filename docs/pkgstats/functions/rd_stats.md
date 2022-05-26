# `rd_stats`

Stats from '.Rd' files


## Description

Stats from '.Rd' files


## Usage

```r
rd_stats(path)
```


## Arguments

Argument      |Description
------------- |----------------
`path`     |     Directory to source code of package being analysed


## Seealso

Other stats:
 [`desc_stats`](#descstats) ,
 [`loc_stats`](#locstats) ,
 [`pkgstats_summary`](#pkgstatssummary) ,
 [`pkgstats`](#pkgstats)


## Examples

```r
f <- system.file ("extdata", "pkgstats_9.9.tar.gz", package = "pkgstats")
# have to extract tarball to call function on source code:
path <- extract_tarball (f)
rd_stats (path)
```


