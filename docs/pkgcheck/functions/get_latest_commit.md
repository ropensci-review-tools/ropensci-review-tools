# `get_latest_commit`

get_latest_commit


## Description

get_latest_commit


## Usage

```r
get_latest_commit(org, repo, branch = NULL)
```


## Arguments

Argument      |Description
------------- |----------------
`org`     |     Github organization
`repo`     |     Github repository
`branch`     |     Branch from which to get latest commit


## Value

Details of latest commit including OID hash


## Seealso

Other github:
 [`get_default_github_branch`](#getdefaultgithubbranch) ,
 [`get_gh_token`](#getghtoken) ,
 [`use_github_action_pkgcheck`](#usegithubactionpkgcheck)


## Note

This returns the latest commit from the default branch as specified on
 GitHub, which will not necessarily be the same as information returned from
 `gert::git_info` if the `HEAD` of a local repository does not point to the
 same default branch.


## Examples

```r
org <- "ropensci-review-tools"
repo <- "pkgcheck"
commit <- get_latest_commit (org, repo)
```


