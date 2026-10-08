# Head method for 'pkgmatch' objects

## Description

Head method for 'pkgmatch' objects

## Usage

```r
# S3 method for pkgmatch
head(x, n = 5L, ...)
```

## Arguments

* `x`: Object for which head is to be printed
* `n`: Number of rows of full `pkgmatch` object to be displayed
* `...`: Not used

## Seealso

Other utils:
`[generate_pkgmatch_example_data()](generate_pkgmatch_example_data)`,
`[pkgmatch_browse()](pkgmatch_browse)`,
`[pkgmatch_load_data()](pkgmatch_load_data)`,
`[pkgmatch_update_cache()](pkgmatch_update_cache)`,
`[print.pkgmatch()](print.pkgmatch)`

## Concept

utils

## Value

A (usually) smaller version of `x`, with all columns displayed.

## Examples

```r
corpus <- "cran"
generate_pkgmatch_example_data (corpus = corpus)
input <- "Download open spatial data from NASA"
p <- pkgmatch_similar_pkgs (input, corpus = corpus)
head (p) # Shows first 5 rows of full `data.frame` object
```


