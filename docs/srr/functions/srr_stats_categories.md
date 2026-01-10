# Get details of current statistical software categories

## Description

List all currently available categories and associated URLs to full category
descriptions.

## Usage

```r
srr_stats_categories()
```

## Seealso

Other helper: 
`[srr_stats_checklist](srr_stats_checklist)()`,
`[srr_stats_checklist_check](srr_stats_checklist_check)()`,
`[srr_stats_pkg_skeleton](srr_stats_pkg_skeleton)()`,
`[srr_stats_pre_submit](srr_stats_pre_submit)()`

## Concept

helper

## Value

A `data.frame` with 3 columns of "category" (the categories to be
submitted to [srr_stats_checklist](srr_stats_checklist)), "title" (the full title), and
"url".

## Examples

```r
srr_stats_categories ()
```


