# `loc_stats`

Internal calculation of Lines-of-Code Statistics


## Description

Internal calculation of Lines-of-Code Statistics


## Usage

```r
loc_stats(path)
```


## Arguments

Argument      |Description
------------- |----------------
`path`     |     Directory to package being analysed


## Value

A list of statistics for each of three directories, 'R', 'src', and
 'inst/include', each one having 5 statistics of total numbers of lines,
 numbers of empty lines, total numbers of white spaces, total numbers of
 characters, and indentation used in files in that directory.


## Note

NA values are returned for directories which do not exist.


