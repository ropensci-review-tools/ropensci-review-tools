# Print method for 'pkgmatch' objects

## Description

The main `pkgmatch` function, [pkgmatch_similar_pkgs](pkgmatch_similar_pkgs),
returns `data.frame` objects of class "pkgmatch". This class exists
primarily to enable this print method, which summarises by default the top 5
matching packages or functions. Objects can be converted to standard
`data.frame`s with `as.data.frame()`.

## Usage

```r
# S3 method for pkgmatch
print(x, ...)
```

## Arguments

* `x`: Object to be printed
* `...`: Additional parameters passed to default 'print' method.

## Seealso

Other utils:
`[generate_pkgmatch_example_data()](generate_pkgmatch_example_data)`,
`[head.pkgmatch()](head.pkgmatch)`,
`[pkgmatch_browse()](pkgmatch_browse)`,
`[pkgmatch_load_data()](pkgmatch_load_data)`,
`[pkgmatch_update_cache()](pkgmatch_update_cache)`

## Concept

utils

## Value

The result of printing `x`, in form of either a single character
vector, or a named list of character vectors.

## Examples

```r
corpus <- "cran"
generate_pkgmatch_example_data (corpus = corpus)
input <- "Download open spatial data from NASA"
p <- pkgmatch_similar_pkgs (input, corpus = corpus)
head (p) # Shows first 5 rows of full `data.frame` object
p # Default print method, lists 5 best matching packages
```


