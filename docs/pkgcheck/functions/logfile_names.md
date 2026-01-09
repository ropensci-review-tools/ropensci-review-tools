# Set up stdout & stderr cache files for

## Description

Set up stdout & stderr cache files for `r_bg` process

## Usage

```r
logfile_names(path)
```

## Arguments

* `path`: Path to local repository

## Note

These files are needed for the `callr``r_bg` process which
controls the main [pkgcheck](pkgcheck). The `stdout` and `stderr` pipes from the
process are stored in the cache directory so they can be inspected via their
own distinct endpoint calls.

## Seealso

Other extra: 
`[checks_to_markdown](checks_to_markdown)()`,
`[fn_names_on_cran](fn_names_on_cran)()`,
`[list_pkgchecks](list_pkgchecks)()`,
`[render_md2html](render_md2html)()`

## Concept

extra

## Value

Vector of two strings holding respective local paths to `stdout` and
`stderr` files for `r_bg` process controlling the main [pkgcheck](pkgcheck)function when executed in background mode.

## Examples

```r
logfiles <- logfiles_namnes ("/path/to/my/package")
print (logfiles)
```


