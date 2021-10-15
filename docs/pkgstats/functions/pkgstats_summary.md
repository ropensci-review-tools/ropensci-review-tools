# `pkgstats_summary`

Condense the output of `pkgstats` to summary statistics only


## Description

Condense the output of `pkgstats` to summary statistics only


## Usage

```r
pkgstats_summary(s = NULL)
```


## Arguments

Argument      |Description
------------- |----------------
`s`     |     Output of [pkgstats](#pkgstats) , containing full statistical data on one package. Default of `NULL` returns a single row with `NA` values (used in [pkgstats_from_archive](#pkgstatsfromarchive) ).


## Value

Summarised version of `s` , as a single row of a standardised
 `data.frame` object


## Seealso

Other stats:
 [`desc_stats`](#descstats) ,
 [`loc_stats`](#locstats) ,
 [`pkgstats`](#pkgstats) ,
 [`rd_stats`](#rdstats)


