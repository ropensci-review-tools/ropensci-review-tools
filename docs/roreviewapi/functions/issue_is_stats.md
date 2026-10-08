# Determine whether a GitHub issue is a Stats submission

## Description

Determine whether a GitHub issue is a Stats submission

## Usage

```r
issue_is_stats(orgrepo, issue_num)
```

## Arguments

* `orgrepo`: GitHub organization and repo as single string separated by
forward slash (`org/repo`).
* `issue_num`: Number of issue from which to extract submission type.

## Seealso

Other ropensci:
`[check_issue_template()](check_issue_template)`,
`[is_user_authorized()](is_user_authorized)`,
`[push_to_gh_pages()](push_to_gh_pages)`,
`[readme_has_peer_review_badge()](readme_has_peer_review_badge)`,
`[srr_counts()](srr_counts)`,
`[srr_counts_from_report()](srr_counts_from_report)`,
`[srr_counts_summary()](srr_counts_summary)`,
`[stats_badge()](stats_badge)`

## Concept

ropensci

## Value

`TRUE` if the submission type is "Stats", otherwise `FALSE`.


