# List all checks performed

## Description

List all checks performed

## Usage

```r
checks(gp)
```

## Arguments

* `gp`: `[gp](gp)` output.

## Seealso

Other API:
`[customization](customization)`,
`[failed_checks()](failed_checks)`,
`[failed_positions()](failed_positions)`

## Concept

API

## Value

Character vector of check names.

## Examples

```r
path <- system.file("bad1", package = "goodpractice")
# Run a subset of all checks available
g <- gp(path, checks = all_checks()[9:16])
checks(g)
# Or run with named check groups
g <- gp(path, checks = checks_by_group("description", "namespace"))
checks(g)
```


