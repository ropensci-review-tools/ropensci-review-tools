# Get current vacation status of all rOpenSci editors.

## Description

Data are obtained both from airtable and current slack status. If either of
these indicate that an editor is away, on vacation, or otherwise unavailable,
then the `away` column will be set to `TRUE`.

## Usage

```r
editor_vacation_status(airtable_id)
```

## Arguments

* `airtable_id`: The 'id' string of the airtable table.

## Value

A `data.frame` with one row per editor and information on current
vacation status.


