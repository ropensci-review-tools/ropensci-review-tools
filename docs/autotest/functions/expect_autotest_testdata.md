# expect_autotest_testdata

## Description

Expect `autotest_package()` to be clear of errors with some tests switched
off, and to have note column explaining why those tests are not run.

## Usage

```r
expect_autotest_testdata(object)
```

## Arguments

* `object`: An `autotest_package` object with a `test` column flagging
tests which are not to be run on the local package.

## Seealso

Other expectations:
`[expect_autotest_no_err()](expect_autotest_no_err)`,
`[expect_autotest_no_testdata()](expect_autotest_no_testdata)`,
`[expect_autotest_no_warn()](expect_autotest_no_warn)`,
`[expect_autotest_notes()](expect_autotest_notes)`

## Concept

expectations

## Value

(invisibly) The autotest object

## Examples

```r
test_data <- autotest_types (notest = "vector_to_list_col")

# Called within a 'testthat' test file of the local package itself:
testthat::test_that ("autotest", {
    testthat::expect_success (expect_autotest_testdata (test_data))
})
```


