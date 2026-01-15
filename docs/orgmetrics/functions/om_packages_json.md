# Collate and write the 'package.json' file for org

## Description

Collate and write the 'package.json' file for org

## Usage

```r
om_packages_json(org_path = NULL)
```

## Arguments

* `org_path`: Path to root directory of organization repositories. Should
contain sub-directories for different GitHub organizations. These
sub-directories may be initially empty, and will be populated by the
(currently interanl) function, `clone_gh_org_repos()`.

## Value

Path to 'packages.json' file containing data on all repositories
within organization(s).


