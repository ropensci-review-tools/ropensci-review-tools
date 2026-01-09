# Analyse statistics of one R package

## Description

Analyse statistics of one R package

## Usage

```r
pkgstats(path = ".")
```

## Arguments

* `path`: Either a path to a local source repository, or a local '.tar.gz'
file, containing code for an R package.

## Seealso

Other stats: 
`[desc_stats](desc_stats)()`,
`[loc_stats](loc_stats)()`,
`[pkgstats_summary](pkgstats_summary)()`,
`[rd_stats](rd_stats)()`

## Concept

stats

## Value

List of statistics and data on function call networks (or object
relationships in other languages). Includes the following components:

1. loc: Summary of Lines-of-Code in all package directories
1. vignettes: Numbers of vignettes and "demo" files
1. data_stats: Statistics of numbers and sizes of package data files
1. desc: Summary of contents of 'DESCRIPTION' file
1. translations: List of translations into other (human) languages
(where provides)
1. objects: A `data.frame` of all functions in R, and all other
objects (functions, classes, structures, global variables, and more) in all
other languages
1. network: A `data.frame` of object references within and between all
languages; in R these are function calls, but may be more abstract in other
languages.
1. external_calls: A `data.frame` of all calls make to all functions
from all other R packages, including base and recommended as well as
contributed packages.

## Examples

```r
# 'path' can be path to a package tarball:
f <- system.file ("extdata", "pkgstats_9.9.tar.gz", package = "pkgstats")
if (ctags_test (noerror = TRUE)) withAutoprint({ # examplesIf
s <- pkgstats (f)
# or to a source directory:
path <- extract_tarball (f)
s <- pkgstats (path)
}) # examplesIf
```


