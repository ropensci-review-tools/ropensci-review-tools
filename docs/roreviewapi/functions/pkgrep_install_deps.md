# `pkgrep_install_deps`

Install all system and package dependencies of an R package


## Description

Install all system and package dependencies of an R package


## Usage

```r
pkgrep_install_deps(path, os, os_release)
```


## Arguments

Argument      |Description
------------- |----------------
`path`     |     Path to local package
`os`     |     Name of operating system, passed to remotes package to install system dependencies.
`os_release`     |     Name of operating system release, passed to remotes  package to install system dependencies.


## Value

Hopefully a character vector of length zero, otherwise a list of any
 R packages unable to be installed.


