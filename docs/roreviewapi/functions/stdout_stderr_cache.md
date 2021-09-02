# `stdout_stderr_cache`

Set up stdout & stderr cache files for `r_bg` process


## Description

Set up stdout & stderr cache files for `r_bg` process


## Usage

```r
stdout_stderr_cache(repourl)
```


## Arguments

Argument      |Description
------------- |----------------
`repourl`     |     The URL of the repo being checked


## Value

Vector of two strings holding respective local paths to `stdout` and
 `stderr` files for `r_bg` process controlling the main [editor_check](#editorcheck) 
 function.


## Note

These files are needed for the callr  `r_bg` process which
 controls the main [editor_check](#editorcheck) call. See
 [https://github.com/r-lib/callr/issues/204](https://github.com/r-lib/callr/issues/204) . The `stdout` and `stderr` 
 pipes from the process are stored in the cache directory so they can be
 inspected via their own distinct endpoint calls.


