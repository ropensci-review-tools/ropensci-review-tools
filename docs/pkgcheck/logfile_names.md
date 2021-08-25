# `logfile_names`

Set up stdout & stderr cache files for `r_bg` process


## Description

Set up stdout & stderr cache files for `r_bg` process


## Usage

```r
logfile_names(path)
```


## Arguments

Argument      |Description
------------- |----------------
`path`     |     Path to local repository


## Value

Vector of two strings holding respective local paths to `stdout` and
 `stderr` files for `r_bg` process controlling the main [pkgcheck](#pkgcheck) 
 function when executed in background mode.


## Seealso

Other extra:
 [`checks_to_markdown`](#checkstomarkdown) ,
 [`render_markdown`](#rendermarkdown)


## Note

These files are needed for the callr  `r_bg` process which
 controls the main [pkgcheck](#pkgcheck) . The `stdout` and `stderr` pipes from the
 process are stored in the cache directory so they can be inspected via their
 own distinct endpoint calls.


