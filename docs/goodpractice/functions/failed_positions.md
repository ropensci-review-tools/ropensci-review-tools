# Positions of check failures in the source code

## Description

Note that not all checks refer to the source code.
For these the result will be `NULL`.

## Usage

```r
failed_positions(gp)
```

## Arguments

* `gp`: `[gp](gp)` output.

## Details

For the ones that do, the results is a list, one for each failure.
Since the same check can fail multiple times. A single failure
is a list with entries: `filename`, `line_number`,
`column_number`, `ranges`. `ranges` is a list of
pairs of start and end positions for each line involved in the
check.

## Seealso

Other API:
`[checks()](checks)`,
`[customization](customization)`,
`[failed_checks()](failed_checks)`

## Concept

API

## Value

A list of lists of positions. See details below.

## Examples

```r
path <- system.file("bad1", package = "goodpractice")
g <- gp(path, checks = "description_url")
failed_positions(g)
```


