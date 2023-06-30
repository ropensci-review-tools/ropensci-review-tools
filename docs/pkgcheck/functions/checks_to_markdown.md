# `checks_to_markdown`

Convert checks to markdown-formatted report


## Description

Convert checks to markdown-formatted report


## Usage

```r
checks_to_markdown(checks, render = FALSE)
```


## Arguments

Argument      |Description
------------- |----------------
`checks`     |     Result of main [pkgcheck](#pkgcheck) function
`render`     |     If `TRUE` , render output as `html` document and open in browser.


## Value

Markdown-formatted version of check report


## Seealso

Other extra:
 [`list_pkgchecks`](#listpkgchecks) ,
 [`logfile_names`](#logfilenames) ,
 [`render_md2html`](#rendermd2html)


## Examples

```r
checks <- pkgcheck ("/path/to/my/package")
md <- checks_to_markdown (checks) # markdown-formatted character vector
md <- checks_to_markdown (checks, render = TRUE) # HTML version
```


