# Package Statistics

This vignette describes the statistics collated by `pkgstats`. The first
section provides full descriptions of all data returned by [the main
`pkgstats()`
function](https://docs.ropensci.org/pkgstats/reference/pkgstats.html),
and the second section describes the output of [the `pkgstats_summary()`
function](https://docs.ropensci.org/pkgstats/reference/pkgstats_summary.html)
which converts statistics to a single-row summary. Single-row summaries
from multiple packages can be combined to represent the statistical
properties of multiple packages in a single `data.frame` object. [The
`pkgstats()`
function](https://docs.ropensci.org/pkgstats/reference/pkgstats.html) is
applied to all CRAN packages on a regular basis, with results accessible
with [the `dl_pkgstats_data()`
function](https://docs.ropensci.org/pkgstats/reference/dl_pkgstats_data.html).

## Overview of Package Statistics

The [main `pkgstats()`
function](https://docs.ropensci.org/pkgstats/reference/pkgstats.html)
returns a `list` of eight main components:

1.  `"loc"` summarising “Lines of Code” in package sub-directories and
    languages;
2.  `"vignettes"` containing counts of numbers of vignettes and demos;
3.  `"data_stats"` summarising data files;
4.  `"desc"` summarising the contents of the package “DESCRIPTION” file;
5.  `"translations"` summarising translations into other (human)
    languages;
6.  `"objects"`: a table of all “objects” in all languages;
7.  `"network"`: a table of relationships between objects, such as
    function calls; and
8.  `"external_calls"`: a detailed table of all calls made to all R
    functions.

The following sub-sections provide further detail on these components
(except the simpler components of `"vignettes"`, `"data_stats"`, and
`"translations"`). The results use the output of applying the function
to the source code of this package:

``` r
s <- pkgstats () # run in root directory of `pkgstats` source
```

The result is a list of various data extracted from the code. All except
for `objects` and `network` represent summary data:

``` r
s [!names (s) %in% c ("objects", "network", "external_calls")]
#> $loc
#> # A tibble: 4 × 11
#>   language dir       nfiles nlines ncode nempty nspaces nchars nexpr ntabs
#>   <chr>    <chr>      <int>  <int> <int>  <int>   <int>  <int> <int> <int>
#> 1 C++      src            3    364   276     67     932   6983     1     0
#> 2 R        R             24   4727   345    682     333 114334     1     0
#> 3 R        tests          7    300   234     61     511   5543     1     0
#> 4 Rmd      vignettes      2    347   278     61    1483  11290     1     0
#> # ℹ 1 more variable: indentation <int>
#> 
#> $vignettes
#> vignettes     demos 
#>         2         0 
#> 
#> $data_stats
#>           n  total_size median_size 
#>           0           0           0 
#> 
#> $desc
#>    package verion                     date license
#> 1 pkgstats  0.1.1 Mon Aug 26 10:18:53 2024   GPL-3
#>                                                                                       urls
#> 1 https://docs.ropensci.org/pkgstats/,\nnhttps://github.com/ropensci-review-tools/pkgstats
#>                                                       bugs aut ctb fnd rev ths
#> 1 https://github.com/ropensci-review-tools/pkgstats/issues   1   0   0   0   0
#>   trl depends                                                        imports
#> 1   0      NA brio, checkmate, dplyr, fs, igraph, methods, readr, sys, withr
#>                                                                                          suggests
#> 1 curl, hms, jsonlite, knitr, parallel, pkgbuild, Rcpp, rmarkdown, roxygen2, testthat, visNetwork
#>   enchances linking_to
#> 1      <NA>      cpp11
#> 
#> $translations
#> [1] NA
```

These results demonstrate that many fields use `NA` to denote values of
zero. The following sub-sections explore these various components
generated by the `pkgstats()` function in more detail.

## Lines of Code

The first item in the above list is “loc” for Lines-of-Code, which are
counted using an internal routine specifically developed for R packages,
and which provides more accurate and R-specific information than most
open source code counting libraries. For example, the counts in
`pkgstats` are able to distinguish and separately count code chunks and
text lines in `.Rmd` files.

``` r
s$loc
#> # A tibble: 4 × 11
#>   language dir       nfiles nlines ncode nempty nspaces nchars nexpr ntabs
#>   <chr>    <chr>      <int>  <int> <int>  <int>   <int>  <int> <int> <int>
#> 1 C++      src            3    364   276     67     932   6983     1     0
#> 2 R        R             24   4727   345    682     333 114334     1     0
#> 3 R        tests          7    300   234     61     511   5543     1     0
#> 4 Rmd      vignettes      2    347   278     61    1483  11290     1     0
#> # ℹ 1 more variable: indentation <int>
```

That output includes the following components, grouped by both computer
language and package directory:

1.  `nfiles` = Numbers of files in each directory and language.
2.  `nlines` = Total numbers of lines in all files.
3.  `ncode` = Total numbers of lines of code.
4.  `ndoc` = Total numbers of documentation or comment lines.
5.  `nempty` = Total numbers of empty of blank lines.
6.  `nspaces` = Total numbers of white spaces in all code lines,
    excluding leading indentation spaces.
7.  `nchars` = Total numbers of non-white-space characters in all code
    lines.
8.  `nexpr` = Median numbers of nested expressions in all lines which
    have any expressions (see below).
9.  `ntabs` = Number of lines of code with initial tab indentation.
10. `indentation` = Number of spaces by which code is indented (with
    `-1` denoting tab-indentation).

Numbers of nested expressions are counted as numbers of brackets or
braces of any type nested on a single line. The following line has one
nested bracket:

``` r
x <- myfn ()
```

while the following has four:

``` r
x <- function () { return (myfn ()) }
```

Code with fewer nested expressions per line is generally easier to read,
and this metric is provided as one indication of the general readability
of code. A second relative indication may be extracted by converting
numbers of spaces and characters to a measure of relative numbers of
white spaces, noting that the `nchars` value quantifies total characters
including white spaces.

``` r
index <- which (s$loc$dir %in% c ("R", "src")) # consider source code only
sum (s$loc$nspaces [index]) / sum (s$loc$nchars [index])
#> [1] 0.01042723
```

Finally, the `ntabs` statistic can be used to identify whether code uses
tab characters as indentation, otherwise the `indentation` statistics
indicate median numbers of white spaces by which code is indented. The
`objects`, `network`, and `external_calls` items returned by the
[`pkgstats()`
function](https://docs.ropensci.org/pkgstats/reference/pkgstats.html)
are described further below.

## `"desc"`: The package “DESCRIPTION” file

The `desc` item looks like this:

``` r
s$desc
#>    package verion                     date license
#> 1 pkgstats  0.1.1 Mon Aug 26 10:18:53 2024   GPL-3
#>                                                                                       urls
#> 1 https://docs.ropensci.org/pkgstats/,\nnhttps://github.com/ropensci-review-tools/pkgstats
#>                                                       bugs aut ctb fnd rev ths
#> 1 https://github.com/ropensci-review-tools/pkgstats/issues   1   0   0   0   0
#>   trl depends                                                        imports
#> 1   0      NA brio, checkmate, dplyr, fs, igraph, methods, readr, sys, withr
#>                                                                                          suggests
#> 1 curl, hms, jsonlite, knitr, parallel, pkgbuild, Rcpp, rmarkdown, roxygen2, testthat, visNetwork
#>   enchances linking_to
#> 1      <NA>      cpp11
```

This item includes the following components:

- Package name, version, date, and license
- Package URL(s) (`urls`)
- URL for BugReports (`bugs`)
- Number of contributors with role of *author* (`desc_n_aut`),
  *contributor* (`desc_n_ctb`), *funder* (`desc_n_fnd`), *reviewer*
  (`desc_n_rev`), *thesis advisor* (`ths`), and *translator* (`trl`,
  relating to translation between computer and not spoken languages).
- Comma-separated character entries for all `depends`, `imports`,
  `suggests`, and `linking_to` packages.

The “Date” field is taken from the “Date/Publication” field
automatically inserted by CRAN on package publication, or for non-CRAN
packages to the “mtime” value (modification time) value of the
DESCRIPTION file. Note that “date” values extracted by `pkgstats` do not
use “Date” values from DESCRIPTION files (as these are manually-entered,
and potentially unreliable).

### 1.3 `"objects"`: Objects in all languages

The `objects` item contains all code objects identified by the
code-tagging library [`ctags`](https://ctags.io). For R, those are
primarily functions, but for other languages may be a variety of
entities such as class or structure definitions, or sub-members thereof.
Object tables look like this:

``` r
head (s$objects)
#>           file_name                   fn_name     kind language loc npars
#> 1 R/archive-trawl.R     pkgstats_from_archive function        R  89     9
#> 2 R/archive-trawl.R        list_archive_files function        R  17     2
#> 3 R/archive-trawl.R             rm_prev_files function        R  24     2
#> 4 R/archive-trawl.R pkgstats_fns_from_archive function        R  82     7
#> 5         R/cpp11.R                   cpp_loc function        R   3     4
#> 6 R/ctags-install.R                clone_ctag function        R  17     1
#>   has_dots exported param_nchards_md param_nchards_mn num_doclines
#> 1    FALSE     TRUE              133         159.7778           77
#> 2    FALSE    FALSE               NA               NA           NA
#> 3    FALSE    FALSE               NA               NA           NA
#> 4    FALSE     TRUE              163         174.5714           50
#> 5    FALSE    FALSE               NA               NA           NA
#> 6    FALSE    FALSE               NA               NA           NA
```

Objects are primarily sorted by language, with R-language objects given
first. These are mostly functions, and include statistics on:

- lines of code used to define each function (`loc`);
- numbers of parameters (`npars`);
- whether or not the function includes a “three dots” parameter (that
  is, `...`; identified by `has_dots`);
- whether or not a function is exported (`exported`);
- Mean and median numbers of character used to document each parameter
  (`param_nchards_mn` and `param_nchards_md`, respectively); and
- Total number of lines of documentation for that object / function.

## `"network"`: Relationships between objects

The `network` item details all relationships between objects, which
generally reflects one object calling or otherwise depending on another
object. Each row thus represents one edge of a “function call” network,
with each entry in the `from` and `to` columns representing the network
vertices or nodes.

``` r
head (s$network)
#>                   file line1                    from                        to
#> 1   R/external_calls.R    11   external_call_network      extract_call_content
#> 2   R/external_calls.R    26   external_call_network add_base_recommended_pkgs
#> 3   R/external_calls.R    38   external_call_network   add_other_pkgs_to_calls
#> 4   R/external_calls.R   326 add_other_pkgs_to_calls             control_parse
#> 5 R/pkgstats-summary.R    39        pkgstats_summary                null_stats
#> 6 R/pkgstats-summary.R    50        pkgstats_summary               loc_summary
#>   language cluster_dir centrality_dir cluster_undir centrality_undir
#> 1        R           1              9             1         230.8333
#> 2        R           1              9             1         230.8333
#> 3        R           1              9             1         230.8333
#> 4        R           1              1             1           6.0000
#> 5        R           1             11             1         874.0000
#> 6        R           1             11             1         874.0000
nrow (s$network)
#> [1] 142
```

The network table includes additional statistics on the centrality of
each edge, measured as betweenness centrality assuming edges to be both
directed (`centrality_dir`) and undirected (`centrality_undir`). More
central edges reflect connections between objects that are more central
to package functionality, and vice versa. The distinct components of the
network are also represented by discrete cluster numbers, calculated
both for directed and undirected versions of the network. Each distinct
cluster number represents a distinct group of objects, internally
related to other members of the same cluster, yet independent of all
objects with different cluster numbers.

The network can be viewed as an interactive
[`vis.js`](https://visjs.org/) network through passing the result of
`pkgstats` – the variable `p` in the code above – to the
[`plot_network()`
function](https://docs.ropensci.org/pkgstats/reference/plot_network.html).

## `"external_calls"`: All calls made to all R functions

The `external_calls` item is structured similar to the `network` object,
but identifies all calls to functions from external packages. However,
unlike the `network` and `object` data, which provide information on
objects and relationships in all computer languages used within a
package, the `external_calls` object maps calls within R code only, in
order to provide insight into the use within a package of of functions
from other packages, including R’s base and recommended packages. The
object looks like this:

``` r
head (s$external_calls)
#>   tags_line      call        tag           file     kind start end package
#> 1         1         c GTAGSLABEL R/ctags-test.R nameattr   109 109    base
#> 2         2 character  file_name   R/pkgstats.R nameattr   185 185    base
#> 3         3 character    fn_name   R/pkgstats.R nameattr   186 186    base
#> 4         4   logical   has_dots   R/pkgstats.R nameattr   189 189    base
#> 5         5   integer        loc   R/pkgstats.R nameattr   187 187    base
#> 6         6 left_join       name       R/plot.R nameattr    89  89   dplyr
```

These data are converted to a summary form by the [`pkgstats_summary()`
function](https://docs.ropensci.org/pkgstats/reference/pkgstats_summary.html),
which tabulates numbers of external calls and unique functions from each
package. These data are presented as a single character string which
looks like this:

``` r
s_summ <- pkgstats_summary (s)
print (s_summ$external_calls)
```

These data can be easily converted to the corresponding numeric values
using code like the following:

``` r
x <- strsplit (s_summ$external_calls, ",") [[1]]
x <- do.call (rbind, strsplit (x, ":"))
x <- data.frame (
    pkg = x [, 1],
    n_total = as.integer (x [, 2]),
    n_unique = as.integer (x [, 3])
)
x$n_total_rel <- round (x$n_total / sum (x$n_total), 3)
x$n_unique_rel <- round (x$n_unique / sum (x$n_unique), 3)
print (x)
#>           pkg n_total n_unique n_total_rel n_unique_rel
#> 1        base     581       84       0.704        0.426
#> 2        brio      11        2       0.013        0.010
#> 3        curl       4        3       0.005        0.015
#> 4       dplyr       7        4       0.008        0.020
#> 5          fs       4        2       0.005        0.010
#> 6    graphics      10        2       0.012        0.010
#> 7         hms       2        1       0.002        0.005
#> 8      igraph       3        3       0.004        0.015
#> 9    parallel       2        1       0.002        0.005
#> 10   pkgstats     126       73       0.153        0.371
#> 11      readr       8        5       0.010        0.025
#> 12      stats      19        3       0.023        0.015
#> 13        sys      14        1       0.017        0.005
#> 14      tools       3        2       0.004        0.010
#> 15      utils      22        7       0.027        0.036
#> 16 visNetwork       3        2       0.004        0.010
#> 17      withr       6        2       0.007        0.010
```

Those data reveal, for example, that this package makes 581 individual
calls to 84 unique functions from the “base” package.
