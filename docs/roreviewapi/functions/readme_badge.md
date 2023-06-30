# `readme_badge`

Check whether README.md features an rOpenSci software-review badge


## Description

Check whether README.md features an rOpenSci software-review badge


## Usage

```r
readme_badge(repourl, repo = NULL, issue_id = NULL, post_to_issue = TRUE)
```


## Arguments

Argument      |Description
------------- |----------------
`repourl`     |     The URL for the repo being checked, potentially including full path to non-default branch.
`repo`     |     The 'context.repo' parameter defining the repository from which the command was invoked, passed in 'org/repo' format.
`issue_id`     |     The id (number) of the issue from which the command was invoked.
`post_to_issue`     |     Integer value > 0 will post results back to issue (via 'gh' cli); otherwise just return character string with result.


## Value

A string, empty if the badge was found.


