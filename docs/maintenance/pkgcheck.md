
# pkgcheck

Maintenance of `pkgcheck` package.

## Adding new checks

The procedure for adding new checks is documented in the ["*Extending or
modifying checks*" vignette](/pkgcheck/vignettes/extending-checks) within the
`pkgcheck` package. The
[`roreviewapi`](https://github.com/ropensci-review-tools/roreviewapi) package
which delivers the checks to rOpenSci's GitHub issues directly dumps all checks
currently delivered by `pkgcheck`. See the following section for options for
restricting which checks are delivered.

## Controlling checks in [`roreviewapi`](https://github.com/ropensci-review-tools/roreviewapi)

The addition of new checks is fairly straightforward, and described in the
above section, along with corresponding links. The remainder of this section
describes how the `roreviewapi` may be modified to deliver a reduced set of
checks than the full set returned by `pkgcheck`.

The plumber endpoint for editor checks is entirely controlled by the
[`roreviewapi::editor_check()`
function](https://github.com/ropensci-review-tools/roreviewapi/blob/main/R/editor-check.R).
The main call is via `tryCatch` to ensure any errors are captured:

``` r
checks <- tryCatch (pkgcheck::pkgcheck (path),
                    error = function (e) e)
```

The return object, `checks`, is a list of checks ultimately composed in the
[main `pkgcheck()` function
definition](https://github.com/ropensci-review-tools/pkgcheck/blob/main/R/pkgcheck-fn.R).
The easiest way to remove checks from the
[`roreviewpi`](https://github.com/ropensci-review-tools/roreviewapi) without
modifying the underlying structure of `pkgcheck` itself is to run the checks as
above, and then remove the corresponding list items. For example, the following
modification would suffice to remove the `scrap` check (which checks whether a
repository contains "scrap" files which should not be included) from the API
endpoint:

``` r
checks <- tryCatch (pkgcheck::pkgcheck (path),
                    error = function (e) e)
checks$scrap <- NULL
```

When those checks are printed (via `print`) or summarised (via `summarise`),
the scrap checks will not be reported on. This procedure can be used to remove
checks from the `roreviewapi` results, by finding the line in [the
`roreviewapi::editor_check()`
function](https://github.com/ropensci-review-tools/roreviewapi/blob/main/R/editor-check.R)
where the main `pkgcheck::pkgcheck()` function is called, and then removing any
checks immediately afterward by setting them to `NULL`. Those checks will then
be removed from the report delivered by
[`roreviewpi`](https://github.com/ropensci-review-tools/roreviewapi), and
therefore by the `ropensci-review-bot`.
