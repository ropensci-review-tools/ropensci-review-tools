# Convert names of rOpenSci packages to markdown-formatted list.

## Description

This function is exported because it needs to be called in the main plumber
endpoint function.

## Usage

```r
ros_to_list(matches, n = 5L)
```

## Arguments

* `matches`: A `pkgmatch` `data.frame` object with columns of
("package", "version", "rank").
* `n`: Number of matches to return in list.

## Seealso

Other pkgmatch:
`[cran_to_list()](cran_to_list)`,
`[pkgmatch_repo()](pkgmatch_repo)`

## Concept

pkgmatch


