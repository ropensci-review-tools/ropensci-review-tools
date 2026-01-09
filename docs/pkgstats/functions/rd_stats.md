# Stats from '.Rd' files

## Description

Stats from '.Rd' files

## Usage

```r
rd_stats(path)
```

## Arguments

* `path`: Directory to source code of package being analysed

## Seealso

Other stats: 
`[desc_stats](desc_stats)()`,
`[loc_stats](loc_stats)()`,
`[pkgstats](pkgstats)()`,
`[pkgstats_summary](pkgstats_summary)()`

## Concept

stats

## Value

A `data.frame` of function names and numbers of parameters and lines
of documentation for each, along with mean and median numbers of characters
used to document each parameter.

## Examples

```r
f <- system.file ("extdata", "pkgstats_9.9.tar.gz", package = "pkgstats")
# have to extract tarball to call function on source code:
path <- extract_tarball (f)
rd_stats (path)
```


