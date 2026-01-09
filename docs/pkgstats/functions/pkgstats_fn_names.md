# Extract names of all functions for one R package

## Description

Extract names of all functions for one R package

## Usage

```r
pkgstats_fn_names(path)
```

## Arguments

* `path`: Either a path to a local source repository, or a local '.tar.gz'
file, containing code for an R package.

## Seealso

Other misc: 
`[extract_tarball](extract_tarball)()`

## Concept

misc

## Value

A `data.frame` with three columns:

* package: Name of package
* version: Package version
* fn_name: Name of function

## Examples

```r
# 'path' can be path to a package tarball:
f <- system.file ("extdata", "pkgstats_9.9.tar.gz", package = "pkgstats")
path <- extract_tarball (f)
s <- pkgstats_fn_names (path)
```


