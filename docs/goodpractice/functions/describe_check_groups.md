# Describe available check groups

## Description

Returns full descriptions of all registered check groups.

## Usage

```r
describe_check_groups()
```

## Seealso

Other check_groups:
`[all_check_groups()](all_check_groups)`,
`[all_checks()](all_checks)`,
`[checks_by_group()](checks_by_group)`,
`[default_checks()](default_checks)`,
`[describe_check()](describe_check)`,
`[tidyverse_checks()](tidyverse_checks)`

## Concept

check_groups

## Value

A named list of each check group defined in `[all_check_groups()](all_check_groups)`,
with text descriptions of each group.

## Examples

```r
# Names of all check groups:
all_check_groups()

# And corresponding descriptions:
describe_check_groups()
```


