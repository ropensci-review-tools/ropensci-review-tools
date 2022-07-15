# `srr_stats_roxygen`

Insert standards into code in roxygen2 format


## Description

Obtain rOpenSci standards for statistical software, along with one or more
 category-specific standards, as a checklist, convert to project-specific
 roxygen2 format, and save in nominated file.


## Usage

```r
srr_stats_roxygen(
  category = NULL,
  filename = "srr-stats-standards.R",
  overwrite = FALSE
)
```


## Arguments

Argument      |Description
------------- |----------------
`category`     |     One of the names of files given in the directory contents of [https://github.com/ropensci/statistical-software-review-book/tree/main/standards](https://github.com/ropensci/statistical-software-review-book/tree/main/standards) , each of which is ultimately formatted into a sub-section of the standards.
`filename`     |     Name of 'R' source file in which to write roxygen2 -formatted lists of standards.
`overwrite`     |     If `FALSE` (default) and `filename` already exists, a dialog will ask whether file should be overwritten.


## Value

Nothing


## Seealso

Other roxygen:
 [`srr_stats_roclet`](#srrstatsroclet)


## Examples

```r
path <- srr_stats_pkg_skeleton ()
# contains a few standards; insert all with:
f <- file.path (path, "R", "srr-stats-standards.R")
file.exists (f)
length (readLines (f)) # only 14 lines
srr_stats_roxygen (
category = "regression",
file = f,
overwrite = TRUE
)
length (readLines (f)) # now much longer
```


