# `pkgcheck`

Generate report on package compliance with rOpenSci Statistical Software
 requirements


## Description

Generate report on package compliance with rOpenSci Statistical Software
 requirements


## Usage

```r
pkgcheck(path = ".", extra_env = .GlobalEnv)
```


## Arguments

Argument      |Description
------------- |----------------
`path`     |     Path to local repository
`extra_env`     |     Additional environments from which to collate checks. Other package names may be appended using `c` , as in `c(.GlobalEnv, "mypkg")` .


## Value

A `pkgcheck` object detailing all package assessments automatically
 applied to packages submitted for peer review.


## Seealso

Other pkgcheck_fns:
 [`pkgcheck_bg`](#pkgcheckbg)


