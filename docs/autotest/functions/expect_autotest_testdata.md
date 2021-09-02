# `expect_autotest_testdata`

expect_autotest_testdata


## Description

Expect `autotest_package()` to be clear of errors with some tests switched
 off, and to have note column explaining why those tests are not run.


## Usage

```r
expect_autotest_testdata(object)
```


## Arguments

Argument      |Description
------------- |----------------
`object`     |     An `autotest_package` object with a `test` column flagging tests which are not to be run on the local package.


## Value

(invisibly) The autotest object


## Seealso

Other expectations:
 [`expect_autotest_no_err`](#expectautotestnoerr) ,
 [`expect_autotest_no_testdata`](#expectautotestnotestdata) ,
 [`expect_autotest_no_warn`](#expectautotestnowarn) ,
 [`expect_autotest_notes`](#expectautotestnotes)


