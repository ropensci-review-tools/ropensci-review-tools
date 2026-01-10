# check_cache

## Description

Check whether a package has been cached, and if so, whether commits have been
added to the github repo since cached version.

## Usage

```r
check_cache(org, repo, cache_dir = fs::path_temp())
```

## Arguments

* `org`: Github organization
* `repo`: Github repository
* `cache_dir`: Directory in which packages are cached

## Note

This function is not intended to be called directly, and is only
exported to enable it to be used within the `plumber` API.

## Seealso

Other utils: 
`[pkgrep_install_deps](pkgrep_install_deps)()`,
`[stdout_stderr_cache](stdout_stderr_cache)()`,
`[symbol_crs](symbol_crs)()`,
`[symbol_tck](symbol_tck)()`

## Concept

utils

## Value

FALSE If a package has previously been cached, and the github repo
has not changed; otherwise TRUE.


