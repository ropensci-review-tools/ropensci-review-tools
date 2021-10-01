# Extending or modifying checks

This vignette describes how to modify or extend the existing suite of
checks implemented by `pkgcheck`. Each of the internal checks is defined
in a separate file in the `R` directory of this package with the prefix
of `check_` (or `checks_` for files which define multiple, related
checks). Checks only require two main functions, the first defining the
check itself, and the second defining `summary` and `print` methods
based on the result of the first function. The check functions must have
a prefix `pkgchk_`, and the second functions defining output methods
specifying must have a prefix `output_pkgchk_`. These two kind of
function are now described in the following two sections.

Both of these functions must also accept a single input parameter of a
`pkgcheck` object, by convention named `checks`. This object is a list
of four main items:

1.  `package` which summarises data extracted from
    [`pkgstats::pkgstats()`](https://docs.ropensci.org/pkgstats/reference/pkgstats.html),
    and includes essential information on the package being checked.
2.  `info` which contains information used in checks, including
    `info$git` detailing git repository information, `info$pkgstats`
    containing a summary of a few statistics generated from
    [`pkgstats::pkgstats()`](https://docs.ropensci.org/pkgstats/reference/pkgstats.html),
    along with statistical comparisons against distributions from all
    current CRAN packages, an `info$network_file` specifying a local
    directory to a [`vis.js`](https://visjs.org) visualisation of the
    function call network of the package, and an `info$badges` item
    containing information from GitHub workflows and associated badges,
    where available.
3.  `checks` which contains a list of all objects returned from all
    `pkgchk_...()` functions, which are used as input to
    `output_pkgchk_...()` functions.
4.  `meta` containing a named character vector of versions of the core
    packages used in `pkgcheck`.

`pkgcheck` objects generally also include a fifth item, `goodpractice`,
containing the results of [`goodpractice`
checks](https://github.com/MangoTheCat/goodpractice). The `checks` item
passed to each `pkgchk_...()` function contains all information on the
`package`, `info`, `meta`, and (optionally) `goodpractice` items. Checks
may use any of this information, or even add additional information as
demonstrated below. The `checks$checks` list represents the output of
check functions, and may not be used in any way within `pkgchk_...()`
functions.

## 1. The check function

An example is the check for whether a package has a citation, [defined
in
`R/check_has_citation.R`](https://github.com/ropensci-review-tools/pkgcheck/blob/main/R/check-has-citation.R):

``` r
#' Check whether a package has a `inst/CITATION` file
#'
#' This does not check the contents of that file in any way.
#'
#' @param checks A 'pkgcheck' object with full \pkg{pkgstats} summary and
#' \pkg{goodpractice} results.
#' @noRd
pkgchk_has_citation <- function (checks) {
    "CITATION" %in% list.files (file.path (checks$package$path, "inst"))
}
```

This check is particularly simple, because a `"CITATION"` file [must
have exactly that name, and must be in the `inst`
sub-directory](https://cran.r-project.org/doc/manuals/R-exts.html#CITATION-files).
This function returns a simple logical of `TRUE` if the expected
`"CITATION"` file is present, otherwise it returns `FALSE`. This
function, and all functions beginning with the prefix `pkgchk_`, will be
automatically called by the main `pkgcheck()` function, and the value
stored in `checks$checks$has_citation`. The name of the item within the
`checks$checks` list is the name of the function with the `pkgchk_`
prefix removed.

A more complicated example is the function to check whether a package
contains files which should not be there – internally called “scrap”
files. The check function itself, [defined in
`R/check-scrap.R`](https://github.com/ropensci-review-tools/pkgcheck/blob/main/R/check-scrap.R),
checks for the presence of files matching an internally-defined list
including files used to locally cache folder thumbnails such as
`".DS_Store"` or `"Thumbs.db"`. The function returns a character vector
of the names of any “scrap” files which can be used by the `print`
method to provide details of files which should be removed. This
illustrates the first general principle of these check functions; that,

-   *Any information needed when summarising or printing the check
    result should be returned from the main check function.*

A second important principle is that,

-   *Check functions should never return `NULL`, rather should always
    return an empty vector (such as `integer(0)`)*.

The following section considers how these return values from check
functions are converted to `summary` and `print` output.

## 2. The output function

All `output_pkgchk_...()` functions must also accept the single input
parameter of `checks`, in which the `checks$checks` sub-list will
already have been populated by calling all `pkgchk_...()` functions
described in the previous section. The `pkgchk_has_citation()` function
will create an entry of `checks$checks$has_ci` which contains the binary
flag indicating whether or not a `"CITATION"` file is present, and [the
`pkgchk_has_scrap()`
function](https://github.com/ropensci-review-tools/pkgcheck/blob/main/R/check-scrap.R)
will create `checks$checks$has_scrap` which will contain names of any
scrap files present, and a length-zero vector otherwise.

The `output_pkgchk_has_citation()` function then looks like this:

``` r
output_pkgchk_has_citation <- function (checks) {
    out <- list (
        check_pass = checks$checks$has_citation,
        summary = "",
        print = ""
    )

    out$summary <- paste0 (
        ifelse (out$check_pass, "has", "does not have"),
        " a 'CITATION' file."
    )

    return (out)
}
```

The first lines are common to all `output_pkgchk_...()` functions, and
define the generic return object. This object must be a list with the
following three items:

1.  `check_pass` as binary flag indicating whether or not a check was
    passed;
2.  `summary` containing text used to generate the `summary` output; and
3.  `print` containing information used to generate the `print` output,
    itself a `list` of the following items:
    -   A `message` to display at the start of the `print` result; and
    -   An `object` to be printed, such as a vector of values, or a
        `data.frame`.

The [`output_pkgchk_has_scrap()`
function](https://github.com/ropensci-review-tools/pkgcheck/blob/main/R/check-scrap.R)
includes a print method:

``` r
output_pkgchk_has_scrap <- function (checks) {
    out <- list (
        check_pass = length (checks$checks$scrap) == 0L,
        summary = "",
        print = ""
    )

    if (!out$check_pass) {
        out$summary <- "Package contains unexpected files."
        out$print <- list (
            message = paste0 (
                "Package contains the ",
                "following unexpected files:"
            ),
            obj = checks$checks$scrap
        )
    }

    return (out)
}
```

Both `summary` and `print` methods are only triggered
`if (!out$check_pass)` – so only if the check fails. The `print` method
generates the heading specified in `out$print$message`, with any
vector-valued objects stored in the corresponding `obj` list item
displayed as formatted lists. A package with “scrap” files, `"a"` and
`"b"`, would thus have `out$print$obj <- c ("a", "b")`, and when printed
would look like this:

    #> ✖ Package contains the following unexpected files:
    #> • a
    #> • b

This formatting is also translated into corresponding markdown and HTML
formatting in [the `checks_to_markdown()`
function](https://github.com/ropensci-review-tools/pkgcheck/blob/main/R/format-checks.R).

The design of these `pkgchk_` and `output_pkgchk_` functions aims to
make the package readily extensible, and we welcome discussions about
developing new checks. The primary criterion for new package-internal
checks is that they must be of very general applicability, in that they
should check for a condition that *almost* every package should or
should not meet.

The package also has a mechanism to easily incorporate more specific,
locally-defined checks, as explored in the following section.

## 3. Creating new checks

(Coming soon …)
