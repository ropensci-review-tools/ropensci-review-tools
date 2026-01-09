# Plot interactive

## Description

Plot interactive `visNetwork` visualisation of object-relationship
network of package.

## Usage

```r
plot_network(s, plot = TRUE, vis_save = NULL)
```

## Arguments

* `s`: Package statistics obtained from [pkgstats](pkgstats) function.
* `plot`: If `TRUE`, plot the network using `visNetwork` which opens an
interactive browser pane.
* `vis_save`: Name of local file in which to save `html` file of network
visualisation (will override `plot` to `FALSE`).

## Note

Edge thicknesses are scaled to centrality within the package function
call network. Node sizes are scaled to numbers of times each function is
called from all other functions within a package.

## Concept

output

## Value

(Invisibly) A `visNetwork` representation of the package network.

## Examples

```r
f <- system.file ("extdata", "pkgstats_9.9.tar.gz", package = "pkgstats")

p <- pkgstats (f)
plot_network (p)
```


