# `review_status`

Generate a summary report for incoming Editor-in-Charge of current state of
 all open software-review issues.


## Description

Generate a summary report for incoming Editor-in-Charge of current state of
 all open software-review issues.


## Usage

```r
review_status(open_only = TRUE, browse = TRUE, quiet = FALSE)
```


## Arguments

Argument      |Description
------------- |----------------
`open_only`     |     If `TRUE` (default), only extract information for currently open issues.
`browse`     |     If `TRUE` (default), open the results as a DT `datatable` HTML page in default browser.
`quiet`     |     If `FALSE`, display progress information on screen.


## Value

A `data.frame` with one row per issue and some key statistics.


