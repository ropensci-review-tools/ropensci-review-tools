# `tags_data`

use ctags and gtags to parse call data


## Description

use ctags and gtags to parse call data


## Usage

```r
tags_data(path, has_tabs = NULL, pkg_name)
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


