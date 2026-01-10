# Check whether 'README.md' has a "peer reviewed" badge

## Description

Check whether 'README.md' has a "peer reviewed" badge

## Usage

```r
readme_has_peer_review_badge(path = getwd(), issue_id = NULL)
```

## Arguments

* `path`: Local path to package directory.
* `issue_id`: The id (number) of the issue from which the command was
invoked.

## Seealso

Other ropensci: 
`[check_issue_template](check_issue_template)()`,
`[is_user_authorized](is_user_authorized)()`,
`[push_to_gh_pages](push_to_gh_pages)()`,
`[srr_counts](srr_counts)()`,
`[srr_counts_from_report](srr_counts_from_report)()`,
`[srr_counts_summary](srr_counts_summary)()`,
`[stats_badge](stats_badge)()`

## Concept

ropensci

## Value

A string, empty if the badge was found.


