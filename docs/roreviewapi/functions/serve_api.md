# `serve_api`

serve plumber API to report on packages


## Description

The API exposes the single POST points of `report` to download software from
 the given URL and return a textual analysis of its structure and
 functionality.


## Usage

```r
serve_api(port = 8000L, cache_dir = NULL, os = "", os_release = "")
```


## Arguments

Argument      |Description
------------- |----------------
`port`     |     Port for API to be exposed on
`cache_dir`     |     Directory where previously downloaded repositories are cached
`os`     |     Name of operating system, passed to remotes package to install system dependencies.
`os_release`     |     Name of operating system release, passed to remotes  package to install system dependencies.


## Value

Nothing; calling this starts a blocking process.


