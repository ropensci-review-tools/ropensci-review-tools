# `readme_has_peer_review_badge`

Check whether 'README.md' has a "peer reviewed" badge


## Description

Check whether 'README.md' has a "peer reviewed" badge


## Usage

```r
readme_has_peer_review_badge(path = getwd(), issue_id = NULL)
```


## Arguments

Argument      |Description
------------- |----------------
`path`     |     Local path to package directory.
`issue_id`     |     The id (number) of the issue from which the command was invoked.


## Value

A string, empty if the badge was found.


## Seealso

Other ropensci:
 [`check_issue_template`](#checkissuetemplate) ,
 [`is_user_authorized`](#isuserauthorized) ,
 [`push_to_gh_pages`](#pushtoghpages) ,
 [`srr_counts_summary`](#srrcountssummary) ,
 [`srr_counts`](#srrcounts) ,
 [`stats_badge`](#statsbadge)


