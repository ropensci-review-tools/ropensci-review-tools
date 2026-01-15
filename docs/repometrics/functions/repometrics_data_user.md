# Extract and combine data on all contributors to a repository.

## Description

This forms part of the data collated by the main [repometrics_data](repometrics_data)function, along with data on repository structure and historical developed
extracted by the [repometrics_data_repo](repometrics_data_repo) function.

## Usage

```r
repometrics_data_user(
  login,
  end_date = Sys.Date(),
  nyears = 1,
  n_per_page = 100
)
```

## Arguments

* `login`: GitHub login of user
* `end_date`: Parameter used in some aspects of resultant data to limit
the end date of data collection. Defaults to `Sys.Date ()`.
* `nyears`: Parameter <= 1 determining fraction of a year over which data
up until `end_date` are collected.
* `n_per_page`: Number of items per page to pass to GitHub GraphQL API
requests. This should never need to be changed.

## Seealso

Other data: 
`[repo_pkgstats_history](repo_pkgstats_history)()`,
`[repometrics_data](repometrics_data)()`,
`[repometrics_data_repo](repometrics_data_repo)()`

## Concept

data

## Value

A list of the following `data.frame` objects:

1. `commit_cmt` with details of commits made on commits
1. `commits` with summaries of all repositories to which user made commits
1. `followers` A list of followers of specified user
1. `following` A list of other people who nominated user is following
1. `general` with some general information about specified user
1. `issue_cmts` with information on all issue comments made by user
1. `issues` with information on all issues opened by user


