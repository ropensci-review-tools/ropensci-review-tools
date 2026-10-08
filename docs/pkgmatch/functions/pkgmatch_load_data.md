# Load 'pkgmatch' data for specified corpus.

## Description

Load pre-computed data for a specified corpus. Data types are:

* "idfs" for Inverse Document Frequency weightings;
* "functions" for frequency tables for text descriptions of function
calls; or
* "calls" for frequency tables for actual function calls.

This function is called within the main [pkgmatch_similar_pkgs](pkgmatch_similar_pkgs)function to load required data there, and should not generally need to be
explicitly called.

## Usage

```r
pkgmatch_load_data(what = "idfs", corpus = "ropensci", fns = FALSE)
```

## Arguments

* `what`: One of the three data types described above: "idfs",
"functions", or "calls".
* `corpus`: Must be specified as one of "ropensci", "cran", or "bioc" (for
BioConductor). If `idfs` parameter is not specified, data will be
automatically downloaded for the corpus specified by this parameter. The
function will then return the most similar package from the specified
corpus. Note that calculations will `corpus = "cran"` will generally take
longer, because the corpus is much larger.
* `fns`: If `FALSE` (default), load data for all packages; otherwise
load (considerably larger dataset of) data for all individual
functions.

## Seealso

Other utils:
`[generate_pkgmatch_example_data()](generate_pkgmatch_example_data)`,
`[head.pkgmatch()](head.pkgmatch)`,
`[pkgmatch_browse()](pkgmatch_browse)`,
`[pkgmatch_update_cache()](pkgmatch_update_cache)`,
`[print.pkgmatch()](print.pkgmatch)`

## Concept

utils

## Value

The loaded data.

## Examples

```r
corpus <- "cran"
generate_pkgmatch_example_data (corpus = corpus)
idfs <- pkgmatch_load_data ("idfs", corpus = corpus)
idfs_fns <- pkgmatch_load_data ("idfs", fns = TRUE, corpus = corpus)
```


