# Perform pre-submission checks

## Description

Check that all standards are present in code, and listed either as
'@srrstats' or '@srrstatsNA'

## Usage

```r
srr_stats_pre_submit(path = ".", quiet = FALSE)
```

## Arguments

* `path`: Path to local repository to check
* `quiet`: If 'FALSE', display information on status of package on screen.

## Seealso

Other helper: 
`[srr_stats_categories](srr_stats_categories)()`,
`[srr_stats_checklist](srr_stats_checklist)()`,
`[srr_stats_checklist_check](srr_stats_checklist_check)()`,
`[srr_stats_pkg_skeleton](srr_stats_pkg_skeleton)()`

## Concept

helper

## Value

(Invisibly) List of any standards missing from code

## Examples

```r
d <- srr_stats_pkg_skeleton ()
# The skeleton has 'TODO' standards, and also has only a few from the full
# list expected for the categories specified there.
srr_stats_pre_submit (d)
```


