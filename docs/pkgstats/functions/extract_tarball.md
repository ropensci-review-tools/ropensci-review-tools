# `extract_tarball`

Extract tarball of a package into temp directory and return path to extracted
 package


## Description

Extract tarball of a package into temp directory and return path to extracted
 package


## Usage

```r
extract_tarball(tarball)
```


## Arguments

Argument      |Description
------------- |----------------
`tarball`     |     Full path to local tarball of an R package.


## Value

Path to extracted version of package (in `tempdir()` ).


## Seealso

Other misc:
 [`pkgstats_fn_names`](#pkgstatsfnnames)


## Examples

```r
f <- system.file ("extdata", "pkgstats_9.9.tar.gz", package = "pkgstats")
path <- extract_tarball (f)
```


