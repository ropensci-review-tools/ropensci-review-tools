# `file_pkgcheck_issue`

File an issue in the GitHub `pkgcheck` repo on any packages which fail checks


## Description

File an issue in the GitHub `pkgcheck` repo on any packages which fail checks


## Usage

```r
file_pkgcheck_issue(
  repourl = NULL,
  repo = "ropensci-review-tools/pkgcheck",
  issue_id = NULL
)
```


## Arguments

Argument      |Description
------------- |----------------
`repourl`     |     The URL for the repo being checked.
`repo`     |     The 'context.repo' parameter defining the repository from which the command was invoked, passed in 'org/repo' format.
`issue_id`     |     The id (number) of the issue from which the command was invoked.


## Note

Exported only for access by plumber; not intended for general external
 usage.


