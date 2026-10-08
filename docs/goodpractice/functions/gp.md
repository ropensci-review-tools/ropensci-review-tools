# Run good practice checks

## Description

To see the results, just print it to the screen.

## Usage

```r
gp(
  path = ".",
  checks = default_checks(),
  extra_preps = NULL,
  extra_checks = NULL,
  quiet = TRUE
)
```

## Arguments

* `path`: Path to a package root.
* `checks`: Character vector, the checks to run. Defaults to
`[default_checks](default_checks)`. Use `[all_checks](all_checks)` to list all
checks, or add optional sets like `[tidyverse_checks](tidyverse_checks)`.
When `NULL`, all registered checks are run, subject to any
exclusions from `goodpractice.exclude_check_groups` or
`GP_EXCLUDE_CHECK_GROUPS`.
* `extra_preps`: Custom preparation functions. See
`[make_prep](make_prep)` on creating preparation functions.
* `extra_checks`: Custom checks. See `[make_check](make_check)` on
creating checks.
* `quiet`: Whether to suppress output from the preparation
functions. Note that not all preparation functions produce output,
even if this option is set to `FALSE`.

## Excluding check groups

When using the default `checks = all_checks()`, entire groups of
checks can be excluded by group name via the
`goodpractice.exclude_check_groups` option or the
`GP_EXCLUDE_CHECK_GROUPS` environment variable (comma-separated).
The option takes precedence.

```
# Skip URL and coverage checks:
options(goodpractice.exclude_check_groups = c("urlchecker", "covr"))

# Or via environment variable:
Sys.setenv(GP_EXCLUDE_CHECK_GROUPS = "urlchecker,covr")
```

Exclusion only applies when `checks = NULL` (the default).
Explicit `checks` arguments are never filtered.

## Excluding files

Specific files can be excluded from checks via the
`goodpractice.exclude_path` option or the `GP_EXCLUDE_PATH`environment variable (comma-separated). Paths are relative to the
package root.

```
options(goodpractice.exclude_path = c("R/RcppExports.R", "R/generated.R"))

# Or via environment variable:
Sys.setenv(GP_EXCLUDE_PATH = "R/RcppExports.R,R/generated.R")
```

Excluded files are skipped by lintr, treesitter, expression, and
roxygen2 checks.

## Parallel preparation

Preparation steps run sequentially by default. To run them in
parallel, install `future.apply` and set a
`[plan](https://rdrr.io/pkg/future/man/plan.html)`:

```
future::plan("multisession")
gp(".")
```

Preps run in parallel only when a non-sequential plan is active.
Prep functions must be independent: in parallel mode each prep
receives the initial state snapshot, so a prep cannot read another
prep's output. Only new state fields are merged back; if two preps
write the same field, the second is dropped with a warning.

## Seealso

Other main:
`[goodpractice-package](goodpractice-package)`

## Concept

main

## Value

A goodpractice object that you can query
with a simple API. See `[results](results)` to start.

## Examples

```r
path <- system.file("bad1", package = "goodpractice")
# Run a subset of all checks available
g <- gp(path, checks = all_checks()[9:16])
g
# Or run with named check groups
g <- gp(path, checks = checks_by_group("description", "namespace"))
```


