# Select checks by check group

## Description

Returns the names of all checks that belong to the given group(s).
This makes it easy to run or inspect a specific category of checks
without knowing individual check names.

## Usage

```r
checks_by_group(...)
```

## Arguments

* `...`: Group names as character strings. Use `[all_check_groups()](all_check_groups)` to
see available names.

## Seealso

Other check_groups:
`[all_check_groups()](all_check_groups)`,
`[all_checks()](all_checks)`,
`[default_checks()](default_checks)`,
`[describe_check()](describe_check)`,
`[describe_check_groups()](describe_check_groups)`,
`[tidyverse_checks()](tidyverse_checks)`

## Concept

check_groups

## Value

Character vector of check names

## Examples

```r
# run only DESCRIPTION and namespace checks
checks_by_group("description", "namespace")

# see what the lintr group covers
checks_by_group("lintr")
# See all checks by group:
lapply(all_check_groups(), checks_by_group)
# use directly in gp()

  gp(".", checks = checks_by_group("description", "lintr"))
```


