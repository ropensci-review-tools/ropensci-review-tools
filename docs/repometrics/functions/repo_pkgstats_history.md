# Apply

## Description

Apply `pkgstats` across the git history of a package

## Usage

```r
repo_pkgstats_history(path, date_interval = "month", num_cores = -1L)
```

## Arguments

* `path`: Path to local repository containing an R package.
* `date_interval`: Interval at which to analyse package statistics, with
options of "day", "week", "month", or "year". The last commit for each
period is chosen.
* `num_cores`: Number of cores to use in multi-core processing. Has no
effect on Windows operating systems, on which calculations are always
single-core only. Negative values are subtracted from number of available
cores, determined as `parallel::detectCores()`, so default of `num_cores = -1L` uses `detectCores() - 1L`. Positive values use precisely that number,
restricted to maximum available cores, and a value of zero will use all
available cores.

## Seealso

Other data: 
`[repometrics_data](repometrics_data)()`,
`[repometrics_data_repo](repometrics_data_repo)()`,
`[repometrics_data_user](repometrics_data_user)()`

## Concept

data

## Value

`NULL` if `path` is not an R package, or if no `pkgstats`results are able to be extracted. Otherwise, a list of three items:

* desc_data Containing data from `DESCRIPTION` files, along with data on
numbers of functions.
* loc Containing data on "lines-of-code" for all languages and
sub-directories within package.
* stats Containing statistics on (mean, medium, and sum) of various
properties of each function in package.


