# List available check group names

## Description

Returns the names of all registered check groups.
Use these names with `[checks_by_group()](checks_by_group)` to select checks by group,
or with `options(goodpractice.exclude_check_groups = ...)` to skip
groups.
Full descriptions of each check group are return by
`[describe_check_groups()](describe_check_groups)`.

## Usage

```r
all_check_groups()
```

## Seealso

Other check_groups:
`[all_checks()](all_checks)`,
`[checks_by_group()](checks_by_group)`,
`[default_checks()](default_checks)`,
`[describe_check()](describe_check)`,
`[describe_check_groups()](describe_check_groups)`,
`[tidyverse_checks()](tidyverse_checks)`

## Concept

check_groups

## Value

A character vector of check group names.

## Examples

```r
# Names of all check groups:
all_check_groups()

# List individual checks by group:
chks <- lapply(all_check_groups(), checks_by_group)
names(chks) <- all_check_groups()
chks
```


