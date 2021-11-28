# `tags_data`

use ctags and gtags to parse call data


## Description

use ctags and gtags to parse call data


## Usage

```r
tags_data(path, has_tabs = NULL, pkg_name = NULL)
```


## Arguments

Argument      |Description
------------- |----------------
`path`     |     Path to local repository
`has_tabs`     |     A logical flag indicating whether or not the code contains any tab characters. This can be determined from [loc_stats](#locstats) , which has a `tabs` column. If not given, that value will be extracted from internally calling that function.
`pkg_name`     |     Only used for external_call_network, to label package-internal calls.


## Seealso

Other tags:
 [`ctags_install`](#ctagsinstall) ,
 [`ctags_test`](#ctagstest)


## Examples

```r
f <- system.file ("extdata", "pkgstats_9.9.tar.gz", package = "pkgstats")
# have to extract tarball to call function on source code:
path <- extract_tarball (f)
tags <- tags_data (path)
```


