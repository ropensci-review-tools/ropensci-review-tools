# get_default_github_branch

## Description

get_default_github_branch

## Usage

```r
get_default_github_branch(org, repo)
```

## Arguments

* `org`: Github organization
* `repo`: Github repository

## Note

This function is not intended to be called directly, and is only
exported to enable it to be used within the `plumber` API.

## Seealso

Other github: 
`[get_gh_token](get_gh_token)()`,
`[get_latest_commit](get_latest_commit)()`,
`[use_github_action_pkgcheck](use_github_action_pkgcheck)()`

## Concept

github

## Value

Name of default branch on GitHub

## Examples

```r
org <- "ropensci-review-tools"
repo <- "pkgcheck"
branch <- get_default_github_branch (org, repo)
```


