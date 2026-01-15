# Helper function to general a 'orgmetrics-config.yaml' file in an r-universe

## Description

This function will create a new file in the location specified by
`dest_dir`, which must then be added to the repository in a commit, and
pushed to the remote location (such as GitHub).

## Usage

```r
orgmetrics_generate_yaml(dest_dir, title = NULL, aggregation_period = 90)
```

## Arguments

* `dest_dir`: Path to local clone of '.r-universe.dev' repository.
* `title`: Title for 'orgmetrics' dashboard.
* `aggregation_period`: Period in days over which prior activity is to be
aggregated.


