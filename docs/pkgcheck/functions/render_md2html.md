# render markdown-formatted input into 'html'

## Description

render markdown-formatted input into 'html'

## Usage

```r
render_md2html(md, open = TRUE)
```

## Arguments

* `md`: Result of [checks_to_markdown](checks_to_markdown) function.
* `open`: If `TRUE`, open `hmtl`-rendered version in web browser.

## Seealso

Other extra: 
`[checks_to_markdown](checks_to_markdown)()`,
`[fn_names_on_cran](fn_names_on_cran)()`,
`[list_pkgchecks](list_pkgchecks)()`,
`[logfile_names](logfile_names)()`

## Concept

extra

## Value

(invisible) Location of `.html`-formatted version of input.

## Examples

```r
checks <- pkgcheck ("/path/to/my/package")
# Generate standard markdown-formatted character vector:
md <- checks_to_markdown (checks)

# Directly generate HTML output:
h <- checks_to_markdown (checks, render = TRUE) # HTML version

# Or convert markdown-formatted version to HTML:
h <- render_md2html (md)
```


