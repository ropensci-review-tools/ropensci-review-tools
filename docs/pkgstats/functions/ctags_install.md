# `ctags_install`

Install 'ctags' from a clone of the 'git' repository


## Description

'ctags' is installed with this package on both Windows and macOS systems;
 this is an additional function to install from source on Unix systems.


## Usage

```r
ctags_install(bin_dir = NULL, sudo = TRUE)
```


## Arguments

Argument      |Description
------------- |----------------
`bin_dir`     |     Prefix to pass to the `autoconf` configure command defining location to install the binary, with default of /usr/local .
`sudo`     |     Set to `FALSE` if `sudo` is not available, in which case a value for `bin_dir` will also have to be explicitly specified, and be a location where a binary is able to be installed without `sudo` privileges.


## Value

Nothing; the function will fail if installation fails, otherwise
 returns nothing.


## Seealso

Other tags:
 [`ctags_test`](#ctagstest) ,
 [`tags_data`](#tagsdata)


## Examples

```r
ctags_install (bin_dir = "/usr/local") # default
```


