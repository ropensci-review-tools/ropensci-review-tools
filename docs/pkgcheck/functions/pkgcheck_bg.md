# Generate report on package compliance with rOpenSci Statistical Software

## Description

Generate report on package compliance with rOpenSci Statistical Software
requirements as background process

## Usage

```r
pkgcheck_bg(path)
```

## Arguments

* `path`: Path to local repository

## Note

The return object will by default display whether it is still running,
or whether it has finished. Once it has finished, the results can be obtained
by calling `$get_result()`, or the main [pkgcheck](pkgcheck) function can be
called to quickly retrieve the main results from local cache.
This function does not accept the `extra_env` parameter of the main
[pkgcheck](pkgcheck) function, and can not be used to run extra, locally-defined
checks.

## Seealso

Other pkgcheck_fns:
`[pkgcheck()](pkgcheck)`,
`[print.pkgcheck()](print.pkgcheck)`

## Concept

pkgcheck_fns

## Value

A `processx` object connecting to the background process
generating the main [pkgcheck](pkgcheck) results (see Note).

## Examples

```r
f <- system.file ("extdata", "pkgstats_9.9.tar.gz", package = "pkgstats")
path <- pkgstats::extract_tarball (f)


# Foreground checks as "blocking" process which will return
# only after all checks have finished:
checks <- pkgcheck (path)

# Or run process in background, do other things in the meantime,
# and obtain checks once they have finished:
ps <- pkgcheck_bg (path)
ps # print status to screen, same as 'ps$print()'
# Once finished, 'pkgcheck' results can be extracted with:
checks <- ps$get_result ()

fs::dir_delete (path)
```


