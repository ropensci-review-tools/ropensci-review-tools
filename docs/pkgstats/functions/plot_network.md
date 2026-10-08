# Plot interactive visualisation of object-relationship network of package.

## Description

Plot interactive visualisation of object-relationship network of package.

## Usage

```r
plot_network(s, plot = TRUE, vis_save = NULL)
```

## Arguments

* `s`: Package statistics obtained from [pkgstats](pkgstats) function.
* `plot`: If `TRUE`, plot the network which opens an interactive browser
pane.
* `vis_save`: Name of local file in which to save `html` file of network
visualisation (will override `plot` to `FALSE`).

## Note

Edge thicknesses are scaled to centrality within the package function
call network. Node sizes are scaled to numbers of times each function is
called from all other functions within a package. The visualisation is
rendered with a small bundle of `D3`-based JavaScript shipped with
this package (see `system.file ("js", package = "pkgstats")`), so no
internet connection or additional R packages are required to view it.

## Concept

output

## Value

(Invisibly) A `pkgstats_network` object: a list of the `nodes` and
`edges` used to construct the network, along with the self-contained
`html` document itself.

## Examples

```r
f <- system.file ("extdata", "pkgstats_9.9.tar.gz", package = "pkgstats")

p <- pkgstats (f)
net <- plot_network (p, plot = FALSE)

# use default 'plot = TRUE' to automatically open network in browser.
```


