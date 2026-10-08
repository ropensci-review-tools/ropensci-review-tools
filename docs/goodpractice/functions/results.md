# Return all check results in a data frame

## Description

Return all check results in a data frame

## Usage

```r
results(gp)
```

## Arguments

* `gp`: `[gp](gp)` output.

## Seealso

Other output:
`[export_json()](export_json)`,
`[print.goodPractice()](print.goodPractice)`

## Concept

output

## Value

Data frame, with columns:

## Examples

```r
path <- system.file("bad1", package = "goodpractice")
# Run a subset of all checks available
g <- gp(path, checks = all_checks()[9:16])
results(g)
# Or run with named check groups
g <- gp(path, checks = checks_by_group("description", "namespace"))
results(g)
```


