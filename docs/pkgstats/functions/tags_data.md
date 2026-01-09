# use ctags and gtags to parse call data

## Description

use ctags and gtags to parse call data

## Usage

```r
tags_data(path, has_tabs = NULL, pkg_name = NULL)
```

## Arguments

* `path`: Path to local repository
* `has_tabs`: A logical flag indicating whether or not the code contains
any tab characters. This can be determined from [loc_stats](loc_stats), which has a
`tabs` column. If not given, that value will be extracted from internally
calling that function.
* `pkg_name`: Only used for external_call_network, to label
package-internal calls.

## Seealso

Other tags: 
`[ctags_install](ctags_install)()`,
`[ctags_test](ctags_test)()`

## Concept

tags

## Value

A list of three items:

* "network" A `data.frame` of relationships between objects, generally as
calls between functions in R, but other kinds of relationships in other
source languages. This is effectively an edge-based network representation,
and the data frame also include network metrics for each edge, calculated
through representing the network in both directed (suffix "_dir") and
undirected (suffix "_undir") forms.
* "objects" A `data.frame` of statistics on each object (generally
functions in R, and other kinds of objects in other source languages),
including the kind of object, the language, numbers of lines-of-code,
parameters, and lines of documentation, and a binary flag indicating whether
or not R functions accept "three-dots" parameters (`...`).
* "external_calls" A `data.frame` of every call from within every R
function to any external R package, including base and recommended packages.
The location of each calls is recorded, along with the external function and
package being called.

## Examples

```r
f <- system.file ("extdata", "pkgstats_9.9.tar.gz", package = "pkgstats")
# have to extract tarball to call function on source code:
path <- extract_tarball (f)
if (ctags_test (noerror = TRUE)) withAutoprint({ # examplesIf
tags <- tags_data (path)
}) # examplesIf
```


