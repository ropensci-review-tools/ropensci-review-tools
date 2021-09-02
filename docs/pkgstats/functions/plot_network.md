# `plot_network`

Plot interactive visNetwork visualisation of object-relationship
 network of package.


## Description

Plot interactive visNetwork visualisation of object-relationship
 network of package.


## Usage

```r
plot_network(s, plot = TRUE, vis_save = NULL)
```


## Arguments

Argument      |Description
------------- |----------------
`s`     |     Package statistics obtained from [pkgstats](#pkgstats) function.
`plot`     |     If `TRUE` , plot the network using visNetwork which opens an interactive browser pane.
`vis_save`     |     Name of local file in which to save `html` file of network visualisation (will override `plot` to `FALSE` ).


## Value

(Invisibly) A visNetwork representation of the package network.


