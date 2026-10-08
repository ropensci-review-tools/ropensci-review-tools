# Find R packages matching an input of either text or another package

## Description

This function accepts as `input` either a text description, the
name of a locally-installed package, or a path to a local directory containing an R package.
It ranks all R packages within the specified corpus in terms of how well they
match that input. The "corpus" argument can specify either [rOpenSci's package suite](https://ropensci.org/packages),
[CRAN](https://cran.r-project.org), or
[Bioconductor](https://bioconductor.org).
Ranks are obtained from scores derived from ["Best Match 25" (BM25)](https://en.wikipedia.org/wiki/Okapi_BM25) scores based on document
token frequencies.
Ranks are generally obtained by matching both for full package text from the
specified corpus, including all long-form documentation, and by matching
package descriptions only. The function returns a single rank derived by
combining individual ranks using the [Reciprocal Rank Fusion (RRF) algorithm](https://plg.uwaterloo.ca/~gvcormac/cormacksigir09-rrf.pdf).
Finally, all components of this function are locally cached for each call
(by the `memoise` package), so additional calls to this function with
the same `input` and `corpus` should be much faster than initial calls.

## Usage

```r
pkgmatch_similar_pkgs(
  input,
  corpus = NULL,
  idfs = NULL,
  n = 5L,
  browse = FALSE
)
```

## Arguments

* `input`: Either a text string, a path to local source code of an R
package, or the name of any installed R package.
* `corpus`: Must be specified as one of "ropensci", "cran", or "bioc" (for
BioConductor). If `idfs` parameter is not specified, data will be
automatically downloaded for the corpus specified by this parameter. The
function will then return the most similar package from the specified
corpus. Note that calculations will `corpus = "cran"` will generally take
longer, because the corpus is much larger.
* `idfs`: Inverse Document Frequency tables for a suite of packages,
generated from [pkgmatch_bm25](pkgmatch_bm25). If not provided, pre-generated IDF
tables will be downloaded and stored in a local cache directory.
* `n`: When the result of this function is printed to screen, the top `n`
packages will be displayed.
* `browse`: If `TRUE`, automatically open webpages of the top `n` matches
in local browser.

## Note

The first time this function is run without passing `idfs`, required
values will be automatically downloaded and stored in a locally persistent
cache directory. Especially for the "cran" corpus, this downloading may take
quite some time.

## Seealso

Other main:
`[pkgmatch_similar_fns()](pkgmatch_similar_fns)`

## Concept

main

## Value

A `data.frame` with a "package" column naming packages, and a
column of package ranks, with 1 being most similar. For the CRAN corpus, a
column of package versions is also included.
The returned object has a default `print` method which prints the best 5
matches directly to the screen, yet returns information on all packages
within the specified corpus. There is also a `head` method to print the
first few entries of these full data (default `n = 5`). To see all data, use
`as.data.frame()`.

## Examples

```r
# The following function simulates remote data in temporary directory, to
# enable package usage without downloading. Do not run for normal usage.
generate_pkgmatch_example_data ()

input <- "curl" # Name of a single installed package
p <- pkgmatch_similar_pkgs (input, corpus = "cran")
p # Default print method, lists 5 best matching packages
head (p) # Shows first 5 rows of full `data.frame` object
```


