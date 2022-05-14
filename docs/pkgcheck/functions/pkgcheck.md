# `pkgcheck`

Generate report on package compliance with rOpenSci Statistical Software
 requirements


## Description

Generate report on package compliance with rOpenSci Statistical Software
 requirements


## Usage

```r
pkgcheck(
  path = ".",
  goodpractice = TRUE,
  use_cache = TRUE,
  extra_env = .GlobalEnv
)
```


## Arguments

Argument      |Description
------------- |----------------
`path`     |     Path to local repository
`goodpractice`     |     If `FALSE` , skip goodpractice checks. May be useful in development stages to more quickly check other aspects.
`use_cache`     |     Checks are cached for rapid retrieval, and only re-run if the git hash of the local repository changes. Setting `use_cache` to `FALSE`  will for checks to be re-run even if the git hash has not changed.
`extra_env`     |     Additional environments from which to collate checks. Other package names may be appended using `c` , as in `c(.GlobalEnv, "mypkg")` .


## Value

A `pkgcheck` object detailing all package assessments automatically
 applied to packages submitted for peer review.


## Seealso

Other pkgcheck_fns:
 [`pkgcheck_bg`](#pkgcheckbg)


