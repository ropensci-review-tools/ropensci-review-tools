# `render_md2html`

render markdown-formatted input into 'html'


## Description

render markdown-formatted input into 'html'


## Usage

```r
render_md2html(md, open = TRUE)
```


## Arguments

Argument      |Description
------------- |----------------
`md`     |     Result of [checks_to_markdown](#checkstomarkdown) function.
`open`     |     If `TRUE` , open `hmtl` -rendered version in web browser.


## Value

(invisible) Location of `.html` -formatted version of input.


## Seealso

Other extra:
 [`checks_to_markdown`](#checkstomarkdown) ,
 [`list_pkgchecks`](#listpkgchecks) ,
 [`logfile_names`](#logfilenames)


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


