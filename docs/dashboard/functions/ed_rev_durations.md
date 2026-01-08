# Extract average duration of reviews for each editor

## Description

Note that is extracts data for all editors, including those who may not be
part of current editorial team. Current team members can be identified from
data returned from the [editor_status](editor_status) function.

## Usage

```r
ed_rev_durations(nyears = 2)
```

## Arguments

* `nyears`: Length of time prior to current date over which average
durations should be calculated.

## Value

A `data.frame` with two columns of 'editor' and 'duration' in days.


