# Identify R functions best matching a given input string

## Description

Function matching is only available for functions from the
corpora of rOpenSci or Bioconductor packages, and not for CRAN packages.

## Usage

```r
pkgmatch_similar_fns(input, corpus = "ropensci", n = 5L, browse = FALSE)
```

## Arguments

* `input`: A text string.
* `corpus`: One of "ropensci" or "bioc" (for BioConductor). It is not
possible to match functions again CRAN packages.
* `n`: When the result of this function is printed to screen, the top `n`
packages will be displayed.
* `browse`: If `TRUE`, automatically open webpages of the top `n` matches
in local browser.

## Seealso

Other main:
`[pkgmatch_similar_pkgs()](pkgmatch_similar_pkgs)`

## Concept

main

## Value

A modified `data.frame` object of class "pkgmatch". The `data.frame`has 3 columns:

1. "pkg_fn" with the name of the function in the form
"package::function";
1. "simil" with a similarity score between 0 and 1; and
1. "rank" as an integer index, with the highest rank of 1 as the first row.

The return object has a default `print` method which prints the names only
of the first 5 best matching functions; see `?print.pkgmatch` for details.

## Examples

```r
corpus <- "ropensci"
set.seed (1L)
generate_pkgmatch_example_data (corpus = corpus)
input <- "Package that uses libcurl for url requests"
p <- pkgmatch_similar_fns (input, corpus = corpus)
p # Default print method, lists 5 best matching functions
head (p) # Shows first 5 rows of full `data.frame` object
```


