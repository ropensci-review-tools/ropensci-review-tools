# Defining custom preparations and checks

## Description

Defining custom preparations and checks

## Usage

```r
make_prep(name, func)

make_check(description, check, gp, ...)
```

## Arguments

* `name`: Name of the preparation function.
* `func`: A function that takes two arguments:
The `path` to the root directory of the package, and a logical
argument: `quiet`. If `quiet` is true, the preparation function
may print out diagnostic messages. The output of this function will be
saved as the " `name`" entry of `state`, i.e. of the input for
the  `check`-functions (see example).
* `description`: A description of the check.
* `check`: A function that takes the `state` as an argument.
* `gp`: A short description of what is good practice.
* `...`: Further arguments. Most important: A `preps` argument that
contains the names of all the preparation functions required for the check.

## Functions

* `make_prep()`: Create a preparation function
* `make_check()`: Create a check function

## Seealso

Other API:
`[checks()](checks)`,
`[failed_checks()](failed_checks)`,
`[failed_positions()](failed_positions)`

## Concept

API

## Value

For `make_prep`: a preparation function. For
`make_check`: a check object of class `"check"`.

## Examples

```r
# make a preparation function
url_prep <- make_prep(
  name = "desc", 
  func = function(path, quiet) desc::description$new(path)
)
# and the corresponding check function
url_chk <- make_check(
  description = "URL field in DESCRIPTION",
  tags = character(),
  preps = "desc",
  gp = "have a URL field in DESCRIPTION",
  check = function(state) state$desc$has_fields("URL")
)
# use together in gp():
# (note that you have to list the name of your custom check in
# the checks-argument as well....)
bad1 <- system.file("bad1", package = "goodpractice")
res <- gp(bad1, checks = c("url", "no_description_depends"),
          extra_preps = list("desc" = url_prep),
          extra_checks = list("url" = url_chk))
```


