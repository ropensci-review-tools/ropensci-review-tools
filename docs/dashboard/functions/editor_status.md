# Generate summary data of current and historical activities of all rOpenSci

## Description

Generate summary data of current and historical activities of all rOpenSci
editors

## Usage

```r
editor_status(quiet = FALSE, aggregation_period = "quarter")
```

## Arguments

* `quiet`: If `FALSE`, display progress information on screen.
* `aggregation_period`: The time period for aggregation of timeline for
editorial loads. Must be one of "month", "quarter", or "semester".

## Value

A list of four items:

* 'status', a `data.frame` of current editor status, with one row per
editor and some key statistics.
* 'timeline_total', a `data.frame` representing the timelines for each
editor of total concurrent editorial load.
* 'timeline_new', a `data.frame` representing the timelines for each
editor of editorial load of new issues opened in each time period (default of
quarter-year.
* 'reviews', a `data.frame` with one row per issue and some key
statistics.


