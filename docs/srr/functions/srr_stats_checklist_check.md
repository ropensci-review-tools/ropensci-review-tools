# Check a completed standards checklist

## Description

Correct any potential formatting issues in a completed standards checklist

## Usage

```r
srr_stats_checklist_check(file)
```

## Arguments

* `file`: Name of local file containing a completed checklist. Must be a
markdown document in `.md` format, not `.Rmd` or anything else.

## Seealso

Other helper: 
`[srr_stats_categories](srr_stats_categories)()`,
`[srr_stats_checklist](srr_stats_checklist)()`,
`[srr_stats_pkg_skeleton](srr_stats_pkg_skeleton)()`,
`[srr_stats_pre_submit](srr_stats_pre_submit)()`

## Concept

helper

## Examples

```r
f <- tempfile (fileext = ".md")
srr_stats_checklist (category = "regression", filename = f)
chk <- srr_stats_checklist_check (f)
```


