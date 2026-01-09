# Install 'ctags' from a clone of the 'git' repository

## Description

'ctags' is installed with this package on both Windows and macOS systems;
this is an additional function to install from source on Unix systems.

## Usage

```r
ctags_install(bin_dir = NULL, sudo = TRUE)
```

## Arguments

* `bin_dir`: This parameter only has an effect on *nix-type operating
systems (such as Linux), on which it's a prefix to pass to the
`autoconf` configure command defining location to install the binary, with
default of `/usr/local`.
* `sudo`: Set to `FALSE` if `sudo` is not available, in which case a
value for `bin_dir` will also have to be explicitly specified, and be a
location where a binary is able to be installed without `sudo` privileges.

## Seealso

Other tags: 
`[ctags_test](ctags_test)()`,
`[tags_data](tags_data)()`

## Concept

tags

## Value

Nothing; the function will fail if installation fails, otherwise
returns nothing.

## Examples

```r
ctags_install (bin_dir = "/usr/local") # default Linux location.
```


