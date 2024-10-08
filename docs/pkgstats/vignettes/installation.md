# Installation

The `pkgstats` package [is on
CRAN](https://cran.r-project.org/package=pkgstats), so can be installed
directly with,

``` r
install.packages ("pkgstats")
```

The latest development version can be installed [via the associated
`r-universe`](https://ropensci-review-tools.r-universe.dev/pkgstats). As
shown there, simply enable the universe with

``` r
options (repos = c (
    ropenscireviewtools = "https://ropensci-review-tools.r-universe.dev",
    CRAN = "https://cloud.r-project.org"
))
```

And then call `install.packages()` the same way. Alternatively, the
development version of the package can be installed by running one of
the following lines:

``` r
remotes::install_github ("ropensci-review-tools/pkgstats")
pak::pkg_install ("ropensci-review-tools/pkgstats")
```

The package can then loaded for use with:

``` r
library (pkgstats)
```

## Installation on Linux systems

This package requires the [system libraries
`ctags-universal`](https://ctags.io) and [GNU
`global`](https://www.gnu.org/software/global/), both of which are
automatically installed along with the package on both Windows and MacOS
systems. Most Linux distributions do not include a sufficiently
up-to-date version of [`ctags-universal`](https://ctags.io), and so it
must be compiled from source. This can be done by running a single
function, `ctags_install()`, which will install both
[`ctags-universal`](https://ctags.io) and [GNU
`global`](https://www.gnu.org/software/global/).

The `pkgstats` package includes a function to ensure your local
installations of `universal-ctags` and `global` work correctly. Please
ensure you see the following prior to proceeding:

``` r
ctags_test ()
#> [1] TRUE
```

Note that GNU `global` can be linked at installation to the Universal
Ctags plug-in parser to expand the [default 5 languages to
30](https://www.gnu.org/software/global/). This makes no difference to
`pkgstats` results, as `gtags` output is only used to trace function
call networks, which is only possible for compiled languages able to
dynamically share pointers to the same objects. This is possible with
the default parser regardless. The wealth of extra information obtained
from linking `global` to the Universal Ctags parser is ultimately
discarded anyway, yet parsing may take considerably longer. If this is
the case, “default” behaviour may be recovered by first running the
following command:

``` r
Sys.unsetenv (c ("GTAGSCONF", "GTAGSLABEL"))
```

See [information on how to install the
plugin](https://cvs.savannah.gnu.org/viewvc/global/global/plugin-factory/PLUGIN_HOWTO.pygments?revision=1.6&view=markup)
for more details.
