# `srr_stats_pre_submit`

Perform pre-submission checks


## Description

Check that all standards are present in code, and listed either as
 '@srrstats' or '@srrstatsNA'


## Usage

```r
srr_stats_pre_submit(path = ".", quiet = FALSE)
```


## Arguments

Argument      |Description
------------- |----------------
`path`     |     Path to local repository to check
`quiet`     |     If 'FALSE', display information on status of package on screen.


## Value

(Invisibly) List of any standards missing from code


## Seealso

Other helper:
 [`srr_stats_categories`](#srrstatscategories) ,
 [`srr_stats_checklist_check`](#srrstatschecklistcheck) ,
 [`srr_stats_checklist`](#srrstatschecklist) ,
 [`srr_stats_pkg_skeleton`](#srrstatspkgskeleton)


## Examples

```r
d <- srr_stats_pkg_skeleton ()
# The skeleton has 'TODO' standards, and also has only a few from the full
# list expected for the categories specified there.
srr_stats_pre_submit (d)
```


