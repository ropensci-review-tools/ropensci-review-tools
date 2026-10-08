# 'goodpractice' for developers

## The ‘Makefile’

The ‘goodpractice’ repository includes a
[‘Makefile’](https://www.gnu.org/software/make/manual/make.html#Introduction).
This allows many commands to be run directly from a shell console
(rather than within an R session). The default behaviour is to list all
options:

``` bash
make
```

    #> Usage: make [target]
    #> allcon               Run 'allcontributors::add_contributors'
    #> check                Run `rcmdcheck`
    #> clean                Clean all junk files, including all pkgdown docs
    #> doc                  Update package documentation with `roxygen2`
    #> help                 Show this help
    #> init                 Initialize pkgdown site
    #> knith                Render README as HTML
    #> knitr                Render README as markdown
    #> open                 Open main HTML vignette in browser
    #> pkgcheck             Run `pkgcheck` and print results to screen.
    #> pkgdown              Build entire pkgdown site
    #> pkgdowncheck         Run check_pkgdown function
    #> test                 Run test suite
    #> vignette             Build pkgdown article

Any of those options can then be run as `make <command>`. For example,
this command checks for any issues with the `pkgdown` site:

``` bash
make pkgdowncheck
```

    #> ✔ No problems found

Note that some of the `Makefile` options depend on additional packages
which may need to be installed. These include:

- [`allcontributors`](https://docs.ropensci.org/allcontributors/)
- [`pkgcheck`](https://docs.ropensci.org/pkgcheck/)
- [`pkgdown`](https://pkgdown.r-lib.org/)

------------------------------------------------------------------------

## Adding new checks

Checks are defined in groups. Each group is generally defined within two
files: 1. A `prep_<group>.R` file for collecting data needed for the
check 2. A `chk_<group>.R` file defining the output structure of the
check.

The `R/` directory here consistns almost entirely of paired files
defining each check group:

    #> api.R
    #> chk_avoided_packages.R
    #> chk_code_structure.R
    #> chk_covr.R
    #> chk_cyclocomp.R
    #> chk_description.R
    #> chk_generic.R
    #> chk_lintr.R
    #> chk_namespace.R
    #> chk_rcmdcheck.R
    #> chk_rd.R
    #> chk_revdep.R
    #> chk_roxygen2.R
    #> chk_spelling.R
    #> chk_tidyverse.R
    #> chk_urlchecker.R
    #> chk_vignette.R
    #> customization.R
    #> gp.R
    #> lists.R
    #> package.R
    #> prep_covr.R
    #> prep_cyclocomp.R
    #> prep_description.R
    #> prep_lintr.R
    #> prep_namespace.R
    #> prep_rcmdcheck.R
    #> prep_rd.R
    #> prep_revdep.R
    #> prep_roxygen2.R
    #> prep_source.R
    #> prep_spelling.R
    #> prep_tidyverse.R
    #> prep_urlchecker.R
    #> prep_utils.R
    #> prep_vignette.R
    #> print.R
    #> rstudio_markers.R
    #> treesitter.R
    #> utils.R

An example is the `cyclocomp` check, which is largely a wrapper around
the external [`cyclocomp`
package](https://github.com/gaborcsardi/cyclocomp). The
`prep_cyclocomp.R` file looks like this:

    #> 
    #> #' @include lists.R prep_utils.R
    #> #' @importFrom cyclocomp cyclocomp_package_dir
    #> 
    #> PREPS$cyclocomp <- function(state, path = state$path, quiet) {
    #>   run_prep_step(state, "cyclocomp", function(path) {
    #>     cyclocomp_package_dir(path)
    #>   }, path = path, silent = quiet)
    #> }

That preparation steps runs the `cyclocomp::cyclocomp_package_dir()`
function in the source directory of the package being checked. The
corresponding `check_cyclocomp.R` file then uses a variable called
`state` that is accessible to all functions within the package. The line
above `PREPS$cyclocomp <-` creates an entry of `state$cyclocomp`
containing the results of the preparation step that can then be accessed
to defined the check output in `R/chk_cyclocomp.R`:

    #> 
    #> #' @include lists.R
    #> 
    #> #' @noRd
    #> cyclocomp_limit <- function() {
    #>   getOption("goodpractice.cyclocomp_limit", 15)
    #> }
    #> 
    #> CHECKS$cyclocomp <- make_check(
    #> 
    #>   description = "Functions are simple",
    #>   tags = c("info", "code complexity"),
    #>   preps = "cyclocomp",
    #> 
    #>   gp = function(state) {
    #>     limit <- cyclocomp_limit()
    #>     cyc <- state$cyclocomp
    #>     long <- which(cyc$cyclocomp > limit)
    #>     funcs <- paste0(
    #>       cyc$name[long],
    #>       " (", cyc$cyclocomp[long], ")",
    #>       collapse = ", "
    #>     )
    #>     paste0(
    #>       "write short and simple functions.",
    #>       " These functions have high",
    #>       " cyclomatic complexity (>", limit, "): ",
    #>       funcs, ". ",
    #>       "You can make them easier to reason about",
    #>       " by encapsulating distinct steps",
    #>       " of your function into subfunctions."
    #>     )
    #>   },
    #> 
    #>   check = function(state) {
    #>     if (inherits(state$cyclocomp, "try-error")) return(na_result())
    #>     check_result(all(state$cyclocomp$cyclocomp <= cyclocomp_limit()))
    #>   }
    #> )

All checks following this general pattern of defining `PREPS$<group> <-`
entries containing data from the check, then defining `CHECKS$<group>`
entries for output format, using `state$<group>` to access the check
data. The best way to learn about check structure is to examine some of
the existing files.
