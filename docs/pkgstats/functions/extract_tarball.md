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


## Examples

```r
tarball <- "magrittr_2.0.1.tar.gz"
u <- paste0 (
"https://cran.r-project.org/src/contrib/",
tarball
)
f <- file.path (tempdir (), tarball)
download.file (u, f)
path <- extract_tarball (f)
```


