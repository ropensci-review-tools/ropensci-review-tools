# List all implemented CHAOSS metrics

## Description

This function returns a list of internal functions defined within the
'repometrics' package. These internal functions are not intended to be
called directly, rather this list is provided for information only, to
enable users to know which metrics are implemented.

## Usage

```r
rm_metrics_list()
```

## Note

Metrics have been adapted in this package, and so may not precisely
reflect the descriptions provided in the CHAOSS community web pages linked
to in the URLs from this function. Adaptations have in particular been
implemented to align metrics with their usage in aggregate "models".

## Concept

auxiliary

## Value

A `data.frame` with two columns:

1. "fn_names", with the internal function names of all implemented CHAOSS
metrics.
1. "url", with the URL to the CHAOSS community web page describing that
metric.

## Examples

```r
metrics <- rm_metrics_list ()
```


