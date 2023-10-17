The [first
vignette](https://docs.ropensci.org/autotest/articles/autotest.html)
demonstrates the process of applying `autotest` at all stages of package
development. This vignette provides additional information for those
applying `autotest` to already developed packages, in particular through
describing how tests can be selectively applied to a package. By default
the [`autotest_package()`
function](https://docs.ropensci.org/autotest/reference/autotest_package.html)
tests an entire package, but testing can also be restricted to specified
functions only. This vignette will demonstrate application to a few
functions from the [`stats`
package](https://stat.ethz.ch/R-manual/R-devel/library/stats/html/00Index.html),
starting by loading the package.

``` r
library (autotest)
```

## 1. `.Rd` files, example code, and the autotest workflow

To understand what `autotest` does, it is first necessary to understand
a bit about the structure of documentation files for R package, which
are contained in files called `".Rd"` files. Tests are constructed by
parsing individual `.Rd` documentation files to extract the example
code, identifying parameters passed to the specified functions, and
mutating those parameters.

The general procedure can be illustrated by examining a specific
function, for which we now choose the [`cor`
function](https://stat.ethz.ch/R-manual/R-devel/library/stats/html/cor.html),
because of its relative simplicity. The following lines extract the
documentation for the `cor` function, a `.html` version of which can be
seen by clicking on the link above. Note that that web page reveals the
name of the `.Rd` file to be “cor” (in the upper left corner), meaning
that the name of the `.Rd` file is `"cor.Rd"`. The following lines
extract that content, first by loading the entire `.Rd` database for the
[`stats`
package](https://stat.ethz.ch/R-manual/R-devel/library/stats/html/00Index.html).

``` r
rd <- tools::Rd_db (package = "stats")
cor_rd <- rd [[grep ("^cor\\.Rd", names (rd))]]
```

The database itself is a list, with each entry holding the contents of
one `.Rd` file in an object of class Rd, which is essentially a large
nested list of components corresponding to the various `.Rd` tags such
as `\arguments`, `\details`, and `\value`. An internal function from the
[`tools`
package](https://stat.ethz.ch/R-manual/R-devel/library/tools/html/00Index.html)
can be used to extract individual components (using the `:::` notation
to access internal functions). For example, a single `.Rd` file often
describes the functionality of several functions, each of which is
identified by specifying the function name as an `"alias"`. The aliases
for the `"cor.Rd"` file are:

``` r
tools:::.Rd_get_metadata (cor_rd, "alias")
#> [1] "var"     "cov"     "cor"     "cov2cor"
```

This one file thus contains documentation for those four functions.
Example code can be extracted with a dedicated function from the
[`tools`
package](https://stat.ethz.ch/R-manual/R-devel/library/tools/html/Rd2HTML.html):

``` r
tools::Rd2ex (cor_rd)
```

    #> ### Name: cor
    #> ### Title: Correlation, Variance and Covariance (Matrices)
    #> ### Aliases: var cov cor cov2cor
    #> ### Keywords: univar multivariate array
    #> 
    #> ### ** Examples
    #> 
    #> var(1:10)  # 9.166667
    #> 
    #> var(1:5, 1:5) # 2.5
    #> 
    #> ## Two simple vectors
    #> cor(1:10, 2:11) # == 1
    #> 
    #> ## Correlation Matrix of Multivariate sample:
    #> (Cl <- cor(longley))
    #> ## Graphical Correlation Matrix:
    #> symnum(Cl) # highly correlated
    #> 
    #> ## Spearman's rho  and  Kendall's tau
    #> symnum(clS <- cor(longley, method = "spearman"))
    #> symnum(clK <- cor(longley, method = "kendall"))
    #> ## How much do they differ?
    #> i <- lower.tri(Cl)
    #> cor(cbind(P = Cl[i], S = clS[i], K = clK[i]))
    #> 
    #> 
    #> ## cov2cor() scales a covariance matrix by its diagonal
    #> ##           to become the correlation matrix.
    #> cov2cor # see the function definition {and learn ..}
    #> stopifnot(all.equal(Cl, cov2cor(cov(longley))),
    #>           all.equal(cor(longley, method = "kendall"),
    #>             cov2cor(cov(longley, method = "kendall"))))
    #> 
    #> ##--- Missing value treatment:
    #> C1 <- cov(swiss)
    #> range(eigen(C1, only.values = TRUE)$values) # 6.19        1921
    #> 
    #> ## swM := "swiss" with  3 "missing"s :
    #> swM <- swiss
    #> colnames(swM) <- abbreviate(colnames(swiss), minlength=6)
    #> swM[1,2] <- swM[7,3] <- swM[25,5] <- NA # create 3 "missing"
    #> 
    #> ## Consider all 5 "use" cases :
    #> (C. <- cov(swM)) # use="everything"  quite a few NA's in cov.matrix
    #> try(cov(swM, use = "all")) # Error: missing obs...
    #> C2 <- cov(swM, use = "complete")
    #> stopifnot(identical(C2, cov(swM, use = "na.or.complete")))
    #> range(eigen(C2, only.values = TRUE)$values) # 6.46   1930
    #> C3 <- cov(swM, use = "pairwise")
    #> range(eigen(C3, only.values = TRUE)$values) # 6.19   1938
    #> 
    #> ## Kendall's tau doesn't change much:
    #> symnum(Rc <- cor(swM, method = "kendall", use = "complete"))
    #> symnum(Rp <- cor(swM, method = "kendall", use = "pairwise"))
    #> symnum(R. <- cor(swiss, method = "kendall"))
    #> 
    #> ## "pairwise" is closer componentwise,
    #> summary(abs(c(1 - Rp/R.)))
    #> summary(abs(c(1 - Rc/R.)))
    #> 
    #> ## but "complete" is closer in Eigen space:
    #> EV <- function(m) eigen(m, only.values=TRUE)$values
    #> summary(abs(1 - EV(Rp)/EV(R.)) / abs(1 - EV(Rc)/EV(R.)))

This is the entire content of the `\examples` portion of `"cor.Rd"`, as
can be confirmed by comparing with the [online
version](https://stat.ethz.ch/R-manual/R-devel/library/stats/html/cor.html).

## 2. Internal structure of the `autotest` workflow

For each `.Rd` file in a package, `autotest` tests the code given in the
example section according to the following general steps:

1.  Extract example lines from the `.Rd` file, as demonstrated above;
2.  Identify all function `aliases` described by that file;
3.  Identify all points at which those functions are called;
4.  Identify all objects passed to those values, including values,
    classes, attributes, and other properties.
5.  Identify any other parameters not explicitly passed in example code,
    but defined via default value;
6.  Mutate the values of all parameters according to the kinds of test
    described in
    [`autotest_types()`](https://docs.ropensci.org/autotest/reference/autotest_types.html).

Calling `autotest_package(..., test = FALSE)` implements the first 5 of
those 6 steps, and returns data on all possible mutations of each
parameter, while setting `test = TRUE` actually passes the mutated
parameters to the specified functions, and returns reports on any
unexpected behaviour.

## 3. `autotest`-ing the `stats::cov` function

The preceding sections describe how `autotest` actually works, while the
present section demonstrates how the package is typically used in
practice. As demonstrated in the
[`README`](https://docs.ropensci.org/autotest/), information on all
tests implemented within the package can be obtained by calling the
[`autotest_types()`
function](https://docs.ropensci.org/autotest/reference/autotest_types.html).
The main function for testing package is
[`autotest_package()`](https://docs.ropensci.org/autotest/reference/autotest_package.html).
The nominated package can be either an installed package, or the full
path to a local directory containing a package’s source code. By default
all `.Rd` files of a package are tested, with restriction to specified
functions possible either by nominating functions to exclude from
testing (via the `exclude` parameter), or functions to include (via the
`functions` parameter). The `functions` parameter is intended to enable
testing only of specified functions, while the `exclude` parameter is
intended to enable testing of all functions except those specified with
this parameter. Specifying values for both of these parameters is not
generally recommended.

### 3.1 Listing tests without conducting them

The following demonstrates the results of `autotest`-ing the [`cor`
function](https://stat.ethz.ch/R-manual/R-devel/library/stats/html/cor.html)
of the `stats` package, noting that the default call uses
`test = FALSE`, and so returns details of all tests without actually
implementing them (and for this reason we name the object `xf` for
“false”):

``` r
xf <- autotest_package (package = "stats", functions = "cor")
print (xf)
```

    #> # A tibble: 15 × 8
    #>    type  test_name      fn_name parameter parameter_type operation content test 
    #>    <chr> <chr>          <chr>   <chr>     <chr>          <chr>     <chr>   <lgl>
    #>  1 dummy single_char_c… cor     use       single_charac… lower-ca… (Shoul… TRUE 
    #>  2 dummy single_char_c… cor     use       single_charac… upper-ca… (Shoul… TRUE 
    #>  3 dummy single_par_as… cor     use       single_charac… Length 2… Should… TRUE 
    #>  4 dummy return_succes… cor     (return … (return objec… Check th… <NA>    TRUE 
    #>  5 dummy return_val_de… cor     (return … (return objec… Check th… <NA>    TRUE 
    #>  6 dummy return_desc_i… cor     (return … (return objec… Check wh… <NA>    TRUE 
    #>  7 dummy return_class_… cor     (return … (return objec… Compare … <NA>    TRUE 
    #>  8 dummy par_is_docume… cor     x         <NA>           Check th… <NA>    TRUE 
    #>  9 dummy par_matches_d… cor     x         <NA>           Check th… <NA>    TRUE 
    #> 10 dummy par_is_docume… cor     use       <NA>           Check th… <NA>    TRUE 
    #> 11 dummy par_matches_d… cor     use       <NA>           Check th… <NA>    TRUE 
    #> 12 dummy par_is_docume… cor     method    <NA>           Check th… <NA>    TRUE 
    #> 13 dummy par_matches_d… cor     method    <NA>           Check th… <NA>    TRUE 
    #> 14 dummy par_is_docume… cor     y         <NA>           Check th… <NA>    TRUE 
    #> 15 dummy par_matches_d… cor     y         <NA>           Check th… <NA>    TRUE

The object returned from `autotest_package()` is a simple
[`tibble`](https://tibble.tidyverse.org), with each row detailing one
test which would be applied to the each of the listed functions and
parameters. Because no tests were conducted, all tests will generally
have a `type` of `"dummy"`. In this case, however, we see the following:

``` r
table (xf$type)
#> 
#> dummy 
#>    15
```

In addition to the 15 dummy tests, the function also returns 0 warnings,
the corresponding rows of which are:

``` r
xf [xf$type != "dummy", c ("fn_name", "parameter", "operation", "content")]
#> # A tibble: 0 × 4
#> # ℹ 4 variables: fn_name <chr>, parameter <chr>, operation <chr>, content <chr>
```

Although the `auotest` package is primarily intended to apply mutation
tests to all parameters of all functions of a package, doing so requires
identifying parameter types and classes through parsing example code.
Any parameters of a function which are neither demonstrated within
example code, nor given default values can not be tested, because it is
not possible to determine their expected types. The above result reveals
that neither the `use` parameter of the `var` function, nor the `y`
parameter of `cov`, are demonstrated in example code, triggering a
warning that these parameter are unable to be tested.

### 3.2 Conducting tests

The 15 tests listed above with `type == "dummy"` can then be applied to
all nominated functions and parameters by calling the same function with
`test = TRUE`. Doing so yields the following results (as an object names
`xt` for “true”):

``` r
xt <- autotest_package (package = "stats",
                        functions = "cor",
                        test = TRUE)
print (xt)
```

And the 15 tests yielded 5 unexpected responses. The best way to
understand these results is to examine the object in detail, typically
through `edit(xt)`, or equivalently in RStudio, clicking on the listed
object. The different types of tests which produced unexpected responses
were:

``` r
table (xt1$operation)
#> 
#> Check that documentation matches class of input parameter 
#>                                                         4 
#>                            upper-case character parameter 
#>                                                         1
```

Two of those reflect the previous results regarding parameters unable to
be tested, while the remainder come from only two types of tests.
Information on the precise results is contained in the `content` column,
although in this case it is fairly straightforward to see that the
operation “upper case character parameter” arises because the `use` and
`method` parameters of the `cor` and `cov` functions are case-dependent,
and are only accepted in lower case form. The other operation is the
conversion of vectors to list-column format, as described in the [first
vignette](https://docs.ropensci.org/autotest/articles/autotest.html).

### 3.4 Controlling which tests are conducted

The `test` parameter of the [`autotest_package()`
function](https://docs.ropensci.org/autotest/reference/autotest_package.html)
can be used to control whether all tests are conducted or not.
Finer-level control over tests can be achieved by specifying the
`test_data` parameter. This parameter must be an object of class
`autotest_package`, as returned by either the
[`autotest_types()`](https://docs.ropensci.org/autotest/reference/autotest_types.html)\]
or
[`autotest_package()`](https://docs.ropensci.org/autotest/reference/autotest_package.html)
functions. The former of these is the function which specifies all
unique tests, and so returns a relatively small `tibble` of 27 rows. The
following lines demonstrate how to switch off the list-column test for
all functions and parameters:

``` r
types <- autotest_types()
types$test [grep ("list_col", types$test_name)] <- FALSE
xt2 <- autotest_package (package = "stats",
                         functions = "cor",
                         test = TRUE,
                         test_data = types)
print (xt2)
```

    #> # A tibble: 5 × 8
    #>   type       test_name  fn_name parameter parameter_type operation content test 
    #>   <chr>      <chr>      <chr>   <chr>     <chr>          <chr>     <chr>   <lgl>
    #> 1 warning    par_match… cor     x         <NA>           Check th… Parame… TRUE 
    #> 2 warning    par_match… cor     y         <NA>           Check th… Parame… TRUE 
    #> 3 warning    par_match… cor     x         <NA>           Check th… Parame… TRUE 
    #> 4 warning    par_match… cor     y         <NA>           Check th… Parame… TRUE 
    #> 5 diagnostic single_ch… cor     use       single charac… upper-ca… is cas… TRUE

The result now has four rows with `test == FALSE`, and
`type == "no_test"`, indicating that these tests were not actually
conducted. That also makes apparent the role of these `test` flags. When
initially calling
[`autotest_package()`](https://docs.ropensci.org/autotest/reference/autotest_package.html)
with default `test = FALSE`, the result contains a `test` column in
which all values are `TRUE`. Although potentially perplexing at first,
this value must be understood in relation to the `type` column. A `type`
of `"dummy"` indicates that a test has not been conducted, in which case
`test = TRUE` is a control flag used to determine what would be
conducted if these data were submitted as the `test_data` parameter. For
all `type` values other than `"dummy"`, the `test` column specifies
whether or not each test was actually conducted.

The preceding example showed how the results of
[`autotest_types()`](https://docs.ropensci.org/autotest/reference/autotest_types.html)
can be used to control which tests are implemented for an entire
package. Finer-scale control can be achieved by modifying individual
rows of the full table returned by
[`autotest_package()`](https://docs.ropensci.org/autotest/reference/autotest_package.html).
The following code demonstrates by showing how list-column tests can be
switched off only for particular functions, starting again with the `xf`
data of dummy tests generated above.

``` r
xf <- autotest_package (package = "stats",
                        functions = "cor")
xf$test [grepl ("list_col", xf$test_name) & xf$fn_name == "var"] <- FALSE
xt3 <- autotest_package (package = "stats",
                         functions = "cor",
                         test = TRUE,
                         test_data = xf)
print (xt3)
```

    #> # A tibble: 5 × 8
    #>   type       test_name  fn_name parameter parameter_type operation content test 
    #>   <chr>      <chr>      <chr>   <chr>     <chr>          <chr>     <chr>   <lgl>
    #> 1 warning    par_match… cor     x         <NA>           Check th… Parame… TRUE 
    #> 2 warning    par_match… cor     y         <NA>           Check th… Parame… TRUE 
    #> 3 warning    par_match… cor     x         <NA>           Check th… Parame… TRUE 
    #> 4 warning    par_match… cor     y         <NA>           Check th… Parame… TRUE 
    #> 5 diagnostic single_ch… cor     use       single charac… upper-ca… is cas… TRUE

These procedures illustrate the three successively finer levels of
control over tests, by switching them off for:

1.  Entire packages;
2.  Specified functions only; or
3.  Specific parameters of particular functions only.

## 4. `autotest`-ing your package

`autotest` can be very easily incorporated in your package’s `tests/`
directory via to simple [`testthat`](https://testthat.r-lib.org)
expectations:

- `expect_autotest_no_testdata`, which will expect `autotest_package` to
  work on your package with default values including no additional
  `test_data` specifying tests which are not to be run; or
- `expect_autotest_testdata`, to be used when specific tests are
  switched off.

Using these requires adding `autotest` to the `Suggests` list of your
package’s `DESCRIPTION` file, along with `testthat`. Note that the use
of testing frameworks other than
[`testthat`](https://testthat.r-lib.org) is possible through writing
custom expectations for the output of
[`autotest_package()`](https://docs.ropensci.org/autotest/reference/autotest_package.html),
but that is not considered here.

To use these expectations, you must first decide which, if any, tests
you judge to be not applicable to your package, and switch them off
following the procedure described above (that is, at the package level
through modifying the `test` flag of the object returned from
[`autotest_types()`](https://docs.ropensci.org/autotest/reference/autotest_types.html),
or at finer function- or parameter-levels by modifying equivalent values
in the object returned from
[`autotest_package(..., test = FALSE)`](https://docs.ropensci.org/autotest/reference/autotest_package.html).
These objects must then be passed as the `test_data` parameter to
[`autotest_package()`](https://docs.ropensci.org/autotest/reference/autotest_package.html).
If you consider all tests to be applicable, then
[`autotest_package()`](https://docs.ropensci.org/autotest/reference/autotest_package.html)
can be called without specifying this parameter.

If you switch tests off via a `test_data` parameter, then the
`expect_autotest` expectation requires you to append an additional
column to the `test_data` object called `"note"` (case-insensitive), and
include a note for each row which has `test = FALSE` explaining why
those tests have been switched off. Lines in your test directory should
look something like this:

``` r
library (testthat) # as called in your test suite
# For example, to switch off vector-to-list-column tests:
test_data <- autotest_types (notest = "vector_to_list_col")
test_data$note <- ""
test_data$note [test_data$test == "vector_to_list_col"] <-
    "These tests are not applicable because ..."
expect_success (expect_autotest_testdata (test_data))
```

This procedure of requiring an additional `"note"` column ensures that
your own test suite will explicitly include all explanations of why you
deem particular tests not to be applicable to your package.

In contrast, the following expectation should be used when
`autotest_package()` passes with all tests are implemented, in which
case no parameters need be passed to the expectation, and tests will
confirm that no warnings or errors are generated.

``` r
expect_success (expect_autotest_no_testdata ())
```

### 4.2 Finer control over testing expectations

The two expectations shown above call the
[`autotest_package()`](https://docs.ropensci.org/autotest/reference/autotest_package.html)
function internally, and assert that the results follow the expected
pattern. There are also three additional
[`testthat`](https://testthat.r-lib.org) expectations which can be
applied to pre-generated `autotest` objects, to allow for finer control
over testing expectations. These are:

- `expect_autotest_no_err` to expect no errors in results from
  `autotest_package()`;
- `expect_autotest_no_warn` to expect no warnings; and
- `expect_autotest_notes` to expect tests which have been switched off
  to have an additional `"note"` column explaining why.

These tests are demonstrated in one of the testing files used in this
package, which the following lines recreate to demonstrate the general
process. The first two expectations are that an object be free from both
warnings and errors. The tests implemented here are applied to the
[`stats::cov()`
function](https://stat.ethz.ch/R-manual/R-devel/library/stats/html/cor.html),
which actually triggers warnings because two parameters do not have
their usage demonstrated in the example code. The tests therefore
`expect_failure()`, when they generally should `expect_success()`
throughout.

``` r
library (testthat) # as called in your test suite
# For example, to switch off vector-to-list-column tests:
test_data <- autotest_types (notest = "vector_to_list_col")
x <- autotest_package (package = "stats",
                       functions = "cov",
                       test = TRUE,
                       test_data = test_data)
       
expect_success (expect_autotest_no_err (x))
expect_failure (expect_autotest_no_warn (x)) # should expect_success!!
```

The test files then affirms that simply passing the object, `x`, which
has tests flagged as `type == "no_test"`, yet without explaining why in
an additional `"note"` column, should cause `expect_autotest()` to fail.
The following line, removing the logical `testthat` expectation,
demonstrates:

``` r
expect_autotest_notes (x)
```

As demonstrated above, these `expect_autotest_...` calls should always
be wrapped in a direct [`testhat`](https://testthat.r-lib.org)
expectation of
[`expect_success()`](https://testthat.r-lib.org/reference/expect_success.html).
To achieve success in that case, we need to append an additional
`"note"` column containing explanations of why each test has been
switched off:

``` r
x$note <- ""
x [grep ("vector_to_list", x$test_name), "note"] <-
  "these tests have been switched off because ..."

expect_success (expect_autotest_notes (x))
```

In general, using `autotest` in a package’s test suite should be as
simple as adding `autotest` to `Suggests`, and wrapping either
`expect_autotest_no_testdata` or `expect_autotest_testdata` in an
`expect_success` call.
