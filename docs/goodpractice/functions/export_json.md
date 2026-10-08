# Export failed checks to JSON

## Description

Export failed checks to JSON

## Usage

```r
export_json(gp, file, pretty = FALSE)
```

## Arguments

* `gp`: `[gp](gp)` output.
* `file`: Output connection or file.
* `pretty`: Whether to pretty-print the JSON.

## Seealso

Other output:
`[print.goodPractice()](print.goodPractice)`,
`[results()](results)`

## Concept

output

## Value

Invisibly returns the path to the output file.

## Examples

```r
path <- system.file("bad1", package = "goodpractice")
g <- gp(path, checks = "description_url")
tmp <- tempfile(fileext = ".json")
export_json(g, tmp)
unlink(tmp)
```


