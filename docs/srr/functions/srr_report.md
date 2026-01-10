# Generate report from

## Description

Generate report from `ssr` tags.

## Usage

```r
srr_report(path = ".", branch = "", view = TRUE, roxygenise = TRUE)
```

## Arguments

* `path`: Path to package for which report is to be generated
* `branch`: By default a report will be generated from the current branch
as set on the local git repository; this parameter can be used to specify any
alternative branch.
* `view`: If `TRUE` (default), a html-formatted version of the report is
opened in default system browser. If `FALSE`, the return object includes the
name of a `html`-rendered version of the report in an attribute named 'file'.
* `roxygenise`: If `TRUE` (default), documentation will first be updated
with the `roxygen2` package. This requires local installation of the
package, which may take some time if the package has not previously been
installed. If this parameter is `FALSE`, the `roxygen2` package is not used,
documentation is not updated, and reports are generally generated faster.

## Concept

report

## Value

(invisibly) Markdown-formatted lines used to generate the final html
document.

## Examples

```r
path <- srr_stats_pkg_skeleton ()
srr_report (path)
```


