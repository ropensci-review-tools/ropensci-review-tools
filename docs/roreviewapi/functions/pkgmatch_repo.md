# Body of main 'pkgmatch' response

## Description

Body of main 'pkgmatch' response

## Usage

```r
pkgmatch_repo(repourl, repo, issue_id, n_top = 5L, post_to_issue = TRUE)
```

## Arguments

* `repourl`: The URL for the repo being matched, potentially including
full path to non-default branch.
* `repo`: The 'context.repo' parameter defining the repository from which
the command was invoked, passed in 'org/repo' format.
* `issue_id`: The id (number) of the issue from which the command was
invoked.
* `n_top`: Return this number of top-matches packages.
* `post_to_issue`: Integer value > 0 will post results back to issue (via
'gh' cli); otherwise just return character string with result.

## Seealso

Other pkgmatch:
`[cran_to_list()](cran_to_list)`,
`[ros_to_list()](ros_to_list)`

## Concept

pkgmatch

## Value

If `!post_to_issue`, a markdown-formatted response body, otherwise
URL of the issue comment to which response body has been posted.


