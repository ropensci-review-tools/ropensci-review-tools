# `use_github_action_pkgcheck`

Use pkgcheck Github Action


## Description

Creates a Github workflow file in `dir` integrate [`pkgcheck()`](#pkgcheck()) into your CI.


## Usage

```r
use_github_action_pkgcheck(
  dir = ".github/workflows",
  overwrite = FALSE,
  file_name = "pkgcheck.yaml",
  branch = gert::git_branch(),
  inputs = NULL
)
```


## Arguments

Argument      |Description
------------- |----------------
`dir`     |     Directory the file is written to.
`overwrite`     |     Overwrite existing file?
`file_name`     |     Name of the workflow file.
`branch`     |     Name of git branch for checks to run; defaults to currently active branch.
`inputs`     |     Named list of inputs to the `ropensci-review-tools/pkgcheck-action` . See details below.


## Details

For more information on the action and advanced usage visit the
 action
 [repository](https://github.com/ropensci-review-tools/pkgcheck-action) .


## Value

The path to the new file, invisibly.


## Seealso

Other github:
 [`get_default_github_branch`](#getdefaultgithubbranch) ,
 [`get_gh_token`](#getghtoken) ,
 [`get_latest_commit`](#getlatestcommit)


## Examples

```r
use_github_action_pkgcheck (inputs = list (`post-to-issue` = "false"))
use_github_action_pkgcheck (branch = "main")
```


