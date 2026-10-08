# expect_autotest_no_err

## Description

Expect `autotest_package()` to be clear of errors

## Usage

```r
expect_autotest_no_err(object)
```

## Arguments

* `object`: An `autotest` object to be tested

## Seealso

Other expectations:
`[expect_autotest_no_testdata()](expect_autotest_no_testdata)`,
`[expect_autotest_no_warn()](expect_autotest_no_warn)`,
`[expect_autotest_notes()](expect_autotest_notes)`,
`[expect_autotest_testdata()](expect_autotest_testdata)`

## Concept

expectations

## Value

(invisibly) The same object

## Examples

```r
x <- autotest_package (package = "stats", functions = "cov", test = TRUE)
testthat::expect_failure (expect_autotest_no_err (x))
```


