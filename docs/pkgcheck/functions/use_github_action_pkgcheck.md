# Use pkgcheck Github Action

## Description

Creates a Github workflow file in `dir` integrate `[pkgcheck()](pkgcheck)` into your CI.

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

* `dir`: Directory the file is written to.
* `overwrite`: Overwrite existing file?
* `file_name`: Name of the workflow file.
* `branch`: Name of git branch for checks to run; defaults to currently
active branch.
* `inputs`: Named list of inputs to the
`ropensci-review-tools/pkgcheck-action`. See details below.

## Details

For more information on the action and advanced usage visit the
action
[repository](https://github.com/ropensci-review-tools/pkgcheck-action).

## Inputs

Inputs with description and default values. Pass all values as strings, see
examples.

```
inputs:
  ref:
    description: "The ref to checkout and check. Set to empty string to skip checkout."
    default: "${{ github.ref }}"
    required: true
  post-to-issue:
    description: "Should the pkgcheck results be posted as an issue?"
    # If you use the 'pull_request' trigger and the PR is from outside the repo
    # (e.g. a fork), the job will fail due to permission issues
    # if this is set to 'true'. The default will prevent this.
    default: ${{ github.event_name != 'pull_request' }}
    required: true
  issue-title:
    description: "Name for the issue containing the pkgcheck results. Will be created or updated."
    # This will create a new issue for every branch, set it to something fixed
    # to only create one issue that is updated via edits.
    default: "pkgcheck results - ${{ github.ref_name }}"
    required: true
  summary-only:
    description: "Only post the check summary to issue. Set to false to get the full results in the issue."
    default: true
    required: true
  append-to-issue:
    description: "Should issue results be appended to existing issue, or posted in new issues."
    default: true
    required: true
```

## Seealso

Other github: 
`[get_default_github_branch](get_default_github_branch)()`,
`[get_gh_token](get_gh_token)()`,
`[get_latest_commit](get_latest_commit)()`

## Concept

github

## Value

The path to the new file, invisibly.

## Examples

```r
use_github_action_pkgcheck (inputs = list (`post-to-issue` = "false"))
use_github_action_pkgcheck (branch = "main")
```


