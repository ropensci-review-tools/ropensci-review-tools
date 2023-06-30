# `print.pkgcheck`

Generic print method for 'pkgcheck' objects.


## Description

Generic print method for 'pkgcheck' objects.


## Usage

```r
list(list("print"), list("pkgcheck"))(x, deps = FALSE, ...)
```


## Arguments

Argument      |Description
------------- |----------------
`x`     |     A 'pkgcheck' object to be printed.
`deps`     |     If 'TRUE', include details of dependency packages and function usage.
`...`     |     Further arguments pass to or from other methods (not used here).


## Value

Nothing. Method called purely for side-effect of printing to screen.


## Seealso

Other pkgcheck_fns:
 [`pkgcheck_bg`](#pkgcheckbg) ,
 [`pkgcheck`](#pkgcheck)


## Examples

```r
checks <- pkgcheck ("/path/to/my/package")
print (checks) # print full checks, starting with summary
summary (checks) # print summary only
```


