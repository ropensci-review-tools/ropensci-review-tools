# `review_history`

Generate historical data on software reviews.


## Description

This is a reduced version of the `reviews_gh_data()` function, which returns
 data only on dates of issue opening and closing, to be used to generate
 historical patterns.


## Usage

```r
review_history(quiet = FALSE)
```


## Arguments

Argument      |Description
------------- |----------------
`quiet`     |     If `FALSE`, display progress information on screen.


## Value

(Invisibly) A `data.frame` with one row per issue and some key
 statistics.


