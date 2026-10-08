# Data for community leaderboard

## Description

This is only slightly modified from [review_history](review_history), through adding
additional Airtable data to identify current editorial team.

## Usage

```r
community_data(airtable_id, quiet = FALSE)
```

## Arguments

* `airtable_id`: ID of Airtable base
* `quiet`: If `FALSE`, display progress information on screen.

## Value

A named list with one element for each community member and integer
values for total number of packages submitted; total number of reviews
conducted; and an additional logical flag indicating whether or not that
person is or was a member of the editorial team. These data are returned as
a raw list, because they are processed directly in Javascript.


