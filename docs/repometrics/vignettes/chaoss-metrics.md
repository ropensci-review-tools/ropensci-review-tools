# CHAOSS metrics

The `repometrics` package collates many metrics of a nominated
repository, including the metrics defined by the [CHAOSS community
(“Community Health Analytics in Open Source
Software”)](https://chaoss.community/). The metrics implemented by this
package can be seen by first loading the package:

``` r
library (repometrics)
```

And the calling this function:

``` r
rm_metrics_list ()
```

That returns a `data.frame` with two columns, rendered here in
hyperlinked form:

![](chaoss-metrics_files/figure-gfm/DT-metrics-1.png)<!-- -->

As noted in the documentation for [the `rm_metrics_list`
function](https://docs.ropensci.org/repometrics/reference/rm_metrics_list.html):

> Metrics have been adapted in this package, and so may not precisely
> reflect the descriptions provided in the CHAOSS community web pages
> linked to in the URLs from this function. Adaptations have in
> particular been implemented to align metrics with their usage in
> aggregate “models”.

All metrics are collated by calling [the main `repometrics_data()`
function](https://docs.ropensci.org/repometrics/reference/repometrics_data.html).
