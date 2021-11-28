# `ctags_test`

test a 'ctags' installation


## Description

This uses the example from
 [https://github.com/universal-ctags/ctags/blob/master/man/ctags-lang-r.7.rst.in](https://github.com/universal-ctags/ctags/blob/master/man/ctags-lang-r.7.rst.in) 
 and also checks the GNU global installation.


## Usage

```r
ctags_test(quiet = TRUE)
```


## Arguments

Argument      |Description
------------- |----------------
`quiet`     |     If `TRUE` , display on screen whether or not 'ctags' is correctly installed.


## Value

'TRUE' or 'FALSE' respectively indicating whether or not 'ctags' is
 correctly installed.


## Seealso

Other tags:
 [`ctags_install`](#ctagsinstall) ,
 [`tags_data`](#tagsdata)


## Examples

```r
ctags_test ()
```


