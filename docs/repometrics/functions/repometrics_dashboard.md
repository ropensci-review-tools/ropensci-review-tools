# Start quarto dashboard with results of main

## Description

Start quarto dashboard with results of main [repometrics_data_repo](repometrics_data_repo)function.

## Usage

```r
repometrics_dashboard(
  data,
  action = "preview",
  ctb_threshold = NULL,
  max_ctbs = NULL
)
```

## Arguments

* `data`: Data on repository and all contributors as returned from
[repometrics_data](repometrics_data) function applied to one package.
* `action`: One of "preview", to start and open a live preview of the
dashboard website, or "render" to render a static version without previewing
or opening.
* `ctb_threshold`: An optional single numeric value between 0 and 1. If
specified, contributions are arranged in cumulative order, and the
contributor data reduced to only those who contribute to this proportion of
all contributions.
* `max_ctbs`: Optional maximum number of contributors to be included. This
is an alternative way to reduce number of contributors presented in
dashboard, and may only be specified if `ctb_threshold` is left at default
value of `NULL`.

## Concept

dashboard

## Value

(Invisibly) Path to main "index.html" document of quarto site. Note
that the site must be served with `action = "preview"`, and will not work by
simply opening this "index.html" file.


