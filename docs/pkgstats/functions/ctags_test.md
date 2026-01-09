# test a 'ctags' installation

## Description

This uses the example from
[https://github.com/universal-ctags/ctags/blob/master/man/ctags-lang-r.7.rst.in](https://github.com/universal-ctags/ctags/blob/master/man/ctags-lang-r.7.rst.in)and also checks the GNU global installation.

## Usage

```r
ctags_test(quiet = TRUE, noerror = FALSE)
```

## Arguments

* `quiet`: If `TRUE`, display on screen whether or not 'ctags' is correctly
installed.
* `noerror`: If `FALSE` (default), this function will error if either
'ctags' or 'gtags' are not installed. If `TRUE`, the function will complete
without erroring, and issue appropriate messages regarding required but
non-installed system libraries.

## Seealso

Other tags: 
`[ctags_install](ctags_install)()`,
`[tags_data](tags_data)()`

## Concept

tags

## Value

'TRUE' or 'FALSE' respectively indicating whether or not 'ctags' is
correctly installed.

## Examples

```r
# The function errors if not ctags or gtags found.

ctags_okay <- !is.null (tryCatch (
    ctags_test (),
    error = function (e) NULL
))
```


