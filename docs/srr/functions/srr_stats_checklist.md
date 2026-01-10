# Download checklists of statistical software standards

## Description

Obtain rOpenSci standards for statistical software, along with one or more
category-specific standards, as a checklist, and store the result in the
local clipboard ready to paste.

## Usage

```r
srr_stats_checklist(category = NULL, filename = NULL)
```

## Arguments

* `category`: One of the names of files given in the directory contents of
[https://github.com/ropensci/statistical-software-review-book/tree/main/standards](https://github.com/ropensci/statistical-software-review-book/tree/main/standards),
each of which is ultimately formatted into a sub-section of the standards.
* `filename`: Optional name of local file to save markdown-formatted
checklist. A suffix of `.md` will be automatically appended.

## Seealso

Other helper: 
`[srr_stats_categories](srr_stats_categories)()`,
`[srr_stats_checklist_check](srr_stats_checklist_check)()`,
`[srr_stats_pkg_skeleton](srr_stats_pkg_skeleton)()`,
`[srr_stats_pre_submit](srr_stats_pre_submit)()`

## Concept

helper

## Value

A character vector containing a markdown-style checklist of general
standards along with standards for any additional categories.

## Examples

```r
x <- srr_stats_checklist (category = "regression")
# or write to specified file:
f <- tempfile (fileext = ".md")
x <- srr_stats_checklist (category = "regression", filename = f)
```


