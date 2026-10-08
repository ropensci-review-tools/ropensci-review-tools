# The "Best Matching 25" (BM25) ranking function.

## Description

BM25 values match single inputs to document corpora by
weighting terms by their inverse frequencies, so that relatively rare words
contribute more to match scores than common words. For each input, the BM25
value is the sum of relative frequencies of each term in the input
multiplied by the Inverse Document Frequency (IDF) of that term in the
entire corpus. See the Wikipedia page at
[https://en.wikipedia.org/wiki/Okapi_BM25](https://en.wikipedia.org/wiki/Okapi_BM25) for further details.

## Usage

```r
pkgmatch_bm25(input, txt = NULL, idfs = NULL, corpus = NULL, minchar = 3L)
```

## Arguments

* `input`: A single character string to match against the second parameter
of all input documents.
* `txt`: An optional list of input documents. If not specified, data will
be loaded as specified by the `corpus` parameter.
* `idfs`: Optional list of Inverse Document Frequency weightings generated
by the internal `bm25_idf` function. If not specified, values for the
rOpenSci corpus will be automatically downloaded and used.
* `corpus`: If `txt` is not specified, data for nominated corpus will be
downloaded to local cache directory, and BM25 values calculated against
those. Must be one of "ropensci", "ropensci-fns", "cran", or "bioc" (for
BioConductor). Note that the "ropensci-fns" and "bioc_fns" corpora contain
entries for every single function of every rOpenSci and BioConductor
package, respectively, and the resulting BM25 values can be used to
determine the best-matching function. The other two corpora are
package-based, and the results can be used to find the best-matching
package.
* `minchar`: Minimal number of characters; tokens with less than this
number are discarded.

## Seealso

Other bm25:
`[pkgmatch_bm25_fn_calls()](pkgmatch_bm25_fn_calls)`

## Concept

bm25

## Value

A `data.frame` of package names and 'BM25' measures against text
from whole packages both with and without function descriptions.

## Examples

```r
# The following function simulates remote data in temporary directory, to
# enable package usage without downloading. Do not run for normal usage.
generate_pkgmatch_example_data ()

input <- "curl" # Name of a single installed package
pkgmatch_bm25 (input, corpus = "cran")
# Or pre-load document-frequency weightings and pass those:
idfs <- pkgmatch_load_data ("idfs", corpus = "cran", fns = FALSE)
# Those have token frequencies for both "full" text, and for descriptions
# only "desc_only":
pkgmatch_bm25 (input, corpus = "cran", idfs = idfs$full)
pkgmatch_bm25 (input, corpus = "cran", idfs = idfs$descs_only)
```


