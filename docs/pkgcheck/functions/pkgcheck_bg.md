# `pkgcheck_bg`

Generate report on package compliance with rOpenSci Statistical Software
 requirements as background process


## Description

Generate report on package compliance with rOpenSci Statistical Software
 requirements as background process


## Usage

```r
pkgcheck_bg(path)
```


## Arguments

Argument      |Description
------------- |----------------
`path`     |     Path to local repository


## Value

A processx object connecting to the background process
 generating the main [pkgcheck](#pkgcheck) results (see Note).


## Seealso

Other pkgcheck_fns:
 [`pkgcheck`](#pkgcheck) ,
 [`print.pkgcheck`](#print.pkgcheck)


## Note

The return object will by default display whether it is still running,
 or whether it has finished. Once it has finished, the results can be obtained
 by calling $get_result() , or the main [pkgcheck](#pkgcheck) function can be
 called to quickly retrieve the main results from local cache.
 
 This function does not accept the `extra_env` parameter of the main
 [pkgcheck](#pkgcheck) function, and can not be used to run extra, locally-defined
 checks.


