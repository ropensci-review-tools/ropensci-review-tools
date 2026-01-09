# Get GitHub token

## Description

Get GitHub token

## Usage

```r
get_gh_token(token_name = "")
```

## Arguments

* `token_name`: Optional name of token to use

## Seealso

Other github: 
`[get_default_github_branch](get_default_github_branch)()`,
`[get_latest_commit](get_latest_commit)()`,
`[use_github_action_pkgcheck](use_github_action_pkgcheck)()`

## Concept

github

## Value

The value of the GitHub access token extracted from environment
variables.

## Examples

```r
token <- get_gh_token ()
```


