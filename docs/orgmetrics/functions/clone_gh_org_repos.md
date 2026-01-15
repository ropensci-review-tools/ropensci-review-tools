# Clone or update all repositories defined in 'packages.json'

## Description

Clone or update all repositories defined in 'packages.json'

## Usage

```r
clone_gh_org_repos(pkgs_json = NULL, pkgs_dir = NULL)
```

## Arguments

* `pkgs_json`: Local path to 'packages.json' as created or updated by
running [om_packages_json](om_packages_json). That function must be run first, prior to
calling this function!
* `pkgs_dir`: Defaults to cloning repositories in the root directory of
'packages.json'. A specific path may be specified here to clone elsewhere.

## Value

Function primarily called for side-effect of clone or updating all
repositories defined in 'packages.json', but does invisibly return a vector
of paths to all local repositories of R packages as listed in `pkgs_json`.


