# Body of main 'editorcheck' response

## Description

Body of main 'editorcheck' response

## Usage

```r
editor_check(repourl, repo, issue_id, post_to_issue = TRUE)
```

## Arguments

* `repourl`: The URL for the repo being checked, potentially including full
path to non-default branch.
* `repo`: The 'context.repo' parameter defining the repository from which
the command was invoked, passed in 'org/repo' format.
* `issue_id`: The id (number) of the issue from which the command was
invoked.
* `post_to_issue`: Integer value > 0 will post results back to issue (via
'gh' cli); otherwise just return character string with result.

## Seealso

Other main: 
`[collate_editor_check](collate_editor_check)()`,
`[serve_api](serve_api)()`

## Concept

main

## Value

If `!post_to_issue`, a markdown-formatted response body from static
package checks, otherwise URL of the issue comment to which response body has
been posted.


