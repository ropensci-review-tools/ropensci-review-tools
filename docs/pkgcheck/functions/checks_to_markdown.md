# Convert checks to markdown-formatted report

## Description

Convert checks to markdown-formatted report

## Usage

```r
checks_to_markdown(checks, render = FALSE)
```

## Arguments

* `checks`: Result of main [pkgcheck](pkgcheck) function
* `render`: If `TRUE`, render output as `html` document and open in
browser.

## Seealso

Other extra:
`[fn_names_on_cran()](fn_names_on_cran)`,
`[list_pkgchecks()](list_pkgchecks)`,
`[logfile_names()](logfile_names)`,
`[render_md2html()](render_md2html)`

## Concept

extra

## Value

Markdown-formatted version of check report

## Examples

```r
f <- system.file ("extdata", "pkgstats_9.9.tar.gz", package = "pkgstats")
path <- pkgstats::extract_tarball (f)


checks <- pkgcheck (path, goodpractice = FALSE)
md <- checks_to_markdown (checks) # markdown-formatted character vector
md <- checks_to_markdown (checks, render = TRUE) # HTML version

fs::dir_delete (path)
```


