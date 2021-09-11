# pkgcheck

<!-- badges: start -->

[![R build
status](https://github.com/ropensci-review-tools/pkgcheck/workflows/R-CMD-check/badge.svg)](https://github.com/ropensci-review-tools/pkgcheck/actions?query=workflow%3AR-CMD-check)
[![gitlab
push](https://github.com/ropensci-review-tools/pkgcheck/workflows/push-to-gitlab/badge.svg)](https://github.com/ropensci-review-tools/pkgcheck/actions?query=workflow%3Apush-to-gitlab)
[![codecov](https://codecov.io/gh/ropensci-review-tools/pkgcheck/branch/main/graph/badge.svg)](https://codecov.io/gh/ropensci-review-tools/pkgcheck)
[![Project Status:
Concept](https://www.repostatus.org/badges/latest/concept.svg)](https://www.repostatus.org/#concept)
<!-- badges: end -->

Check whether a package is ready for submission to
[rOpenSci](https://ropensci.org)’s peer review system. The primary
function collates the output of
[`goodpractice`](https://github.com/mangothecat/goodpractice), including
`R CMD check` results, along with a number of statistics via the
[`pkgstats` package](https://github.com/ropensci-review-tools/pkgstats),
and package structure checks expected for rOpenSci submissions. The
output of this function immediately indicates whether or not a package
is “Ready to Submit”.

## Installation

The easiest way to install this package is via the [associated
`r-universe`](https://ropensci-review-tools.r-universe.dev/ui#builds).
As shown there, simply enable the universe with

``` r
options(repos = c(
    ropenscireviewtools = "https://ropensci-review-tools.r-universe.dev",
    CRAN = "https://cloud.r-project.org"))
```

And then install the usual way with,

``` r
install.packages("pkgcheck")
```

Alternatively, the package can be installed by running one of the
following lines:

``` r
remotes::install_github ("ropensci-review-tools/pkgcheck")
pak::pkg_install ("ropensci-review-tools/pkgcheck")
```

The package can then loaded for use with

``` r
library (pkgcheck)
```

## Setup

The [`pkgstats`
package](https://github.com/ropensci-review-tools/pkgstats) also
requires the system libraries [`ctags`](https://ctags.io) and [GNU
`global`](https://www.gnu.org/software/global/) to be installed.
Procedures to install these libraries on various operating systems are
described in the [`pkgstats`
README](https://docs.ropensci.org/pkgstats). This package also uses the
[GitHub GraphQL API](https://developer.github.com/v4) which requires a
local GitHub token to be stored with an unambiguous name including
`GITHUB`, such as `GITHUB_TOKEN` (recommended), or `GITHUB_PAT` (for
Personal Authorization Token). This can be obtained from GitHub (via
your user settings), and stored using

``` r
Sys.setenv("GITHUB_TOKEN" = "<my_token>")
```

This can also be set permanently by putting this line in your
`~/.Renviron` file (or creating this if it does not yet exist). Once
`pkgstats` has been successfully installed, the `pkgcheck` package can
then be loaded via a `library` call:

``` r
library(pkgcheck)
```

## Usage

The package primarily has one function, `pkgcheck`, which accepts the
single argument, `path`, specifying the local location of a git
repository to be analysed. The following code generates a reproducible
report by first downloading a local clone of a repository called
[`srr-demo`](https://github.com/mpadge/srr-demo), which contains the
skeleton of an [`srr` (Software Review Roclets)
package](https://github.com/ropensci-review-tools/srr), generated with
the [`srr_stats_pkg_skeleton()`
function](https://docs.ropensci.org/srr/reference/srr_stats_pkg_skeleton.html):

``` r
mydir <- file.path (tempdir (), "srr-demo")
gert::git_clone ("https://github.com/mpadge/srr-demo", path = mydir)
x <- pkgcheck (mydir)
```

That object has default `print` and `summary` methods. The latter can be
used to simply check whether a package is ready for submission:

``` r
summary (x)
## 
## ── demo 0.0.0.9000 ───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
## 
## ✔ Package uses 'roxygen2'
## ✖ Package does not have a 'contributing.md' file
## ✖ Package does not have a 'CITATION' file
## ✖ Package does not have a 'codemeta.json' file
## ✔ All functions have examples
## ✔ Package 'DESCRIPTION' has a URL field
## ✖ Package 'DESCRIPTION' does not have a BugReports field
## ✔ Package name is available
## ✖ Package has no continuous integration checks
## ✖ Package coverage is 0% (should be at least 75%)
## ✔ R CMD check found no errors
## ✔ R CMD check found no warnings
## ✔ All applicable standards [v0.0.1] have been documented in this package
## 
## ℹ Current status:
## ✖ This package is not ready to be submitted
## 
```

A package may only be submitted when the summary contains all ticks and
no cross symbols. (These symbols are colour-coded with green ticks and
red crosses when generated in a terminal; GitHub markdown only renders
them in black-and-white.) The object returned from the `pkgcheck`
function is a complex nested list with around a dozen primary
components. Full information can be obtained by simply calling the
default `print` method by typing the object name (`x`).

## What is checked?

### Summary of Check Results

Calling `summary()` on the object returned by the [`pkgcheck()`
function](https://docs.ropensci.org/pkgcheck/reference/pkgcheck.html)
will generate a checklist like that shown above. This checklist will
also be automatically generated when a package is first submitted to
rOpenSci, and is used by the editors to assess whether to process a
submission. Authors must ensure prior to submission that there are no
red crosses in the resultant list. (In the unlikely circumstances that a
package is unable to pass particular checks, explanations should be
given upon submission about why those checks fail, and why review may
proceed in spite of such failures.)

The full list of checks which packages are expected to pass currently
includes:

1.  Package must use
    [`roxygen2`](https://devguide.ropensci.org/building.html#roxygen2-use)
    for documentation.
2.  Package must have a [`contributing.md`
    file](https://devguide.ropensci.org/collaboration.html#contributing-guide).
3.  Package must have a [`CITATION` file in the `inst`
    directory](https://cran.r-project.org/doc/manuals/r-release/R-exts.html#CITATION-files).
4.  Package must have a [`codemeta.json`
    file](https://devguide.ropensci.org/building.html#creating-metadata-for-your-package).
5.  All exported functions must include examples in their documentation.
6.  Left-assign operators must be used consistently throughout all code
    (so either all `=` or all `<-`, but not a mixture of both).
7.  Package `DESCRIPTION` file must have a “URL” field.
8.  Package `DESCRIPTION` file must have a “BugReports” field.
9.  Package name must be available (or package must already be) on CRAN.
10. Package must have continuous integration tests.
11. Package must have test coverage of at least 75%.
12. No function should have a [cyclomatic
    complexity](https://github.com/MangoTheCat/cyclocomp) of 15 or
    greater.
13. `R CMD check` (implemented via the [`rcmdcheck`
    package](https://r-lib.github.io/rcmdcheck/)) must generate no
    warnings or errors.
14. All statistical standards must be documented, as confirmed by the
    [`srr::srr_pre_submit()`
    function](https://docs.ropensci.org/srr/reference/srr_stats_pre_submit.html).

Several of these are by default only shown when they fail; absence from
a resultant checklist may be interpreted to indicate successful checks.

### Detailed Check Results

Full details of check results can be seen by `print`-ing the object
returned by the [`pkgcheck()`
function](https://docs.ropensci.org/pkgcheck/reference/pkgcheck.html)
(or just by typing the name of this object in the console.) This object
is itself a list including the following items:

``` r
names (x)
```

    ##  [1] "package"      "version"      "url"          "license"      "summary"     
    ##  [6] "git"          "srr"          "file_list"    "fns_have_exs" "left_assigns"
    ## [11] "pkgstats"     "network_file" "gp"           "scrap"        "pkg_versions"

The first four of these contain information on the package. The
remainder include:

-   `summary` containing summary statistics on package structure (such
    as lines of code, and numbers of files and functions).
-   `git` containing information and statistics on the `git` repository
    associated with a package (if any), including date of first commit,
    total number of commits and of committers.
-   `srr` summarising information on statistical packages generated by
    the [`srr` package](https://github.com/ropensci-review-tools/srr),
    including a link to a locally-generated HTML report on standards
    compliance.
-   `file_list` as a list of binary flags denoting presence of absence
    of all files required for an R package to be submitted to rOpenSci
-   `fns_have_exs` with a list of any functions which do not have
    documented examples
-   `left_assigns` with a logical value indicating whether or not global
    assignment operators (`<<-`) are used; and a tally of the two types
    of left-assignment operators (`<-` and `=`). One one of these should
    be non-zero, reflecting consistent usage of the same type.
-   `pkgstats` containing several statistics of package structure, along
    with associated percentiles assessed against the entire distribution
    of all current CRAN packages.
-   `network_file` with the path to a local HTML file containing a
    [.visjs](https://visjs.org/) representation of the network of
    relationships between objects (such as functions) within a package,
    within and between each computer language used in the package.
-   `gp` containing the output of the [`goodpractice`
    pacakge](http://mangothecat.github.io/goodpractice/), itself
    including results from:
    -   the [`rcmdcheck` pacakge](https://r-lib.github.io/rcmdcheck) for
        running `R CMD check`
    -   the [`covr` package](https://covr.r-lib.org) for assessing code
        coverage
    -   the [`cyclocomp`
        package](https://github.com/MangoTheCat/cyclocomp) for
        quantifying the cyclomatic complexity of package functions
    -   the [`desc` package](https://github.com/r-lib/desc#readme) for
        analysing the structure of `DESCRIPTION` files
    -   the [`lintr` package](https://github.com/jimhester/lintr)
    -   additional checks applied by the [`goodpractice`
        pacakge](http://mangothecat.github.io/goodpractice/)

Note that results from [`lintr`
package](https://github.com/jimhester/lintr) are **not** reported in the
check summary, and that [`lintr`
results](https://github.com/jimhester/lintr) are reported only in the
detailed results, and have no influence on whether a package passes the
summary checks.

### HTML-formatted check results

Printing `pkgcheck` results to screen is nice, but sometimes it’s even
better to have a nicely formatted full-screen representation of check
results. The package includes an additional function,
[`checks_to_markdown()`](https://docs.ropensci.org/pkgcheck/reference/checks_to_markdown.html),
with a parameter, `render`, which can be set to `TRUE` to automatically
render a HTML-formatted representation of the check results, and open it
in a browser. The formatting differs only slightly from the terminal
output, mostly through the components of
[`goodpractice`](http://mangothecat.github.io/goodpractice/) being
divided into distinct headings, with explicit statements in cases where
components pass all checks (the default screen output inherits directly
from that package, and only reports components which *do not* pass all
checks).

This
[`checks_to_markdown()`](https://docs.ropensci.org/pkgcheck/reference/checks_to_markdown.html)
function returns the report in markdown format, suitable for pasting
directly into a GitHub issue, or other markdown-compatible place. (The
[`clipr` package](https://github.com/mdlincoln/clipr) can be used to
copy this directly to your local clipboard with `write_clip(md)`, where
`md` is the output of `checks_to_markdown()`.)

## Caching and running `pkgcheck` in the background

Running the [`pgkcheck`
function](https://docs.ropensci.org/pkgcheck/reference/pkgcheck.html)
can be time-consuming, primarily because the
[`goodpractice`](https://github.com/mangothecat/goodpractice) component
runs both a full `R CMD check`, and calculates code coverage of all
tests. To avoid re-generating these results each time, the package saves
previous reports to a local cache, in a `pkgcheck` subdirectory of the
location determined by

``` r
rappdirs::user_cache_dir()
```

As explained in the help file for that function, these locations are:

| System   | location                                                                                                 |
|----------|----------------------------------------------------------------------------------------------------------|
| Mac OS X | `~/Library/Caches/pkgcheck`                                                                              |
| Linux    | `~/.cache/pkgcheck`                                                                                      |
| Win XP   | `C:\\Documents and Settings\\<username>\\Local Settings\\Application Data\\<AppAuthor>\\pkgcheck\\Cache` |
| Vista    | `C:\\Users\\<username>\\AppData\\Local\\<AppAuthor>\\pkgcheck\\Cache`                                    |

You may manually erase the contents of this `pkgcheck` subdirectory at
any time at no risk beyond additional time required to re-generate
contents. This default location may also be over-ridden by setting an
environmental variable named `PKGCHECK_CACHE_DIR`. By default checks
presume packages use `git` for version control, with checks updated only
when code is updated via `git commit`. Checks for packages that do not
use `git` are updated when any files are modified.

The first time
[`pkgcheck()`](https://docs.ropensci.org/pkgcheck/reference/pkgcheck.html)
is applied to a package, the checks will be stored in the cache
directory. Calling that function a second time will then load the cached
results, and so enable checks to be returned much faster. For code which
is frequently updated, such as for packages working on the final stages
prior to submission, it may still be necessary to repeatedly call
[`pkgcheck()`](https://docs.ropensci.org/pkgcheck/reference/pkgcheck.html)
after each modification, a step which may still be inconveniently
time-consuming. To facilitate frequent re-checking, the package also has
a [`pkgcheck_bg()`
function](https://docs.ropensci.org/pkgcheck/reference/pkgcheck_bg.html)
which is effectively identical to the main [`pkgcheck()`
function](https://docs.ropensci.org/pkgcheck/reference/pkgcheck.html),
except it runs in the background, enabling you to continue coding while
checks are running.

The [`pkgcheck_bg()`
function](https://docs.ropensci.org/pkgcheck/reference/pkgcheck_bg.html)
returns a handle to the [`callr::r_bg()`
process](https://callr.r-lib.org/reference/r_bg.html) in which the
checks are running. Typing the name of the returned object will
immediately indicate whether the checks are still running, or whether
they have finished. That handle is itself an [`R6`
object](http://r6.r-lib.org/) with a number of methods, notably
including
[`get_result()`](https://callr.r-lib.org/reference/get_result.html)
which can be used to access the checks once the process has finished.
Alternatively, as soon as the background process, the normal
(foreground) [`pkgcheck()`
function](https://docs.ropensci.org/pkgcheck/reference/pkgcheck.html)
may be called to quickly re-load the cached results.

## Prior Work

[The `checklist` package](https://github.com/inbo/checklist) for
“checking packages and R code”.

# Code of Conduct

Please note that this package is released with a [Contributor Code of
Conduct](https://ropensci.org/code-of-conduct/). By contributing to this
project, you agree to abide by its terms.

## Functions

```eval_rst
.. toctree::
   :maxdepth: 1

   functions/checks_to_markdown.md
   functions/get_default_branch.md
   functions/get_gh_token.md
   functions/get_latest_commit.md
   functions/list_pkgchecks.md
   functions/logfile_names.md
   functions/pkgcheck_bg.md
   functions/pkgcheck-package.md
   functions/pkgcheck.md
   functions/pkgstats_data.md
   functions/render_markdown.md
```

## Vignettes

```eval_rst
.. toctree::
   :maxdepth: 1

   vignettes/extending-checks.md
```
