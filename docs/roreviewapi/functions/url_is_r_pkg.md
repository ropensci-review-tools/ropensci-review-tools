# Check whether a given GitHub URL contains an R package.

## Description

Check whether a given GitHub URL contains an R package.

## Usage

```r
url_is_r_pkg(repourl)
```

## Arguments

* `repourl`: Potentially with "/tree/branch_name/sub-directory" appended

## Seealso

Other github: 
`[dl_gh_repo](dl_gh_repo)()`,
`[get_branch_from_url](get_branch_from_url)()`,
`[get_subdir_from_url](get_subdir_from_url)()`,
`[post_to_issue](post_to_issue)()`

## Concept

github

## Value

`TRUE` if 'repourl' is an R package, otherwise `FALSE`


