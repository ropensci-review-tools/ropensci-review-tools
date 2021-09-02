# `autotest_obj`

autotest_obj class definition


## Description

This function exists only to provide the class definitions for test objects,
 and is not intended to be called directly.


## Usage

```r
autotest_obj(
  package = NA_character_,
  package_loc = NULL,
  test_name = NA_character_,
  fn_name = NA_character_,
  parameters = list(),
  parameter_types = NA_character_,
  class = NULL,
  classes = NULL,
  env = new.env(),
  test = FALSE,
  quiet = FALSE
)
```


## Arguments

Argument      |Description
------------- |----------------
`package`     |     Name of package for which object is to be constructed.
`package_loc`     |     Location of package on local system (for source packages only)
`test_name`     |     Name of test (use [autotest_types](#autotesttypes) to get all test names).
`fn_name`     |     Name of function to be tested.
`parameters`     |     Names of all parameters for that function.
`parameter_types`     |     Types of input parameters.
`class`     |     Class of an individual parameter.
`classes`     |     Classes of all parameters.
`env`     |     Environment in which tests are to be run.
`test`     |     If `FALSE` , return only descriptions of tests which would be run with `test = TRUE` , without actually running them.
`quiet`     |     If `FALSE` , issue progress and other messages during testing of object.


