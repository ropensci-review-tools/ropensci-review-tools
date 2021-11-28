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

List of statistics and data on function call networks (or object
 relationships in other languages). Includes the following components:
  

*  list("loc: ") list("Summary of Lines-of-Code in all package directories")  

*  list("vignettes: ") list("Numbers of vignettes and \"demo\" files")  

*  list("data_stats: ") list("Statistics of numbers and sizes of package data files")  

*  list("desc: ") list("Summary of contents of 'DESCRIPTION' file")  

*  list("translations: ") list("List of translations into other (human) languages\n", "(where provides)")  

*  list("objects: ") list("A ", list("data.frame"), " of all functions in R, and all other\n", "objects (functions, classes, structures, global variables, and more) in all\n", "other languages")  

*  list("network: ") list("A ", list("data.frame"), " of object references within and between all\n", "languages; in R these are function calls, but may be more abstract in other\n", "languages.")  

*  list("external_calls: ") list("A ", list("data.frame"), " of all calls make to all functions\n", "from all other R packages, including base and recommended as well as\n", "contributed packages.")


## Seealso

Other stats:
 [`desc_stats`](#descstats) ,
 [`loc_stats`](#locstats) ,
 [`pkgstats_summary`](#pkgstatssummary) ,
 [`rd_stats`](#rdstats)


## Examples

```r
# 'path' can be path to a package tarball:
f <- system.file ("extdata", "pkgstats_9.9.tar.gz", package = "pkgstats")
s <- pkgstats (f)
# or to a source directory:
path <- extract_tarball (f)
s <- pkgstats (path)
```


