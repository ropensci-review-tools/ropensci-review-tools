# Update all locally-cached

## Description

This function forces all locally-cached data to be updated with
latest version of remote data provided on the latest release of GitHub
repository at
[https://github.com/ropensci-review-tools/pkgmatch/releases](https://github.com/ropensci-review-tools/pkgmatch/releases).
Caching strategies are described in the "*Data Caching and Updating*"
vignette, accessible either locally via
`vignette("data-caching-and-updating", package = "pkgmatch")`, or online at
[https://docs.ropensci.org/pkgmatch/articles/B_data-caching-and-updating.html](https://docs.ropensci.org/pkgmatch/articles/B_data-caching-and-updating.html).
In short, locally-cached data used by this package are updated
by default every 30 days (with the vignette describing how to modify this
default behaviour). This function forces all locally-cached data to be
updated, regardless of update frequencies.

## Usage

```r
pkgmatch_update_cache()
```

## Seealso

Other utils:
`[generate_pkgmatch_example_data()](generate_pkgmatch_example_data)`,
`[head.pkgmatch()](head.pkgmatch)`,
`[pkgmatch_browse()](pkgmatch_browse)`,
`[pkgmatch_load_data()](pkgmatch_load_data)`,
`[print.pkgmatch()](print.pkgmatch)`

## Concept

utils

## Value

(Invisibly) A list of full local paths to all files which were
updated.

## Examples

```r
pkgmatch_update_cache ()
```


