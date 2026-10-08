# Describe one or more checks

## Description

Describe one or more checks

## Usage

```r
describe_check(check_name = NULL)
```

## Arguments

* `check_name`: Names of checks to be described.

## Seealso

Other check_groups:
`[all_check_groups()](all_check_groups)`,
`[all_checks()](all_checks)`,
`[checks_by_group()](checks_by_group)`,
`[default_checks()](default_checks)`,
`[describe_check_groups()](describe_check_groups)`,
`[tidyverse_checks()](tidyverse_checks)`

## Concept

check_groups

## Value

List of character descriptions for each `check_name`

## Examples

```r
describe_check("rcmdcheck_non_portable_makevars")
check_name <- c("no_description_depends",
                "lintr_assignment_linter",
                "no_import_package_as_a_whole",
                "rcmdcheck_missing_docs")
describe_check(check_name)
# Or to see all checks:

  describe_check(all_checks())
```


