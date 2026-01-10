# Make skeleton package to test roclet system

## Description

Make a dummy package skeleton including 'srr' `roxygen2` tags which can
be used to try out the functionality of this package. Running the example
lines below which activate the 'srr' roclets, and show you what the output
of those roclets looks like. Feel free to examine the effect of modifying any
of the `@srrstats` tags within the code as identified by running those lines.

## Usage

```r
srr_stats_pkg_skeleton(base_dir = tempdir(), pkg_name = "demo")
```

## Arguments

* `base_dir`: The base directory where the package should be constructed.
* `pkg_name`: The name of the package. The final location of this package
will be in `file.path(base_dir, pkg_name)`.

## Seealso

Other helper: 
`[srr_stats_categories](srr_stats_categories)()`,
`[srr_stats_checklist](srr_stats_checklist)()`,
`[srr_stats_checklist_check](srr_stats_checklist_check)()`,
`[srr_stats_pre_submit](srr_stats_pre_submit)()`

## Concept

helper

## Value

The path to the directory holding the newly created package

## Examples

```r
d <- srr_stats_pkg_skeleton (pkg_name = "mystatspkg")
# (capture.output of initial compliation messages)
x <- utils::capture.output (roxygen2::roxygenise (d), type = "output")
```


