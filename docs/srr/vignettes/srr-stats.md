# Preparing Statistical Software with the srr package

`srr` stands for **S**oftware **R**eview **R**oclets, and is an R
package containing roclets for general use in helping those developing
and reviewing packages submitted to rOpenSci. At present, the `srr`
package only contains roclets and associated functions to help those
developing and reviewing packages submitted to rOpenSci’s system for
[Statistical Software Review](https://stats-devguide.ropensci.org/).
This vignette demonstrates how developers are intended to use this
package to document the alignment of their software with rOpenSci’s
[standards for statistical
software](https://stats-devguide.ropensci.org/standards.html).

The main functions of the package are constructed as [`roxygen2`
“roclets”](https://roxygen2.r-lib.org), meaning that these functions are
called each time package documentation is updated by calling
[`devtools::document()`](https://devtools.r-lib.org/reference/document.html)
or equivalently
[`roxygen2::roxygenise()`](https://roxygen2.r-lib.org/reference/roxygenize.html).
The former is just a wrapper around the latter, to enable documentation
to updated by a single call from within the [`devtools`
package](https://devtools.r-lib.org). From here on, this stage of
updating documentation and triggering the `srr` roclets will be referred
to as “running
[`roxygenise`](https://roxygen2.r-lib.org/reference/roxygenize.html).”

## 1. The package skeleton

The [`srr_stats_pkg_skeleton()`
function](https://docs.ropensci.org/srr/reference/srr_stats_pkg_skeleton.html)
included with this package differs from
[other](https://stat.ethz.ch/R-manual/R-patched/library/utils/html/package.skeleton.html)
[package](https://usethis.r-lib.org/reference/create_package.html)
[skeleton](https://rdrr.io/cran/Rcpp/man/Rcpp.package.skeleton.html)
functions. Rather than providing a skeleton from which you can construct
your own package, the [`srr_stats_pkg_skeleton()`
function](https://docs.ropensci.org/srr/reference/srr_stats_pkg_skeleton.html)
generates a skeleton to help developers understand this package works.
This skeleton of a package is intended to be modified to help you
understand which kinds of modifications are allowed, and which generate
errors. The package is by default called `"demo"`, is constructed in R’s
[`tempdir()`](https://stat.ethz.ch/R-manual/R-devel/library/base/html/tempfile.html),
and looks like this:

``` r
library (srr)
d <- srr_stats_pkg_skeleton (pkg_name = "package")
fs::dir_tree (d)
```

    ## /tmp/RtmpuwzVqt/package
    ## ├── DESCRIPTION
    ## ├── NAMESPACE
    ## ├── R
    ## │   ├── RcppExports.R
    ## │   ├── package-package.R
    ## │   ├── srr-stats-standards.R
    ## │   └── test.R
    ## ├── README.Rmd
    ## ├── src
    ## │   ├── RcppExports.cpp
    ## │   └── cpptest.cpp
    ## └── tests
    ##     ├── testthat
    ##     │   └── test-a.R
    ##     └── testthat.R

The files listed there mostly exist to illustrate how standards can be
included within code. The format of standards can be seen by examining
any of those files. For example, the `test.R` file looks like this:

``` r
readLines (file.path (d, "R", "test.R"))
```

    ##  [1] "#' test_fn"                                                
    ##  [2] "#'"                                                        
    ##  [3] "#' A test funtion"                                         
    ##  [4] "#'"                                                        
    ##  [5] "#' @srrstats {G1.1, G1.2, G1.3} with some text"            
    ##  [6] "#' @srrstats Text can appear before standards {G2.0, G2.1}"
    ##  [7] "#' @srrstatsTODO {RE1.1} standards which are still to be"  
    ##  [8] "#' addressed are tagged 'srrstatsTODO'"                    
    ##  [9] "#'"                                                        
    ## [10] "#' @export"                                                
    ## [11] "test_fn <- function() {"                                   
    ## [12] "  message(\"This function does nothing\")"                 
    ## [13] "}"

That file illustrates some of the
[`roxygen2`](https://roxygen2.r-lib.org) tags defined by this package,
and described in detail below. These tags are parsed whenever package
documentation is updated with
[`roxygenise()`](https://roxygen2.r-lib.org/reference/roxygenize.html),
which will produce output like the following:

``` r
roxygen2::roxygenise (d)
```

    ## Setting `RoxygenNote` to "7.2.3"
    ## ℹ Loading package
    ## Writing 'NAMESPACE'
    ## ─────────────────────────────────────────────────────────────────────────────────────────────────────────────────── rOpenSci Statistical Software Standards ───────────────────────────────────────────────────────────────────────────────────────────────────────────────────
    ## 
    ## 
    ## 
    ## ── @srrstats standards (8 / 12): 
    ## 
    ##   * [G1.1, G1.2, G1.3, G2.0, G2.1] in function 'test_fn()' on line#11 of file [R/test.R]
    ##   * [RE2.2] on line#2 of file [tests/testthat/test-a.R]
    ##   * [G2.3] in function 'test()' on line#6 of file [src/cpptest.cpp]
    ##   * [G1.4] on line#17 of file [./README.Rmd]
    ## 
    ## 
    ## 
    ## ── @srrstatsNA standards (1 / 12): 
    ## 
    ##   * [RE3.3] on line#5 of file [R/srr-stats-standards.R]
    ## 
    ## 
    ## 
    ## ── @srrstatsTODO standards (3 / 12): 
    ## 
    ##   * [RE4.4] on line#14 of file [R/srr-stats-standards.R]
    ##   * [RE1.1] on line#11 of file [R/test.R]
    ##   * [G1.5] on line#17 of file [./README.Rmd]
    ## 
    ## ───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
    ## 
    ## Writing 'package-package.Rd'
    ## Writing 'test_fn.Rd'
    ## Writing 'NAMESPACE'

The “roclets” contained within this package parse any instances of the
package-specified tags described below, and summarise the output by
listing all locations of each kind of tag. Locations are given as file
and line numbers, and where appropriate, the names of associated
functions. We recommend that developers familiarise themselves with the
system by simply modifying any [`roxygen2`](https://roxygen2.r-lib.org)
block in any of the files of this package skeleton, and running
[`roxygenise()`](https://roxygen2.r-lib.org/reference/roxygenize.html)
to see what happens.

## 2. Enabling `srr` roclets for a package

The “roclets” can be enabled for a package by modifying the
`DESCRIPTION` file so that the `Roxygen` line looks like this:

``` r
Roxygen: list (markdown = TRUE, roclets = c ("namespace", "rd", "srr::srr_stats_roclet"))
```

That will load the [“roclets”](https://roxygen2.r-lib.org) used by this
package to process standards as documented within your actual code. Note
that you do not need to add, import, or depend upon the `srr` package
anywhere else within the `DESCRIPTION` file. See the `DESCRIPTION` file
of the package skeleton for an example.

## 3. `roxygen2` tags

The `srr` packages recognises and uses the following three tags, each of
which may be inserted into [`roxygen2`](https://roxygen2.r-lib.org)
documentation blocks anywhere in your code. The tags are:

1.  `@srrstats` tags to indicate standards which have been addressed.
    These should be placed at the locations within your code where
    specific standards have been addressed, and should include a brief
    textual description of how the code at that location addresses the
    nominated standard.
2.  `@srrstatsTODO` tags to indicate standards which have not yet been
    addressed. The [`srr_stats_roxygen()`
    function](https://docs.ropensci.org/srr/reference/srr_stats_roxygen.html)
    described below will place all standards for your nominated
    categories in an initial file in the `/R` directory of your project.
    Each of these will have a tag of `@srrstatsTODO`. As you address
    each standard, you’ll need to move it from that initial location to
    that point in your code where that standard is addressed, and change
    the tag from `@srrstatsTODO` to `@srrstats`. It may help to break
    the initial, commonly very long, single list of standards into
    smaller groups, and to move each of these into the approximate
    location within your code where these are likely to be addressed.
    For example, all standards which pertain to tests can be moved into
    the `/tests` (or `/tests/testthat`) directory.
3.  `@srrstatsNA` tags to indicate standards which you deem not
    applicable to your package. These need to be grouped together in a
    single block with a title of `NA_standards`. Such a block is both
    included in the package skeleton, and also in the output of
    [`srr_stats_roxygen()`
    function](https://docs.ropensci.org/srr/reference/srr_stats_roxygen.html).
    The numbers of any non-applicable standards can then be moved to
    this block, with a note explaining why these standards have been
    deemed not to apply to your package.

The output illustrated above shows how the `srr` package groups these
three tags together, first collecting the output of standards which have
been addressed (via `@srrstats` tags), then showing output of
non-applicable standards (via `@srrstatsNA` tags), and finally standards
which are still to be addressed (via `@srrstatsTODO` tags).

### 3.1 Format of `srr` documentation

The tags shown above from the skeleton package function `test.R`
indicates the expected format of standards within
[`roxygen2`](https://roxygen2.r-lib.org) documentation blocks. The
package is designed to error on attempting to run
[`roxygenise()`](https://roxygen2.r-lib.org/reference/roxygenize.html)
with any inappropriately formatted entries, and so should provide
informative messages to help rectify any problems. `srr` documentation
must adhere to the following formatting requirements:

1.  The tags must appear immediately after the
    [`roxygen2`](https://roxygen2.r-lib.org)-style comment symbols. This
    will almost always mean `#' @srrstats` (but see details below, under
    *Locations of `srrstats` documentation*).

2.  The standards number(s) must be enclosed within curly braces, such
    as `#' @srrstats {G1.0}`. Multiple standards may be associated with
    a single tag by including them within the same single pair of curly
    braces, and separating each by a comma, such as
    `#' @srrstats {G1.0, G1.1}`.

3.  Explanatory text may be placed anywhere before or after curly braces
    enclosing standards, such that `#' @srrstats some text {G1.0}` is
    entirely equivalent to `#' @srrstats {G1.0} some text`.

4.  Only the first pair of curly braces is parsed to determine standards
    numbers; any subsequent curly braces within one expression will be
    ignored. (Where an expression is everything that comes after one
    [`roxygen2`](https://roxygen2.r-lib.org) tag, and extends until the
    start of the next tag.) The following will accordingly only refer to
    G1.0, and not G1.1:

    ``` r
       #' @srrstats {G1.0} as well as {G1.1}.
    ```

    The appropriate way to refer to multiple tags is to include them in
    the one set of curly braces, as shown above, or to use separate
    tags, like this:

    ``` r
    #' @srrstats {G1.0} as well as
    #' @srrstats {G1.1}
    ```

5.  Any standard may occur arbitrarily many times in any file(s) within
    a package. The only requirement is that any one standard should only
    be associated with one single kind of tag; thus should only be
    `@srrstats` (a standard which has been addressed), *or*
    `@srrstatsNA` (a standard which is not applicable), *or*
    `@srrstatsTODO` (a standard which has not yet been addressed).

In almost all cases, all tags for a package will be generated by the
initial call to
[`srr_stats_roxygen()`](https://docs.ropensci.org/srr/reference/srr_stats_roxygen.html),
and should simply be moved to appropriate locations within a package’s
code without modifying the format.

### 3.2 Locations of `srrstats` documentation

`@srrstats` tags and accompanying text can be placed almost anywhere
within a package, especially in any file in the main `/R`, `/tests`, or
`src/` directories. Within the `/R` directory, tags should be placed
only in [`roxygen2`](https://roxygen2.r-lib.org) blocks. These tags, and
all associated text, will be ignored by the roclets used by
[`roxygen2`](https://roxygen2.r-lib.org) to generate package
documentation, and will only appear on screen output like that shown
above, and generated when running
[`roxygenise()`](https://roxygen2.r-lib.org/reference/roxygenize.html).
If tags need to be inserted where there is no
[`roxygen2`](https://roxygen2.r-lib.org/reference/roxygenize.html)
block, then a new block will need to be created, the minimal requirement
for which is that it then have an additional `#' @noRd` tag to suppress
generation of documentation (`.Rd`) files. If that block is associated
with a function, the following two lines will suffice:

``` r
#' @srrstats G1.0 This standard belongs here
#' @noRd
myfunction <- function (...) {
    # ...
}
```

If that block is not associated with a function, the documentation can
be followed by a `NULL`, like this:

``` r
#' @srrstats G1.0 This standard belongs here
#' @noRd
NULL
```

Unlike [`roxygen2`](https://roxygen2.r-lib.org), which only processes
blocks from within the main `R/` directory, the `srr` package process
blocks from within other directories too. As these blocks will never be
passed through to the main
[`roxygenise()`](https://roxygen2.r-lib.org/reference/roxygenize.html)
function, they need neither `#' @noRd` tags, nor `NULL` definitions
where none otherwise exist. An example is in the `tests/` directory of
the package skeleton:

``` r
readLines (file.path (d, "tests", "testthat", "test-a.R"))
```

    ## [1] "#' @srrstats {RE2.2} is addressed here"
    ## [2] "test_that(\"dummy test\", {"           
    ## [3] "    expect_true (TRUE)"                
    ## [4] "})"

While `@srrstats` tags can also be placed in the `src/` directory, the
package currently only parses
[`doxygen`](https://github.com/doxygen/doxygen)-style blocks for code
written in C or C++. (Note that `srr` is currently further restricted to
C++ code compiled with
[`Rcpp`](https://cran.r-project.org/package=Rcpp), but will soon be
adapted to work with other C++ interfaces such as
[`cpp11`](https://cpp11.r-lib.org).) These blocks are converted by
[`Rcpp`](https://cran.r-project.org/package=Rcpp) into
[`roxygen2`](https://roxygen2.r-lib.org) blocks in a file called
`R/RcppExports.R`, and so need to include an additional `@noRd` tag to
(optionally) suppress generation of `.Rd` documentation. The skeleton
package again gives an example:

``` r
readLines (file.path (d, "src", "cpptest.cpp"))
```

    ##  [1] "#include <Rcpp.h>"                    
    ##  [2] ""                                     
    ##  [3] "//' src_fn"                           
    ##  [4] "//'"                                  
    ##  [5] "//' A test C++ function"              
    ##  [6] "//' @srrstats {G2.3} in src directory"
    ##  [7] "//' @noRd"                            
    ##  [8] "// [[Rcpp::export]]"                  
    ##  [9] "int test () {"                        
    ## [10] "    return 1L; }"

### 3.3 Documenting standards for documentation

Many standards refer to general package documentation, particularly in a
`README` document, or in package vignettes. All such documents are
presumed to be written in `.Rmd` format, for which `@srrstats` tags must
be included within distinct code chunks. Again, the skeleton package has
an example as follows:

``` r
readLines (file.path (d, "README.Rmd"))
```

    ##  [1] "# package"                                                                                
    ##  [2] ""                                                                                         
    ##  [3] "This is a skeleton of an [`srr` statistics](https://github.com/ropensci-review-tools/srr)"
    ##  [4] "package, intended developers to tweak as they like, in order to understand "              
    ##  [5] "how the package's roclets work."                                                          
    ##  [6] ""                                                                                         
    ##  [7] "This `README.Rmd` file is here to demonstrate how to embed `srr` roclet tags."            
    ##  [8] "These tags need to be within dedicated *code chunks*, like the following:"                
    ##  [9] ""                                                                                         
    ## [10] "```{r srr-tags, eval = FALSE, echo = FALSE}"                                              
    ## [11] "#' roxygen_block_name"                                                                    
    ## [12] "#'"                                                                                       
    ## [13] "#' (Add some text if you like)"                                                           
    ## [14] "#'"                                                                                       
    ## [15] "#' @srrstats {G1.4} Here is a reference to a standard"                                    
    ## [16] "#' @srrstatsTODO {G1.5} And here is a reference to a standard yet to be addressed"        
    ## [17] "```"                                                                                      
    ## [18] ""                                                                                         
    ## [19] "Note the chunk contains only [`roxygen2`](https://roxygen2.r-lib.org) lines,"             
    ## [20] "and nothing else at all. Please change the `eval` and `echo` parameters to"               
    ## [21] "see what happens when you knit the document."

Those lines illustrate the expected form. `@srrstats` tags should be
within a single block contained within a dedicated code chunk.
`@srrstats` chunks within `.Rmd` files will generally use `echo = FALSE`
to prevent them appearing in the rendered documents. The
[`roxygen2`](https://roxygen2.r-lib.org) lines do not need to be
followed by a `NULL` (or any other non-
[`roxygen2`](https://roxygen2.r-lib.org) statement), although if
additional R code is necessary for any reason, you may also need to add
`eval = FALSE`.

### 3.4 `@srrstatsNA` tags for non-applicable standards

While `@srrstatsTODO` and `@srrstats` tags may be placed anywhere within
a package, `@srrstatsNA` tags used to denote non-applicable standards
must be placed within a dedicated
[`roxygen2`](https://roxygen2.r-lib.org) block with a title of
`NA_standards`. As described above, both the package skeleton and the
file produced by calling
[`srr_stats_roxygen()`](https://docs.ropensci.org/srr/reference/srr_stats_roxygen.html)
include templates for this block. The following illustrates a minimal
form:

``` r
#' NA_standards
#'
#' @srrstatsNA {S3.3} is not applicable
#' @noRd
NULL
```

An `NA_standards` block must end with `NULL`, rather than be associated
with a function definition. There can be multiple `NA_standards` blocks
in any location, enabling these standards to be moved to approximate
locations where they might otherwise have been addressed. (For example,
non-applicable standards referring to tests might all be grouped
together in a single `NA_standards` block in the `tests/` directory.)

## 4. The `srr` workflow

The first step for any developer intending to use this package on the
way to a submission to rOpenSci’s project for peer-reviewing statistical
software is to generate the package skeleton described above, and to try
any and all conceivable ways to modify locations, formats, and other
properties of the [`roxygen2`](https://roxygen2.r-lib.org) tags defined
in this package, in order to understand how these tags are used to
generate the summary results when running
[`roxygenise`](https://roxygen2.r-lib.org/reference/roxygenize.html).
Following that initial familiarisation, a typical workflow will involve
the following general steps:

1.  Automatically download and insert lists of general and
    category-specific standards in your package by running
    [`srr_stats_roxygen()`](https://docs.ropensci.org/srr/reference/srr_stats_roxygen.html)
    (in the main package directory). This will by default generate a
    file in the `R/` directory called `srr-stats-standards.R`, although
    any alternative name can also be passed to the function (or the file
    can be renamed after it has initially been created). Each group of
    standards in this file must always be terminated by `NULL` in order
    to be appropriately parsed by the `roxygen2` package.
2.  Change your package’s `DESCRIPTION` file to use the `srr` roclets by
    adding `roclets = "srr::srr_stats_roclet"`) to the `Roxygen` line,
    as demonstrated at the outset, as well as in the package skeleton.
3.  Run
    [`roxygenise`](https://roxygen2.r-lib.org/reference/roxygenize.html)
    to confirm that the roclets work on your package. You should
    initially see only a single list of `@srrstatsTODO` standards. All
    documented standards should appear somewhere in the output. Any
    missing standards indicate documentation problems, such as missing
    terminal `NULL` values from standards blocks.
4.  We recommend as a first step cutting-and-pasting standards to
    approximate locations within your package’s code where you
    anticipate these standards being addressed. Multiple copies of any
    one standard may exist in multiple locations, so you may also repeat
    standards which you anticipate will be addressed in multiple
    locations. This should reduce a potentially very long initial list
    of standards down to several distinct groups of hopefully more
    manageable size.
5.  Begin addressing the standards by:
    - Ensuring your code conforms;
    - Moving each standard to the one or more location(s) where you
      think your code most directly addresses them;
    - Modifying the `@srrstatsTODO` tag to `@srrstats`
    - Changing the initial text describing the standard itself to a
      brief description of how your code addresses that standard.
6.  Standards which you deem not to be applicable to your package should
    be grouped together in a single
    [`roxygen2`](https://roxygen2.r-lib.org) block with the title
    `NA_standards` (as described above, and as generated by the
    [`srr_stats_roxygen()`](https://docs.ropensci.org/srr/reference/srr_stats_roxygen.html)
    function). This block must finish with a `NULL` statement.
7.  Update your documentation as frequently as you like or need, and use
    the output of the roclets to inform and guide the process of
    converting all `@srrstatsTODO` tags into either `@srrstats` or
    `@srrstatsNA` tags.

Note that we do **not** recommend copying files from the package
skeleton into your own package for you `srr` documentation. The
following lines demonstrate what happens if you insert actual standards
into the package skeleton:

``` r
srr_stats_roxygen (category = "regression", # for example
                   filename = file.path (d, "R", "srr-stats-standards.R"),
                   overwrite = TRUE)
```

    ## ✔ Downloaded general standards
    ## ✔ Downloaded regression standards
    ## ℹ Roxygen2-formatted standards written to [srr-stats-standards.R]

``` r
roxygen2::roxygenise (d)
```

    ## ℹ Loading package
    ## Error: Standards [G1.1, G1.2, G1.3, G2.0, G2.1, RE2.2, G2.3, G1.4] are listed with both @srrstats and @srrstatsTODO tags.
    ## Please rectify to ensure these standards are only associated with one tag.

To ensure all standards are first inserted with `@srrstatsTODO` tags,
and that there are no duplicates with other tags, please use only the
[`srr_stats_roxygen()`](https://docs.ropensci.org/srr/reference/srr_stats_roxygen.html)
function.
