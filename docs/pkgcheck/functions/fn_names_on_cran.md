# Check whether a function name exists in any CRAN packages

## Description

Check whether a function name exists in any CRAN packages

## Usage

```r
fn_names_on_cran(fn_name, force_update = FALSE)
```

## Arguments

* `fn_name`: Character vector of one or more function names to check.
* `force_update`: If 'TRUE', locally-cached data of all function names
from all CRAN packages will be updated to latest version.

## Seealso

Other extra: 
`[checks_to_markdown](checks_to_markdown)()`,
`[list_pkgchecks](list_pkgchecks)()`,
`[logfile_names](logfile_names)()`,
`[render_md2html](render_md2html)()`

## Concept

extra

## Value

A `data.frame` of three columns, "package", "version", and
"fn_name", identifying any other packages matching specified function
name(s). If no matches are found, the `data.frame` will have no rows.

## Examples

```r
fn_names_on_cran (c ("min", "max"))
```


