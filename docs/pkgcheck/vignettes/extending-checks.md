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

1.  `pkg` which summarises data extracted from
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

<details>
<summary>
Click here to see structure of full `pkgcheck` object
</summary>
<p>

This is the output of applying `pkgcheck` to a package generated with
the [`srr` function
`srr_stats_pkg_skeleton()`](https://docs.ropensci.org/srr/reference/srr_stats_pkg_skeleton.html),
with `goodpractice = FALSE` to suppress that part of the results.

    #> List of 4
    #>  $ pkg   :List of 8
    #>   ..$ name        : chr "dummypkg"
    #>   ..$ path        : chr "/tmp/RtmpkguwJc/dummypkg"
    #>   ..$ version     : chr "0.0.0.9000"
    #>   ..$ url         : chr(0) 
    #>   ..$ BugReports  : chr(0) 
    #>   ..$ license     : chr "GPL-3"
    #>   ..$ summary     :List of 12
    #>   .. ..$ num_authors         : int 1
    #>   .. ..$ num_vignettes       : int 0
    #>   .. ..$ num_data            : int 0
    #>   .. ..$ imported_pkgs       : int 1
    #>   .. ..$ num_exported_fns    : int 1
    #>   .. ..$ num_non_exported_fns: int 2
    #>   .. ..$ num_src_fns         : int 2
    #>   .. ..$ loc_exported_fns    : int 3
    #>   .. ..$ loc_non_exported_fns: int 3
    #>   .. ..$ loc_src_fns         : int 5
    #>   .. ..$ num_params_per_fn   : int 0
    #>   .. ..$ languages           : chr [1:2] "C++: 72%" "R: 28%"
    #>   ..$ dependencies:'data.frame': 4 obs. of  2 variables:
    #>   .. ..$ type   : chr [1:4] "depends" "imports" "suggests" "linking_to"
    #>   .. ..$ package: chr [1:4] "NA" "Rcpp" "testthat" "Rcpp"
    #>  $ info  :List of 5
    #>   ..$ git         : list()
    #>   ..$ srr         :List of 5
    #>   .. ..$ message     : chr [1:108] "This package still has TODO standards and can not be submitted" "Package can not be submitted because the following standards [v0.1.0] are missing from your code:" "" "G1.0" ...
    #>   .. ..$ categories  : chr "Regression and Supervised Learning"
    #>   .. ..$ missing_stds: chr "G1.0, G1.4a, G1.6, G2.0a, G2.1a, G2.2, G2.3a, G2.3b, G2.4, G2.4a, G2.4b, G2.4c, G2.4d, G2.4e, G2.5, G2.6, G2.7,"| __truncated__
    #>   .. ..$ report_file : chr "/home/smexus/.cache/pkgcheck/static/dummypkg_srr2021-10-15-16:46:34.html"
    #>   .. ..$ okay        : logi FALSE
    #>   ..$ pkgstats    :'data.frame': 25 obs. of  4 variables:
    #>   .. ..$ measure   : chr [1:25] "files_R" "files_src" "files_vignettes" "files_tests" ...
    #>   .. ..$ value     : num [1:25] 4 2 0 2 10 26 6 0 3 1 ...
    #>   .. ..$ percentile: num [1:25] 23.284 77.356 0 64.15 0.445 ...
    #>   .. ..$ noteworthy: chr [1:25] "" "" "TRUE" "" ...
    #>   .. ..- attr(*, "language")= chr [1:2] "C++: 72%" "R: 28%"
    #>   .. ..- attr(*, "files")= chr [1:2] "C++: 2" "R: 4"
    #>   ..$ network_file: chr "/home/smexus/.cache/pkgcheck/static/dummypkg_pkgstats.html"
    #>   ..$ badges      : list()
    #>  $ checks:List of 12
    #>   ..$ fns_have_exs     : Named logi FALSE
    #>   .. ..- attr(*, "names")= chr "test_fn.Rd"
    #>   ..$ has_bugs         : logi FALSE
    #>   ..$ has_citation     : logi FALSE
    #>   ..$ has_codemeta     : logi FALSE
    #>   ..$ has_contrib_md   : logi FALSE
    #>   ..$ has_scrap        : chr(0) 
    #>   ..$ has_url          : logi FALSE
    #>   ..$ has_vignette     : logi FALSE
    #>   ..$ left_assign      :List of 2
    #>   .. ..$ global: logi FALSE
    #>   .. ..$ usage : Named num [1:2] 2 0
    #>   .. .. ..- attr(*, "names")= chr [1:2] "<-" "="
    #>   ..$ on_cran          : logi FALSE
    #>   ..$ pkgname_available: logi TRUE
    #>   ..$ uses_roxygen2    : logi TRUE
    #>  $ meta  : Named chr [1:3] "0.0.2.25" "0.0.2.96" "0.0.1.120"
    #>   ..- attr(*, "names")= chr [1:3] "pkgstats" "pkgcheck" "srr"
    #>  - attr(*, "class")= chr [1:2] "pkgcheck" "list"
    #> NULL

</p>
</details>

## 1. The check function

An example is the check for whether a package has a citation, [defined
in
`R/check_has_citation.R`](https://github.com/ropensci-review-tools/pkgcheck/blob/main/R/check-has-citation.R):

``` r
#' Check whether a package has a `inst/CITATION` file.
#'
#' "CITATION" files are required for all rOpenSci packages, as documented [in
#' our "*Packaging
#' Guide*](https://devguide.ropensci.org/building.html#citation-file). This does
#' not check the contents of that file in any way.
#'
#' @param checks A 'pkgcheck' object with full \pkg{pkgstats} summary and
#' \pkg{goodpractice} results.
#' @noRd
pkgchk_has_citation <- function (checks) {

    "CITATION" %in% list.files (fs::path (checks$pkg$path, "inst"))
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

<div class="alert alert-info">

- *Any information needed when summarising or printing the check result
  should be returned from the main check function.*

</div>

A second important principle is that,

<div class="alert alert-info">

- *Check functions should never return `NULL`, rather should always
  return an empty vector (such as `integer(0)`)*.

</div>

The following section considers how these return values from check
functions are converted to `summary` and `print` output.

## 2. The output function

All `output_pkgchk_...()` functions must also accept the single input
parameter of `checks`, in which the `checks$checks` sub-list will
already have been populated by calling all `pkgchk_...()` functions
described in the previous section. The `pkgchk_has_citation()` function
will create an entry of `checks$checks$has_citation` which contains the
binary flag indicating whether or not a `"CITATION"` file is present.
Similarly, the [the `pkgchk_has_scrap()`
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

    # disabled:
    # https://github.com/ropensci-review-tools/pkgcheck/issues/115
    # out$summary <- paste0 (
    #    ifelse (out$check_pass, "has", "does not have"),
    #    " a 'CITATION' file."
    # )

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
    - A `msg_pre` to display at the start of the `print` result;
    - An `object` to be printed, such as a vector of values, or a
      `data.frame`.
    - A `msg_post` to display at the end of the `print` result following
      the `object`.

`summary` and `print` methods may be suppressed by assigning values of
`""`. The above example of `pkgcheck_has_citation` has `print = ""`, and
so no information from this check will appear as output of the `print`
method. The `summary` field is commented-out in the current version, but
left to illustrate here that it has a value that is specified for both
`TRUE` and `FALSE` values of `check_pass`, via an `ifelse` statement.
The value is determined by the result of the main
`pkgchk_has_citation()` call, and is converted into a green tick if
`TRUE`, or a red cross if `FALSE`.

Checks for which `print` information is desired require a non-empty
`print` item, as in the [`output_pkgchk_has_scrap()`
function](https://github.com/ropensci-review-tools/pkgcheck/blob/main/R/check-scrap.R):

``` r
output_pkgchk_has_scrap <- function (checks) {

    out <- list (
        check_pass = length (checks$checks$has_scrap) == 0L,
        summary = "",
        print = ""
    )

    if (!out$check_pass) {
        out$summary <- "Package contains unexpected files."
        out$print <- list (
            msg_pre = paste0 (
                "Package contains the ",
                "following unexpected files:"
            ),
            obj = checks$checks$has_scrap,
            msg_post = character (0)
        )
    }

    return (out)
}
```

In this case, both `summary` and `print` methods are only triggered
`if (!out$check_pass)` – so only if the check fails. The `print` method
generates the heading specified in `out$print$msg_pre`, with any
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

### 3.1 New Local Checks (*for package users*)

The [main `pkgcheck()`
function](https://docs.ropensci.org/pkgcheck/reference/pkgcheck.html)
has an additional parameter, `extra_env` which specifies,

> Additional environments from which to collate checks. Other package
> names may be appended using c, as in c(.GlobalEnv, “mypkg”).

This allows specific checks to be defined locally, and run by passing
the name of the environment in which those checks are defined in this
parameter. This section illustrates the process using the bundled
“tarball” (that is, `.tar.gz` file) of one version of [the `pkgstats`
package](https://github.com/ropensc-review-tools/pkgstats) included with
that package.

``` r
f <- system.file ("extdata", "pkgstats_9.9.tar.gz", package = "pkgstats")
path <- pkgstats::extract_tarball (f)
checks <- pkgcheck (path)
summary (checks)
```

    #> 
    #> ── pkgstats 9.9 ───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
    #> 
    #> ✔ Package name is available
    #> ✖ does not have a 'codemeta.json' file.
    #> ✖ does not have a 'contributing' file.
    #> ✔ uses 'roxygen2'.
    #> ✔ 'DESCRIPTION' has a URL field.
    #> ✔ 'DESCRIPTION' has a BugReports field.
    #> ✖ Package has no HTML vignettes
    #> ✖ These functions do not have examples: [pkgstats_from_archive].
    #> ✔ Package has continuous integration checks.
    #> ✖ Package coverage failed
    #> ✖ R CMD check found 1 error.
    #> ✔ R CMD check found no warnings.
    #> 
    #> ℹ Current status:
    #> ✖ This package is not ready to be submitted.

Let’s now presume I have a reputation in the R community for all of my
packages starting with “aa”, to ensure they are always listed first.
This section demonstrates how to implement a check that only passes if
the first two letters of the package name are “aa”. The first step
described above is to define the check itself via a function prefixed
with `pkgchk_`. The easiest approach would be for the `pkgcheck_`
function to directly check the name, and return a logical flag
indicating whether or not the same starts with “aa”. The resultant
`summary` and `print` methods can, however, only use the information
provided by the initial `pkgchk_` function. That means if we want to
print the actual name in the result of either of those functions, to
show that it indeed does not form the desired patter, we need to return
that information. The check function is then simply:

``` r
pkgchk_starts_with_aa <- function (checks) {
    checks$pkg$name
}
```

We then need to define the output functions:

``` r
output_pkgchk_starts_with_aa <- function (checks) {

    out <- list (
                 check_pass = grepl ("^aa",
                                     checks$checks$starts_with_aa,
                                     ignore.case = TRUE),
                 summary = "",
                 print = ""
    )

    out$summary <- paste0 ("Package name [",
                           checks$checks$starts_with_aa,
                           "] does ",
                           ifelse (out$check_pass,
                                   "",
                                   "NOT"),
                           " start with 'aa'")

    return (out)
}
```

If we simply define those function in the global workspace of our
current R session, calling `pkgcheck()` again will automatically detect
those checks and include them in our output:

    #> 
    #> ── pkgstats 9.9 ───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
    #> 
    #> ✔ Package name is available
    #> ✖ does not have a 'codemeta.json' file.
    #> ✖ does not have a 'contributing' file.
    #> ✔ uses 'roxygen2'.
    #> ✔ 'DESCRIPTION' has a URL field.
    #> ✔ 'DESCRIPTION' has a BugReports field.
    #> ✖ Package has no HTML vignettes
    #> ✖ These functions do not have examples: [pkgstats_from_archive].
    #> ✔ Package has continuous integration checks.
    #> ✖ Package coverage failed
    #> ✖ Package name [pkgstats] does NOT start with 'aa'
    #> ✖ R CMD check found 1 error.
    #> ✔ R CMD check found no warnings.
    #> 
    #> ℹ Current status:
    #> ✖ This package is not ready to be submitted.

Customised personal checks can be incorporated by defining them in a
local package, loading that into the workspace, and passing the name of
the package to the `extra_env` parameter.

### 3.2 New `pkgcheck` Checks (*for `pkgcheck` developers*)

New checks can be added to this package by creating new files in the
`/R` directory prefixed with `pkgchk_`, and including the two functions
described above (a check and an output function). The check name will
then need to be included in [the `order_checks()` function in the
`R/summarise-checks.R`
file](https://github.com/ropensci-review-tools/pkgcheck/blob/6c99a804cea99af4fca8e27e41784ecd6b7f1501/R/summarise-checks.R#L92-L114),
which determines the order of checks in the `summary` output. Checks
which are not defined in this ordering, including any defined via
`extra_env` parameters, appear *after* all of the standard checks, and
prior to the `R CMD check` results which always appear last. This order
may only be modified by editing the list in that function. The order of
check results in the `print` method is also hard-coded, defined in the
[main `print.pkgcheck`
method](https://github.com/ropensci-review-tools/pkgcheck/blob/main/R/pkgcheck-methods.R).
As explicitly stated in that function, any new checks should also be
included in the `print` method just after [the first reference to
`"misc_checks"`](https://github.com/ropensci-review-tools/pkgcheck/blob/2e025c276c84b45bc46f72ec5d8b029de83ac211/R/pkgcheck-methods.R#L65-L71),
via an additional line:

``` r
print_check_screen (x, "<name-of-new-check>", pkg_env)
```

The `print_check_screen()` function will then automatically activate the
`print` method of any new checks. This line should be added even if a
new check has no `print` method (as in the `starts_with_aa` example
above), to provide an explicit record of all internally-defined
miscellaneous checks.

Finally, any new checks also need to be included in tests. The test
suites run on generic, mostly empty packages constructed with [the
`srr::srr_stats_pkg_skeleton()`
function](https://docs.ropensci.org/srr/reference/srr_stats_pkg_skeleton.html),
as in the [main `test-pkgcheck.R` test
functions](https://github.com/ropensci-review-tools/pkgcheck/blob/main/tests/testthat/test-pkgcheck.R).
Additional tests are also performed on the `pkgstats` tarball
illustrated above. The default results of any new checks will be
automatically tested by the existing test suite, but it is important to
test all potential results. The [`test-extra-checks.R`
file](https://github.com/ropensci-review-tools/pkgcheck/blob/main/tests/testthat/test-extra-checks.R)
is the main location for testing additional tests, with lines in that
file demonstrating how the main results can be readily modified to
reflect alternative outputs of check functions (such as
`pkgchk_has_scrap` and `pkgchk_obsolete_pkg_deps`). The output functions
defined as part of checks, including any new checks, do not need to be
explicitly tested, as the entire output is tested via [`testthat`
snapshots](https://testthat.r-lib.org/articles/snapshotting.html).
Snapshot results need to be updated to reflect any additional tests.
Finally, the [`test-list-checks.R`
file](https://github.com/ropensci-review-tools/pkgcheck/blob/main/tests/testthat/test-list-checks.R)
tests the total number of internally-defined checks as
`expect_length (ncks, ..)`. The number tested there also needs to be
incremented by one for each new check.
