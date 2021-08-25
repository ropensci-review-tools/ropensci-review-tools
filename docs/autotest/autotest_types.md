# `autotest_types`

autotest_types


## Description

List all types of 'autotests' currently implemented.


## Usage

```r
autotest_types(notest = NULL)
```


## Arguments

Argument      |Description
------------- |----------------
`notest`     |     Character string of names of tests which should be switched off by setting the `test` column to `FALSE` . Run this function first without this parameter to get all names, then re-run with this parameter switch specified tests off.


## Value

An `autotest` object with each row listing one unique type of test
 which can be applied to every parameter (of the appropriate class) of each
 function.


## Seealso

Other main_functions:
 [`autotest_package`](#autotestpackage)


