# How to use autotest

This vignette demonstrates the easiest way to use `autotest`, which is
to apply it continuously through the entire process of package
development. The best way to understand the process is to obtain a local
copy of the vignette itself from [this
link](https://github.com/ropensci-review-tools/autotest/blob/master/vignettes/autotest.Rmd),
and step through the code. We begin by constructing a simple package in
the local
[`tempdir()`](https://stat.ethz.ch/R-manual/R-devel/library/base/html/tempfile.html).

<details closed>
<summary>
<span title="Click to Expand"> Package Construction </span>
</summary>

To create a package in one simple line, we use
[`usethis::create_package()`](https://usethis.r-lib.org/reference/create_package.html),
and name our package `"demo"`.

``` r
path <- file.path (tempdir (), "demo")
usethis::create_package (path, check_name = FALSE, open = FALSE)
#> ✔ Creating '/tmp/RtmpddpQhn/demo/'
#> ✔ Setting active project to '/tmp/RtmpddpQhn/demo'
#> ✔ Creating 'R/'
#> ✔ Writing 'DESCRIPTION'
#> Package: demo
#> Title: What the Package Does (One Line, Title Case)
#> Version: 0.0.0.9000
#> Authors@R (parsed):
#>     * First Last <first.last@example.com> [aut, cre] (YOUR-ORCID-ID)
#> Description: What the package does (one paragraph).
#> License: `use_mit_license()`, `use_gpl3_license()` or friends to pick a
#>     license
#> Encoding: UTF-8
#> Roxygen: list(markdown = TRUE)
#> RoxygenNote: 7.2.3
#> ✔ Writing 'NAMESPACE'
#> ✔ Setting active project to '<no active project>'
```

The structure looks like this:

``` r
fs::dir_tree (path)
#> /tmp/RtmpddpQhn/demo
#> ├── DESCRIPTION
#> ├── NAMESPACE
#> └── R
```

</details>

<br>

Having constructed a minimal package structure, we can then insert some
code in the `R/` directory, including initial
[`roxygen2`](https://roxygen2.r-lib.org) documentation lines, and use
the [`roxygenise()`
function](https://roxygen2.r-lib.org/reference/roxygenize.html) to
create the corresponding `man` files.

`autotest` works by parsing and running “example” code from function
documentation, so our code needs to include at least one example line.

``` r
code <- c ("#' my_function",
           "#'",
           "#' @param x An input",
           "#' @return Something else",
           "#' @examples",
           "#' y <- my_function (x = 1)",
           "#' @export",
           "my_function <- function (x) {",
           "  return (x + 1)",
           "}")
writeLines (code, file.path (path, "R", "myfn.R"))
roxygen2::roxygenise (path)
#> ℹ Loading demo
#> Writing 'NAMESPACE'
#> Writing 'my_function.Rd'
```

Our package now looks like this:

``` r
fs::dir_tree (path)
#> /tmp/RtmpddpQhn/demo
#> ├── DESCRIPTION
#> ├── NAMESPACE
#> ├── R
#> │   └── myfn.R
#> └── man
#>     └── my_function.Rd
```

We can already apply `autotest` to that package to see what happens,
first ensuring that we’ve loaded the package ready to use.

``` r
library (autotest)
x0 <- autotest_package (path)
```

    #> ℹ Loading autotest
    #> ✔ [1 / 1]

We use the [`DT` package](https://rstudio.github.io/DT) to display the
results here.

``` r
DT::datatable (x0, options = list (dom = "t")) # display table only
```

<div class="datatables html-widget html-fill-item-overflow-hidden html-fill-item" id="htmlwidget-4ed791eb9a29c400f727" style="width:100%;height:auto;"></div>
<script type="application/json" data-for="htmlwidget-4ed791eb9a29c400f727">{"x":{"filter":"none","vertical":false,"data":[["1","2","3","4","5","6","7","8","9"],["dummy","dummy","dummy","dummy","dummy","dummy","dummy","dummy","dummy"],["double_is_int","trivial_noise","single_par_as_length_2","return_successful","return_val_described","return_desc_includes_class","return_class_matches_desc","par_is_documented","par_matches_docs"],["my_function","my_function","my_function","my_function","my_function","my_function","my_function","my_function","my_function"],["x","x","x","(return object)","(return object)","(return object)","(return object)","x","x"],["numeric","numeric","single numeric","(return object)","(return object)","(return object)","(return object)",null,null],["Check whether double is only used as int","Add trivial noise to numeric parameter","Length 2 vector for length 1 parameter","Check that function successfully returns an object","Check that description has return value","Check whether description of return value specifies class","Compare class of return value with description","Check that parameter is documented","Check that documentation matches class of input parameter"],["int parameters should have terminal 'L'","(Should yield same result)","Should trigger message, warning, or error",null,null,null,null,null,null],[true,true,true,true,true,true,true,true,true]],"container":"<table class=\"display\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>type<\/th>\n      <th>test_name<\/th>\n      <th>fn_name<\/th>\n      <th>parameter<\/th>\n      <th>parameter_type<\/th>\n      <th>operation<\/th>\n      <th>content<\/th>\n      <th>test<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"dom":"t","columnDefs":[{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false},"selection":{"mode":"multiple","selected":null,"target":"row","selectable":null}},"evals":[],"jsHooks":[]}</script>

The first thing to notice is the first column, which has
`test_type = "dummy"` for all rows. The [`autotest_package()`
function](https://docs.ropensci.org/autotest/reference/autotest_package.html)
has a parameter `test` with a default value of `FALSE`, so that the
default call demonstrated above does not actually implement the tests,
rather it returns an object listing all tests that would be performed
with actually doing so. Applying the tests by setting `test = TRUE`
gives the following result.

``` r
x1 <- autotest_package (path, test = TRUE)
#> ℹ Loading demo
#> ✔ [1 / 1]
DT::datatable (x1, options = list (dom = "t"))
```

<div class="datatables html-widget html-fill-item-overflow-hidden html-fill-item" id="htmlwidget-8baa7e91f6211a1067fe" style="width:100%;height:auto;"></div>
<script type="application/json" data-for="htmlwidget-8baa7e91f6211a1067fe">{"x":{"filter":"none","vertical":false,"data":[["1","2","3"],["error","error","diagnostic"],[null,"return_successful","return_desc_includes_class"],["my_function","my_function","my_function"],[null,"(return object)","(return object)"],[null,"(return object)","(return object)"],["normal function call","error from normal operation","Check whether description of return value specifies class"],[":quote(1)): could not find function \"my_function\"","could not find function \"my_function\"","Function [my_function] returns a value of class [simpleError, error, condition], which differs from the value provided in the description"],[true,true,true]],"container":"<table class=\"display\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>type<\/th>\n      <th>test_name<\/th>\n      <th>fn_name<\/th>\n      <th>parameter<\/th>\n      <th>parameter_type<\/th>\n      <th>operation<\/th>\n      <th>content<\/th>\n      <th>test<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"dom":"t","columnDefs":[{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false},"selection":{"mode":"multiple","selected":null,"target":"row","selectable":null}},"evals":[],"jsHooks":[]}</script>

Of the 9 tests which were performed, only 3 yielded unexpected
behaviour. The first indicates that the parameter `x` has only been used
as an integer, yet was not specified as such. The second states that the
parameter `x` is “assumed to be a single numeric”. `autotest` does its
best to figure out what types of inputs are expected for each parameter,
and with the example only demonstrating `x = 1`, assumes that `x` is
always expected to be a single value. We can resolve the first of these
by replacing `x = 1` with `x = 1.` to clearly indicate that it is not an
integer, and the second by asserting that `length(x) == 1`, as follows:

``` r
code <- c ("#' my_function",
           "#'",
           "#' @param x An input",
           "#' @return Something else",
           "#' @examples",
           "#' y <- my_function (x = 1.)",
           "#' @export",
           "my_function <- function (x) {",
           "  if (length(x) > 1) {",
           "    warning(\"only the first value of x will be used\")",
           "    x <- x [1]",
           "  }",
           "  return (x + 1)",
           "}")
writeLines (code, file.path (path, "R", "myfn.R"))
roxygen2::roxygenise (path)
#> ℹ Loading demo
#> Writing 'my_function.Rd'
```

This is then sufficient to pass all `autotest` tests and so return
`NULL`.

``` r
autotest_package (path, test = TRUE)
#> ✔ [1 / 1]
#> # A tibble: 3 × 8
#>   type       test_name  fn_name parameter parameter_type operation content test 
#>   <chr>      <chr>      <chr>   <chr>     <chr>          <chr>     <chr>   <lgl>
#> 1 error      <NA>       my_fun… <NA>      <NA>           normal f… ":quot… TRUE 
#> 2 error      return_su… my_fun… (return … (return objec… error fr… "could… TRUE 
#> 3 diagnostic return_de… my_fun… (return … (return objec… Check wh… "Funct… TRUE
```

## Integer input

Note that `autotest` distinguishes integer and non-integer types by
their
[`storage.mode`](https://stat.ethz.ch/R-manual/R-devel/library/base/html/mode.html)
of `"integer"` and `"double"`, and not by their respective classes of
`"integer"` and `"numeric"`, because `"numeric"` is ambiguous in R, and
`is.numeric(1L)` is `TRUE`, even though `storage.mode(1L)` is
`"integer"`, and not `"numeric"`. Replacing `x = 1` with `x = 1.`
explicitly identifies that parameter as a `"double"` parameter, and
allowed the preceding tests to pass. Note what happens if we instead
specify that parameter as an integer (`x = 1L`).

``` r
code [6] <- gsub ("1\\.", "1L", code [6])
writeLines (code, file.path (path, "R", "myfn.R"))
roxygen2::roxygenise (path)
#> ℹ Loading demo
#> Writing 'my_function.Rd'
x2 <- autotest_package (path, test = TRUE)
#> ✔ [1 / 1]
DT::datatable (x2, options = list (dom = "t"))
```

<div class="datatables html-widget html-fill-item-overflow-hidden html-fill-item" id="htmlwidget-5de00d9c1435038aac3a" style="width:100%;height:auto;"></div>
<script type="application/json" data-for="htmlwidget-5de00d9c1435038aac3a">{"x":{"filter":"none","vertical":false,"data":[["1","2","3","4","5"],["error","error","error","diagnostic","diagnostic"],[null,null,"return_successful","int_range","return_desc_includes_class"],["my_function","my_function","my_function","my_function","my_function"],[null,null,"(return object)","x","(return object)"],[null,null,"(return object)","single integer","(return object)"],["normal function call",null,"error from normal operation","Ascertain permissible range","Check whether description of return value specifies class"],[":quote(structure(1L, is_int = TRUE))): could not find function \"my_function\"",":quote(structure(1L, is_int = TRUE))): could not find function \"my_function\"","could not find function \"my_function\"","Function [my_function] does not respond appropriately for specified/default input [x = 1]","Function [my_function] returns a value of class [simpleError, error, condition], which differs from the value provided in the description"],[true,true,true,true,true]],"container":"<table class=\"display\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>type<\/th>\n      <th>test_name<\/th>\n      <th>fn_name<\/th>\n      <th>parameter<\/th>\n      <th>parameter_type<\/th>\n      <th>operation<\/th>\n      <th>content<\/th>\n      <th>test<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"dom":"t","columnDefs":[{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false},"selection":{"mode":"multiple","selected":null,"target":"row","selectable":null}},"evals":[],"jsHooks":[]}</script>

That then generates two additional messages, the second of which
reflects an expectation that parameters assumed to be integer-valued
should assert that, for example by converting with `as.integer()`. The
following suffices to remove that message.

``` r
code <- c (code [1:12],
           "  if (is.numeric (x))",
           "    x <- as.integer (x)",
           code [13:length (code)])
```

The remaining message concerns integer ranges. For any parameters which
`autotest` identifies as single integers, routines will try a full range
of values between `+/- .Machine$integer.max`, to ensure that all values
are appropriately handled. Many routines may sensibly allow unrestricted
ranges, while many others may not implement explicit control over
permissible ranges, yet may error on, for example, unexpectedly large
positive or negative values. The content of the diagnostic message
indicates one way to resolve this issue, which is simply by describing
the input as `"unrestricted"`.

``` r
code [3] <- gsub ("An input", "An unrestricted input", code [3])
writeLines (code, file.path (path, "R", "myfn.R"))
roxygen2::roxygenise (path)
#> ℹ Loading demo
#> Writing 'my_function.Rd'
autotest_package (path, test = TRUE)
#> ✔ [1 / 1]
#> # A tibble: 5 × 8
#>   type       test_name  fn_name parameter parameter_type operation content test 
#>   <chr>      <chr>      <chr>   <chr>     <chr>          <chr>     <chr>   <lgl>
#> 1 error      <NA>       my_fun… <NA>      <NA>           normal f… ":quot… TRUE 
#> 2 error      <NA>       my_fun… <NA>      <NA>           <NA>      ":quot… TRUE 
#> 3 error      return_su… my_fun… (return … (return objec… error fr… "could… TRUE 
#> 4 diagnostic int_range  my_fun… x         single integer Ascertai… "Funct… TRUE 
#> 5 diagnostic return_de… my_fun… (return … (return objec… Check wh… "Funct… TRUE
```

An alternative, and frequently better way, is to ensure and document
specific control over permissible ranges, as in the following revision
of our function.

``` r
code <- c ("#' my_function",
           "#'",
           "#' @param x An input between 0 and 10",
           "#' @return Something else",
           "#' @examples",
           "#' y <- my_function (x = 1L)",
           "#' @export",
           "my_function <- function (x) {",
           "  if (length(x) > 1) {",
           "    warning(\"only the first value of x will be used\")",
           "    x <- x [1]",
           "  }",
           "  if (is.numeric (x))",
           "    x <- as.integer (x)",
           "  if (x < 0 | x > 10) {",
           "    stop (\"x must be between 0 and 10\")",
           "  }",
           "  return (x + 1L)",
           "}")
writeLines (code, file.path (path, "R", "myfn.R"))
roxygen2::roxygenise (path)
#> ℹ Loading demo
#> Writing 'my_function.Rd'
autotest_package (path, test = TRUE)
#> ✔ [1 / 1]
#> # A tibble: 5 × 8
#>   type       test_name  fn_name parameter parameter_type operation content test 
#>   <chr>      <chr>      <chr>   <chr>     <chr>          <chr>     <chr>   <lgl>
#> 1 error      <NA>       my_fun… <NA>      <NA>           normal f… ":quot… TRUE 
#> 2 error      <NA>       my_fun… <NA>      <NA>           <NA>      ":quot… TRUE 
#> 3 error      return_su… my_fun… (return … (return objec… error fr… "could… TRUE 
#> 4 diagnostic int_range  my_fun… x         single integer Ascertai… "Funct… TRUE 
#> 5 diagnostic return_de… my_fun… (return … (return objec… Check wh… "Funct… TRUE
```

Respective limits of ranges may be specified with any of the following
words:

- Lower limits: “more”, “greater”, “larger than”, “lower limit of”,
  “above”
- Upper limits: “less”, “lower”, “smaller than”, “upper limit of”,
  “below”

## Vector input

The initial test results above suggested that the input was *assumed* to
be of length one. Let us now revert our function to its original format
which accepted vectors of length \> 1, and include an example
demonstrating such input.

``` r
code <- c ("#' my_function",
           "#'",
           "#' @param x An input",
           "#' @return Something else",
           "#' @examples",
           "#' y <- my_function (x = 1)",
           "#' y <- my_function (x = 1:2)",
           "#' @export",
           "my_function <- function (x) {",
           "  if (is.numeric (x)) {",
           "    x <- as.integer (x)",
           "  }",
           "  return (x + 1L)",
           "}")
writeLines (code, file.path (path, "R", "myfn.R"))
roxygen2::roxygenise (path)
#> ℹ Loading demo
#> Writing 'my_function.Rd'
```

Note that the first example no longer has `x = 1L`. This is because
vector inputs are identified as `integer` by examining all individual
values, and presuming `integer` representations for any parameters for
which all values are whole numbers, regardless of `storage.mode`.

``` r
x3 <- autotest_package (path, test = TRUE)
#> ✔ [1 / 2]
#> ✔ [2 / 2]
DT::datatable (x3, options = list (dom = "t"))
```

<div class="datatables html-widget html-fill-item-overflow-hidden html-fill-item" id="htmlwidget-f8d9835e7d95c55f5a9e" style="width:100%;height:auto;"></div>
<script type="application/json" data-for="htmlwidget-f8d9835e7d95c55f5a9e">{"x":{"filter":"none","vertical":false,"data":[["1","2","3","4","5"],["error","error","error","error","diagnostic"],[null,"return_successful",null,null,"return_desc_includes_class"],["my_function","my_function","my_function","my_function","my_function"],[null,"(return object)",null,null,"(return object)"],[null,"(return object)",null,null,"(return object)"],["normal function call","error from normal operation",null,"normal function call","Check whether description of return value specifies class"],[":quote(1)): could not find function \"my_function\"","could not find function \"my_function\"",":quote(1:2)): could not find function \"my_function\"",":quote(1:2)): could not find function \"my_function\"","Function [my_function] returns a value of class [simpleError, error, condition], which differs from the value provided in the description"],[true,true,true,true,true]],"container":"<table class=\"display\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>type<\/th>\n      <th>test_name<\/th>\n      <th>fn_name<\/th>\n      <th>parameter<\/th>\n      <th>parameter_type<\/th>\n      <th>operation<\/th>\n      <th>content<\/th>\n      <th>test<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"dom":"t","columnDefs":[{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false},"selection":{"mode":"multiple","selected":null,"target":"row","selectable":null}},"evals":[],"jsHooks":[]}</script>

### List-column conversion

The above result reflects one of the standard tests, which is to
determine whether list-column formats are appropriately processed.
List-columns commonly arise when using (either directly or indirectly),
the [`tidyr::nest()`
function](https://tidyr.tidyverse.org/reference/nest.html), or
equivalently in base R with the [`I` or `AsIs`
function](https://stat.ethz.ch/R-manual/R-devel/library/base/html/AsIs.html).
They look like this:

``` r
dat <- data.frame (x = 1:3, y = 4:6)
dat$x <- I (as.list (dat$x)) # base R
dat <- tidyr::nest (dat, y = y)
print (dat)
#> # A tibble: 3 × 2
#>   x         y               
#>   <I<list>> <list>          
#> 1 <int [1]> <tibble [1 × 1]>
#> 2 <int [1]> <tibble [1 × 1]>
#> 3 <int [1]> <tibble [1 × 1]>
```

The use of packages like [`tidyr`](https://tidyr.tidyverse.org) and
[`purrr`](https://purrr.tidyverse.org) quite often leads to
[`tibble`](https://tibble.tidyverse.org)-class inputs which contain
list-columns. Any functions which fail to identify and appropriately
respond to such inputs may generate unexpected errors, and this
`autotest` is intended to enforce appropriate handling of these kinds of
inputs. The following lines demonstrate the kinds of results that can
arise without such checks.

``` r
m <- mtcars
head (m, n = 2L)
#>               mpg cyl disp  hp drat    wt  qsec vs am gear carb
#> Mazda RX4      21   6  160 110  3.9 2.620 16.46  0  1    4    4
#> Mazda RX4 Wag  21   6  160 110  3.9 2.875 17.02  0  1    4    4
m$mpg <- I (as.list (m$mpg))
head (m, n = 2L) # looks exaxtly the same
#>               mpg cyl disp  hp drat    wt  qsec vs am gear carb
#> Mazda RX4      21   6  160 110  3.9 2.620 16.46  0  1    4    4
#> Mazda RX4 Wag  21   6  160 110  3.9 2.875 17.02  0  1    4    4
cor (m)
#> Error in cor(m): 'x' must be numeric
```

In contrast, many functions either assume inputs to be lists, and
convert when not, or implicitly `unlist`. Either way, such functions may
respond entirely consistently regardless of the presence of
list-columns, like this:

``` r
m$mpg <- paste0 ("a", m$mpg)
class (m$mpg)
#> [1] "character"
```

The list-column `autotest` is intended to enforce consistent behaviour
in response to list-column inputs. One way to identify list-column
formats is to check the value of `class(unclass(.))` of each column. The
`unclass` function is necessary to first remove any additional class
attributes, such as `I` in `dat$x` above. A modified version of our
function which identifies and responds to list-column inputs might look
like this:

``` r
code <- c ("#' my_function",
           "#'",
           "#' @param x An input",
           "#' @return Something else",
           "#' @examples",
           "#' y <- my_function (x = 1)",
           "#' y <- my_function (x = 1:2)",
           "#' @export",
           "my_function <- function (x) {",
           "  if (methods::is (unclass (x), \"list\")) {",
           "    x <- unlist (x)",
           "  }",
           "  if (is.numeric (x)) {",
           "    x <- as.integer (x)",
           "  }",
           "  return (x + 1L)",
           "}")
writeLines (code, file.path (path, "R", "myfn.R"))
roxygen2::roxygenise (path)
#> ℹ Loading demo
```

That change once again leads to clean `autotest` results:

``` r
autotest_package (path, test = TRUE)
#> ✔ [1 / 2]
#> ✔ [2 / 2]
#> # A tibble: 5 × 8
#>   type       test_name  fn_name parameter parameter_type operation content test 
#>   <chr>      <chr>      <chr>   <chr>     <chr>          <chr>     <chr>   <lgl>
#> 1 error      <NA>       my_fun… <NA>      <NA>           <NA>      ":quot… TRUE 
#> 2 error      <NA>       my_fun… <NA>      <NA>           normal f… ":quot… TRUE 
#> 3 error      return_su… my_fun… (return … (return objec… error fr… "could… TRUE 
#> 4 error      <NA>       my_fun… <NA>      <NA>           normal f… ":quot… TRUE 
#> 5 diagnostic return_de… my_fun… (return … (return objec… Check wh… "Funct… TRUE
```

Of course simply attempting to `unlist` a complex list-column may be
dangerous, and it may be preferable to issue some kind of message or
warning, or even either simply remove any list-columns entirely or
generate an error. Replacing the above, potentially dangerous, line,
`x <- unlist (x)` with a simple `stop("list-columns are not allowed")`
will also produce clean `autotest` results.

## Return results and documentation

Functions which return complicated results, such as objects with
specific classes, need to document those class types, and `autotest`
compares return objects with documentation to ensure that this is done.
The following code constructs a new function to demonstrate some of the
ways `autotest` inspects return objects, demonstrating a vector input
(`length(x) > 1`) in the example to avoid messages regarding length
checks an integer ranges.

``` r
code <- c ("#' my_function3",
           "#'",
           "#' @param x An input",
           "#' @examples",
           "#' y <- my_function3 (x = 1:2)",
           "#' @export",
           "my_function3 <- function (x) {",
           "  return (datasets::iris)",
           "}")
writeLines (code, file.path (path, "R", "myfn3.R"))
roxygen2::roxygenise (path) # need to update docs with seed param
#> ℹ Loading demo
#> Writing 'NAMESPACE'
#> Writing 'my_function3.Rd'
x4 <- autotest_package (path, test = TRUE)
#> ✔ [1 / 2]
#> ✔ [2 / 2]
DT::datatable (x4, options = list (dom = "t"))
```

<div class="datatables html-widget html-fill-item-overflow-hidden html-fill-item" id="htmlwidget-796f5742552a9e86d0d3" style="width:100%;height:auto;"></div>
<script type="application/json" data-for="htmlwidget-796f5742552a9e86d0d3">{"x":{"filter":"none","vertical":false,"data":[["1","2","3","4","5"],["error","error","error","error","diagnostic"],[null,"return_successful",null,null,"return_desc_includes_class"],["my_function","my_function","my_function","my_function","my_function"],[null,"(return object)",null,null,"(return object)"],[null,"(return object)",null,null,"(return object)"],["normal function call","error from normal operation",null,"normal function call","Check whether description of return value specifies class"],[":quote(1)): could not find function \"my_function\"","could not find function \"my_function\"",":quote(1:2)): could not find function \"my_function\"",":quote(1:2)): could not find function \"my_function\"","Function [my_function] returns a value of class [simpleError, error, condition], which differs from the value provided in the description"],[true,true,true,true,true]],"container":"<table class=\"display\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>type<\/th>\n      <th>test_name<\/th>\n      <th>fn_name<\/th>\n      <th>parameter<\/th>\n      <th>parameter_type<\/th>\n      <th>operation<\/th>\n      <th>content<\/th>\n      <th>test<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"dom":"t","columnDefs":[{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false},"selection":{"mode":"multiple","selected":null,"target":"row","selectable":null}},"evals":[],"jsHooks":[]}</script>

Several new diagnostic messages are then issued regarding the
description of the returned value. Let’s insert a description to see the
effect.

``` r
code <- c (code [1:3],
           "#' @return The iris data set as dataframe",
           code [4:length (code)])
writeLines (code, file.path (path, "R", "myfn3.R"))
roxygen2::roxygenise (path) # need to update docs with seed param
#> ℹ Loading demo
#> Writing 'my_function3.Rd'
x5 <- autotest_package (path, test = TRUE)
#> ✔ [1 / 2]
#> ✔ [2 / 2]
DT::datatable (x5, options = list (dom = "t"))
```

<div class="datatables html-widget html-fill-item-overflow-hidden html-fill-item" id="htmlwidget-d82e29eaf5cb2b064d90" style="width:100%;height:auto;"></div>
<script type="application/json" data-for="htmlwidget-d82e29eaf5cb2b064d90">{"x":{"filter":"none","vertical":false,"data":[["1","2","3","4","5"],["error","error","error","error","diagnostic"],[null,"return_successful",null,null,"return_desc_includes_class"],["my_function","my_function","my_function","my_function","my_function"],[null,"(return object)",null,null,"(return object)"],[null,"(return object)",null,null,"(return object)"],["normal function call","error from normal operation",null,"normal function call","Check whether description of return value specifies class"],[":quote(1)): could not find function \"my_function\"","could not find function \"my_function\"",":quote(1:2)): could not find function \"my_function\"",":quote(1:2)): could not find function \"my_function\"","Function [my_function] returns a value of class [simpleError, error, condition], which differs from the value provided in the description"],[true,true,true,true,true]],"container":"<table class=\"display\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>type<\/th>\n      <th>test_name<\/th>\n      <th>fn_name<\/th>\n      <th>parameter<\/th>\n      <th>parameter_type<\/th>\n      <th>operation<\/th>\n      <th>content<\/th>\n      <th>test<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"dom":"t","columnDefs":[{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false},"selection":{"mode":"multiple","selected":null,"target":"row","selectable":null}},"evals":[],"jsHooks":[]}</script>

That result still contains a couple of diagnostic messages, but it is
now pretty clear what we need to do, which is to be precise with our
specification of the class of return object. The following then suffices
to once again generate clean `autotest` results.

``` r
code [4] <- "#' @return The iris data set as data.frame"
writeLines (code, file.path (path, "R", "myfn3.R"))
roxygen2::roxygenise (path) # need to update docs with seed param
#> ℹ Loading demo
#> Writing 'my_function3.Rd'
autotest_package (path, test = TRUE)
#> ✔ [1 / 2]
#> ✔ [2 / 2]
#> # A tibble: 5 × 8
#>   type       test_name  fn_name parameter parameter_type operation content test 
#>   <chr>      <chr>      <chr>   <chr>     <chr>          <chr>     <chr>   <lgl>
#> 1 error      <NA>       my_fun… <NA>      <NA>           normal f… ":quot… TRUE 
#> 2 error      return_su… my_fun… (return … (return objec… error fr… "could… TRUE 
#> 3 error      <NA>       my_fun… <NA>      <NA>           <NA>      ":quot… TRUE 
#> 4 error      <NA>       my_fun… <NA>      <NA>           normal f… ":quot… TRUE 
#> 5 diagnostic return_de… my_fun… (return … (return objec… Check wh… "Funct… TRUE
```

### Documentation of input parameters

Similar checks are performed on the documentation of input parameters,
as demonstrated by the following modified version of the preceding
function.

``` r
code <- c ("#' my_function3",
           "#'",
           "#' @param x An input",
           "#' @return The iris data set as data.frame",
           "#' @examples",
           "#' y <- my_function3 (x = datasets::iris)",
           "#' @export",
           "my_function3 <- function (x) {",
           "  return (x)",
           "}")
writeLines (code, file.path (path, "R", "myfn3.R"))
roxygen2::roxygenise (path) # need to update docs with seed param
#> ℹ Loading demo
#> Writing 'my_function3.Rd'
x6 <- autotest_package (path, test = TRUE)
#> ✔ [1 / 2]
#> ✔ [2 / 2]
DT::datatable (x6, options = list (dom = "t"))
```

<div class="datatables html-widget html-fill-item-overflow-hidden html-fill-item" id="htmlwidget-4a92585410c831daceb2" style="width:100%;height:auto;"></div>
<script type="application/json" data-for="htmlwidget-4a92585410c831daceb2">{"x":{"filter":"none","vertical":false,"data":[["1","2","3","4","5"],["error","error","error","error","diagnostic"],[null,null,"return_successful",null,"return_desc_includes_class"],["my_function","my_function","my_function","my_function","my_function"],[null,null,"(return object)",null,"(return object)"],[null,null,"(return object)",null,"(return object)"],[null,"normal function call","error from normal operation","normal function call","Check whether description of return value specifies class"],[":quote(1:2)): could not find function \"my_function\"",":quote(1:2)): could not find function \"my_function\"","could not find function \"my_function\"",":quote(1)): could not find function \"my_function\"","Function [my_function] returns a value of class [simpleError, error, condition], which differs from the value provided in the description"],[true,true,true,true,true]],"container":"<table class=\"display\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>type<\/th>\n      <th>test_name<\/th>\n      <th>fn_name<\/th>\n      <th>parameter<\/th>\n      <th>parameter_type<\/th>\n      <th>operation<\/th>\n      <th>content<\/th>\n      <th>test<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"dom":"t","columnDefs":[{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false},"selection":{"mode":"multiple","selected":null,"target":"row","selectable":null}},"evals":[],"jsHooks":[]}</script>

This warning again indicates precisely how it can be rectified, for
example by replacing the third line with

``` r
code [3] <- "#' @param x An input which can be a data.frame"
```

## General Procedure

The demonstrations above hopefully suffice to indicate the general
procedure which `autotest` attempts to make as simple as possible. This
procedure consists of the following single point:

- From the moment you develop your first function, and every single time
  you modify your code, do whatever steps are necessary to ensure
  `autotest_package()` returns `NULL`.

This vignette has only demonstrated a few of the tests included in the
package, but as long as you use `autotest` throughout the entire process
of package development, any additional diagnostic messages should
include sufficient information for you to be able to restructure your
code to avoid them.
