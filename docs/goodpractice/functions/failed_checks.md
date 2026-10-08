# Names of the failed checks

## Description

Names of the failed checks

## Usage

```r
failed_checks(gp)
```

## Arguments

* `gp`: `[gp](gp)` output.

## Seealso

Other API:
`[checks()](checks)`,
`[customization](customization)`,
`[failed_positions()](failed_positions)`

## Concept

API

## Value

Names of the failed checks.

## Examples

```r
path <- system.file("bad1", package = "goodpractice")
# run a subset of all checks available
g <- gp(path, checks = all_checks()[9:16])
failed_checks(g)
# Or run with named check groups
g <- gp(path, checks = checks_by_group("description", "namespace"))
failed_checks(g)
```


