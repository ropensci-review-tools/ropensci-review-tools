# `get_latest_commit`

get_latest_commit


## Description

get_latest_commit


## Usage

```r
get_latest_commit(org, repo)
```


## Arguments

Argument      |Description
------------- |----------------
`org`     |     Github organization
`repo`     |     Github repository


## Value

Details of latest commit including OID hash


## Seealso

Other github:
 [`get_default_branch`](#getdefaultbranch) ,
 [`get_gh_token`](#getghtoken)


## Note

This returns the latest commit from the default branch as specified on
 GitHub, which will not necessarily be the same as information returned from
 `gert::git_info` if the `HEAD` of a local repository does not point to the
 same default branch.


