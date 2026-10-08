# List the names of tidyverse style checks

## Description

These checks are optional and not included in the default set.
They are powered by `[lint_package](https://rdrr.io/pkg/lintr/man/lint.html)` using lintr's
default linter set and respect any `.lintr` configuration file
in the package root (e.g. to disable specific linters or add exclusions).
Add them via `checks = c(default_checks(), tidyverse_checks())`.

## Usage

```r
tidyverse_checks()
```

## Seealso

Other check_groups:
`[all_check_groups()](all_check_groups)`,
`[all_checks()](all_checks)`,
`[checks_by_group()](checks_by_group)`,
`[default_checks()](default_checks)`,
`[describe_check()](describe_check)`,
`[describe_check_groups()](describe_check_groups)`

## Concept

check_groups

## Value

Character vector of tidyverse check names

## Examples

```r
tidyverse_checks()
```


