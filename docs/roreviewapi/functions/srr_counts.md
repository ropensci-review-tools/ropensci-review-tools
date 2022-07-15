# `srr_counts`

Count number of 'srr' statistical standards complied with, and confirm
 whether than represents > 50% of all applicable standards.


## Description

Count number of 'srr' statistical standards complied with, and confirm
 whether than represents > 50% of all applicable standards.


## Usage

```r
srr_counts(repourl, repo, issue_id, post_to_issue = TRUE)
```


## Arguments

Argument      |Description
------------- |----------------
`repourl`     |     The URL for the repo being checked, potentially including full path to non-default branch.
`repo`     |     The 'context.repo' parameter defining the repository from which the command was invoked, passed in 'org/repo' format.
`issue_id`     |     The id (number) of the issue from which the command was invoked.
`post_to_issue`     |     Integer value > 0 will post results back to issue (via 'gh' cli); otherwise just return character string with result.


## Value

Vector of three numbers:
  

*  Number of standards complied with 

*  Total number of applicable standards 

*  Number complied with as proportion of total


## Seealso

Other ropensci:
 [`check_issue_template`](#checkissuetemplate) ,
 [`push_to_gh_pages`](#pushtoghpages) ,
 [`stats_badge`](#statsbadge)


