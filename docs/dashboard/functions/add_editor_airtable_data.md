# Add additional columns to 'editors' data from rOpenSci's airtable database,

## Description

Add additional columns to 'editors' data from rOpenSci's airtable database,
and remove any "emeritus" editors.

## Usage

```r
add_editor_airtable_data(editors, airtable_id)
```

## Arguments

* `editors`: The `data.frame` of editors returned as the "status" component
from [editor_status](editor_status).
* `airtable_id`: The 'id' string of the airtable table.

## Value

A modified version of `editors` with additional columns.


