# Generic print method for 'pkgcheck' objects.

## Description

Generic print method for 'pkgcheck' objects.

## Usage

```r
# S3 method for pkgcheck
print(x, deps = FALSE, ...)
```

## Arguments

* `x`: A 'pkgcheck' object to be printed.
* `deps`: If 'TRUE', include details of dependency packages and function
usage.
* `...`: Further arguments pass to or from other methods (not used here).

## Seealso

Other pkgcheck_fns: 
`[pkgcheck](pkgcheck)()`,
`[pkgcheck_bg](pkgcheck_bg)()`

## Concept

pkgcheck_fns

## Value

Nothing. Method called purely for side-effect of printing to screen.

## Examples

```r
checks <- pkgcheck ("/path/to/my/package")
print (checks) # print full checks, starting with summary
summary (checks) # print summary only
```


