# expect_autotest_no_warn

## Description

Expect `autotest_package()` to be clear of warnings

## Usage

```r
expect_autotest_no_warn(object)
```

## Arguments

* `object`: An `autotest` object to be tested

## Seealso

Other expectations:
`[expect_autotest_no_err()](expect_autotest_no_err)`,
`[expect_autotest_no_testdata()](expect_autotest_no_testdata)`,
`[expect_autotest_notes()](expect_autotest_notes)`,
`[expect_autotest_testdata()](expect_autotest_testdata)`

## Concept

expectations

## Value

(invisibly) The same object

## Examples

```r
x <- autotest_package (package = "stats", functions = "cov", test = TRUE)
testthat::expect_failure (expect_autotest_no_warn (x))
```


