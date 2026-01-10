# Check whether a user, identified from GitHub API token, is authorized to call

## Description

This function is used only in the `plumber` endpoints, to
prevent them being called by unauthorized users.

## Usage

```r
is_user_authorized(secret = NULL)
```

## Arguments

* `secret`: Environment variable `PKGCHECK_TOKEN` sent from bot.

## Seealso

Other ropensci: 
`[check_issue_template](check_issue_template)()`,
`[push_to_gh_pages](push_to_gh_pages)()`,
`[readme_has_peer_review_badge](readme_has_peer_review_badge)()`,
`[srr_counts](srr_counts)()`,
`[srr_counts_from_report](srr_counts_from_report)()`,
`[srr_counts_summary](srr_counts_summary)()`,
`[stats_badge](stats_badge)()`

## Concept

ropensci

## Value

Logical value indicating whether or not a user is authorized.


