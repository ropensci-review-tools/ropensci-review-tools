# Identify all function calls made within a package.

## Description

This function uses "treesitter"
([https://github.com/tree-sitter/tree-sitter](https://github.com/tree-sitter/tree-sitter)) to tag all function calls
made within a local package, and to associate those calls with package
namespaces.
This is used as input to the [pkgmatch_bm25_fn_calls](pkgmatch_bm25_fn_calls) function, to
enable function calls within a local package to be inversely weighted by
frequencies within all packages within a corpus. The results of applying
this function to the full corpora used in this package are contained within
the data listed on
[https://github.com/ropensci-review-tools/pkgmatch/releases/tag/v0.5.2](https://github.com/ropensci-review-tools/pkgmatch/releases/tag/v0.5.2),
as "fn-calls-ropensci.Rds" and "fn-calls-cran.Rds".

## Usage

```r
pkgmatch_treesitter_fn_tags(path)
```

## Arguments

* `path`: Path to local package, or `.tar.gz` file of package source.

## Concept

treesitter

## Value

A `data.frame` of all function calls made within the package, with
the following columns:

* 'fn' Name of the package function within which call is made, including
namespace identifiers of "::" for exported functions and ":::" for
non-exported functions.
* name Name of function being called, including namespace.
* start Byte number within file corresponding to start of definition
* end Byte number within file corresponding to end of definition
* file Name of file in which fn call is defined.

## Examples

```r
# Get function calls made within locally-installed packages:
fn_tags <- pkgmatch_treesitter_fn_tags ("curl") # Name of installed package
fn_tags <- pkgmatch_treesitter_fn_tags ("cli") # Name of installed package

# Or get calls from full source code:
u <- "https://cran.r-project.org/src/contrib/Archive/odbc/odbc_1.5.0.tar.gz"
path <- file.path (tempdir (), basename (u))

download.file (u, destfile = path, quiet = TRUE)
fn_tags <- pkgmatch_treesitter_fn_tags (path)
```


