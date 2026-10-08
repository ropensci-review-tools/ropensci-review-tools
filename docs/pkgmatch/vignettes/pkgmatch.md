# The pkgmatch package

The “pkgmatch” package is a search and matching engine for R packages.
It finds the best-matching R packages to an input of either a text
description, or a local path to an R package. `pkgmatch` was developed
to enable rOpenSci to identify similar packages to each new package
submitted for [our software peer-review
scheme](https://ropensci.org/software-review/). Matching packages can be
found either in [rOpenSci’s own package
suite](https://ropensci.org/packages/), or all [packages currently on
CRAN](https://cran.r-project.org).

## What does the package do?

What the package does is best understood by example, starting with
loading the package.

``` r
library (pkgmatch)
```

Then match packages to an input string:

``` r
input <- "genomics and transcriptomics sequence location data"
pkgmatch_similar_pkgs (input, corpus = "ropensci")
```

    #> [1] "biomartr" "traits"   "phylotaR" "phruta"   "rebird"

By default, the top five matching packages are printed to the screen.
The function actually returns information on all packages, along with a
`head` method to display the first few rows:

``` r
p <- pkgmatch_similar_pkgs (input, corpus = "ropensci")
head (p)
```

    #>    package rank
    #> 1 biomartr    1
    #> 2   traits    2
    #> 3 phylotaR    3
    #> 4   phruta    4
    #> 5   rebird    5

The `head` method also accepts an `n` parameter to control how many rows
are displayed, or `as.data.frame` can be used to see the entire
`data.frame` of results.

The following lines find equivalent matches against all packages
currently on CRAN:

``` r
pkgmatch_similar_pkgs (input, corpus = "cran")
```

    #> [1] "omicsTools"         "ggalign"            "omixVizR"          
    #> [4] "singleCellHaystack" "spatialGE"

### Using an R package as input

The package also accepts as input a path to a local R package. The
following code downloads a “tarball” (`.tar.gz` file) from CRAN and
finds matching packages from that corpus. We of course expect the best
matches against CRAN packages to include that package itself:

``` r
u <- "https://cran.r-project.org/src/contrib/Archive/odbc/odbc_1.5.0.tar.gz"
destfile <- file.path (tempdir (), basename (u))
download.file (u, destfile = destfile, quiet = TRUE)
pkgmatch_similar_pkgs (destfile, corpus = "cran")
```

    #> [1] "odbc"              "RODBC"             "DatabaseConnector"
    #> [4] "dbplyr"            "reticulate"

which they indeed do. As explained in the documentation, the
`pkgmatch_similar_pkgs()` function ranks final results from [document
token-frequency analyses](https://en.wikipedia.org/wiki/Okapi_BM25). The
rankings from each of these components can be seen as above with the
`head` method:

``` r
p <- pkgmatch_similar_pkgs (destfile, corpus = "cran")
head (p)
```

    #>             package  version rank
    #> 1              odbc  1.6.4.1    1
    #> 2             RODBC 1.3-26.1    2
    #> 3 DatabaseConnector    7.1.0    3
    #> 4            dbplyr    2.5.2    4
    #> 5        reticulate   1.45.0    5
