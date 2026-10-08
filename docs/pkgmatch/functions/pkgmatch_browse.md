# Open web pages for

## Description

Open web pages for `pkgmatch` results

## Usage

```r
pkgmatch_browse(p, n = NULL)
```

## Arguments

* `p`: A `pkgmatch` object returned from
[pkgmatch_similar_pkgs](pkgmatch_similar_pkgs).
* `n`: Number of top-matching entries which should be opened. Defaults to
the value passed to the main functions.

## Seealso

Other utils:
`[generate_pkgmatch_example_data()](generate_pkgmatch_example_data)`,
`[head.pkgmatch()](head.pkgmatch)`,
`[pkgmatch_load_data()](pkgmatch_load_data)`,
`[pkgmatch_update_cache()](pkgmatch_update_cache)`,
`[print.pkgmatch()](print.pkgmatch)`

## Concept

utils

## Value

(Invisibly) A named vector of integers, with 0 for all pages able to
be successfully opened, and 1 otherwise.

## Examples

```r
input <- "genomics and transcriptomics sequence data"

p <- pkgmatch_similar_pkgs (input, corpus = "ropensci")


pkgmatch_browse (p) # Open main package pages on rOpenSci


p <- pkgmatch_similar_pkgs (input, corpus = "cran")


pkgmatch_browse (p) # Open main package pages on CRAN
```


