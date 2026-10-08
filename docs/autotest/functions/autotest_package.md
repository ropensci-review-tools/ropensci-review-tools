# autotest_package

## Description

Automatically test an entire package by tracing calls made in its
documented examples (and, for local source packages, its test suite) with
`typetracer`, then testing each traced function call in turn.

## Usage

```r
autotest_package(
  package = ".",
  functions = NULL,
  exclude = NULL,
  test = FALSE,
  test_data = NULL,
  progress = c("bar", "tests", "none")
)
```

## Arguments

* `package`: Name of package, as either
1. Path to local package source
1. Name of installed package
1. Full path to location of installed package if not on
[.libPaths](.libPaths), or
1. Default which presumes current directory is within package to be
tested.
* `functions`: Optional character vector containing names of functions of
nominated package to be included in 'autotesting'.
* `exclude`: Optional character vector containing names of any functions of
nominated package to be excluded from 'autotesting'.
* `test`: If `FALSE`, return only descriptions of tests which would be run
with `test = TRUE`, without actually running them.
* `test_data`: Result returned from calling either [autotest_types](autotest_types) or
[autotest_package](autotest_package) with `test = FALSE` that contains a list of all tests
which would be conducted. These tests have an additional flag, `test`, which
defaults to `TRUE`. Setting any tests to `FALSE` will avoid running them when
`test = TRUE`.
* `progress`: Style of progress display while testing functions, one of:
* `"bar"` (default) A `cli` progress bar. Automatically falls back
to `"none"` when called from within a `knitr` document, to avoid
literal ANSI escape sequences leaking into the rendered output.
* `"tests"` One line per function tested, showing `[i / n]`.
* `"none"` No progress display at all.

## Note

Some columns may contain NA values, including:

* `parameer` and `parameter_type`, for tests applied to entire
functions, such as tests of return values.
* `test_name` for warnings or errors generated through "normal"
function calls generated directly from example code, in which case `type`
will be "warning" or "error", and `content` will contain the content of
the corresponding message.

## Seealso

Other main_functions:
`[autotest_types()](autotest_types)`

## Concept

main_functions

## Value

An `autotest_package` object which is derived from a `tibble``tbl_df` object. This has one row for each test, and the following eight
columns:

1. `type` The type of result, either "dummy" for `test = FALSE`, or one
of "error", "warning", "diagnostic", or "message".
1. `test_name` Name of each test
1. `fn_name` Name of function being tested
1. `parameter` Name of parameter being tested
1. `parameter_type` Expected type of parameter as identified by
`autotest`.
1. `operation` Description of the test
1. `content` For `test = FALSE`, the expected behaviour of the
test; for `test = TRUE`, the observed discrepancy with that expected
behaviour
1. `test` If `FALSE` (default), list all tests without
implementing them, otherwise implement all tests.

Some columns may contain NA values, as explained in the Note.

## Examples

```r
x <- autotest_package (package = "stats", functions = "var", test = FALSE)
x
```


