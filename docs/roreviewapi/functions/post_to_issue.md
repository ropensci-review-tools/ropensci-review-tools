# `post_to_issue`

Post review checks to GitHub issue


## Description

Post review checks to GitHub issue


## Usage

```r
post_to_issue(cmt, repo, issue_id)
```


## Arguments

Argument      |Description
------------- |----------------
`cmt`     |     Single character string with comment to post.
`repo`     |     The repository to post to (obtained directly from bot).
`issue_id`     |     The number of the issue to post to.


## Value

URL of the comment within the nominated issue


## Seealso

Other github:
 [`dl_gh_repo`](#dlghrepo)


