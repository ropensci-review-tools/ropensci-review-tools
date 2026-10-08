# Generate example data to use with pkgmatch

## Description

This function generates a selection of test data for the "cran"
corpus, to allow functions to be run offline, without having to download the
large datasets otherwise required for the package to function.
Note that these data are randomly generated, and results will be generally
meaningless. They are generated solely to demonstrate how the package
functions, and are not intended to derive meaningful outputs.

## Usage

```r
generate_pkgmatch_example_data(corpus = "cran")
```

## Arguments

* `corpus`: One of "ropensci" or "cran", where "ropensci" generates
additional data on function call frequencies.

## Seealso

Other utils:
`[head.pkgmatch()](head.pkgmatch)`,
`[pkgmatch_browse()](pkgmatch_browse)`,
`[pkgmatch_load_data()](pkgmatch_load_data)`,
`[pkgmatch_update_cache()](pkgmatch_update_cache)`,
`[print.pkgmatch()](print.pkgmatch)`

## Concept

utils

## Value

(Invisibly) The path to the temporary directory containing the
package data.

## Examples

```r
generate_pkgmatch_example_data ()
input <- "curl" # Name of a single installed package
pkgmatch_similar_pkgs (input, corpus = "cran")
```


