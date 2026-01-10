# Count number of 'srr' statistical standards complied with, and confirm

## Description

Count number of 'srr' statistical standards complied with, and confirm
whether than represents > 50% of all applicable standards.

## Usage

```r
srr_counts(repourl, repo, issue_id, post_to_issue = TRUE)
```

## Arguments

* `repourl`: The URL for the repo being checked, potentially including full
path to non-default branch.
* `repo`: The 'context.repo' parameter defining the repository from which
the command was invoked, passed in 'org/repo' format.
* `issue_id`: The id (number) of the issue from which the command was
invoked.
* `post_to_issue`: Integer value > 0 will post results back to issue (via
'gh' cli); otherwise just return character string with result.

## Seealso

Other ropensci: 
`[check_issue_template](check_issue_template)()`,
`[is_user_authorized](is_user_authorized)()`,
`[push_to_gh_pages](push_to_gh_pages)()`,
`[readme_has_peer_review_badge](readme_has_peer_review_badge)()`,
`[srr_counts_from_report](srr_counts_from_report)()`,
`[srr_counts_summary](srr_counts_summary)()`,
`[stats_badge](stats_badge)()`

## Concept

ropensci

## Value

Vector of three numbers:

1. Number of standards complied with
1. Total number of applicable standards
1. Number complied with as proportion of total


