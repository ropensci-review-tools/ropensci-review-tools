# `is_user_authorized`

Check whether a user, identified from GitHub API token, is authorized to call
 endpoints.


## Description

This function is used only in the plumber endpoints, to prevent them
 being called by unauthorized users.


## Usage

```r
is_user_authorized(secret = NULL)
```


## Arguments

Argument      |Description
------------- |----------------
`secret`     |     Environment variable `PKGCHECK_TOKEN` sent from bot.


## Value

Logical value indicating whether or not a user is authorized.


## Seealso

Other ropensci:
 [`check_issue_template`](#checkissuetemplate) ,
 [`push_to_gh_pages`](#pushtoghpages) ,
 [`readme_has_peer_review_badge`](#readmehaspeerreviewbadge) ,
 [`srr_counts_summary`](#srrcountssummary) ,
 [`srr_counts`](#srrcounts) ,
 [`stats_badge`](#statsbadge)


