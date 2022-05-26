# `loc_stats`

Internal calculation of Lines-of-Code Statistics


## Description

Internal calculation of Lines-of-Code Statistics


## Usage

```r
loc_stats(path)
```


## Arguments

Argument      |Description
------------- |----------------
`path`     |     Directory to source code of package being analysed


## Value

A list of statistics for each of three directories, 'R', 'src', and
 'inst/include', each one having 5 statistics of total numbers of lines,
 numbers of empty lines, total numbers of white spaces, total numbers of
 characters, and indentation used in files in that directory.


## Seealso

Other stats:
 [`desc_stats`](#descstats) ,
 [`pkgstats_summary`](#pkgstatssummary) ,
 [`pkgstats`](#pkgstats) ,
 [`rd_stats`](#rdstats)


## Note

NA values are returned for directories which do not exist.


## Examples

```r
f <- system.file ("extdata", "pkgstats_9.9.tar.gz", package = "pkgstats")
# have to extract tarball to call function on source code:
path <- extract_tarball (f)
loc_stats (path)
```


