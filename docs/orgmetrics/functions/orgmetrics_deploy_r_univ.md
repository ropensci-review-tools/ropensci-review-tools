# Deploy a dashboard from an 'r-universe' "packages.json" file.

## Description

Deploy a dashboard from an 'r-universe' "packages.json" file.

## Usage

```r
orgmetrics_deploy_r_univ(
  url = NULL,
  dest_dir = fs::path_temp(),
  title = NULL,
  aggregation_period = 90,
  action = NULL
)
```

## Arguments

* `url`: URL of a '.r-universe.dev' GitHub repository,
containing a "packages.json" file defining the repositories contained within
the 'r-universe'.
If the parameter is not specified, function is presumed to be called within
local version of an r-universe-like repository.
* `dest_dir`: A local directory where all repositories of the specified
'r-universe' will be cloned, and also where data generated for the
'orgmetrics' dashboard will be stored. The default is a temporary path, but
a permanent local path is better for local usage of this function, to avoid
re-generating the same data each time.
* `title`: Title for 'orgmetrics' dashboard. Default is `NULL`, in
which case the title is taken to be the terminal element of `url`.
* `aggregation_period`: Period in days over which prior activity is to be
aggregated.
* `action`: One of "preview", to start and open a live preview of the
dashboard website, "render" to render a static version without previewing
or opening, or `NULL` to set up the quarto structure in the current
temporary directory without doing anything. This option is useful to
generate the dashboard structure so that it can be moved to a non-temporary
location, and deployed or previewed from there.


