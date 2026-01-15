# Start quarto dashboard with results of

## Description

Start quarto dashboard with results of
`orgmetrics_collate_org_data` function for collation of data across orgs.

## Usage

```r
orgmetrics_dashboard(
  data_org,
  fn_calls,
  embeddings,
  title = NULL,
  action = "preview"
)
```

## Arguments

* `data_org`: Data on GitHub organization as returned from
`orgmetrics_collate_org_data` function.
* `fn_calls`: Data on function calls between packages of the specified
organization, as returned from the `rm_org_data_fn_call_network()` function.
* `embeddings`: List of language model embeddings returned from
`rm_org_emb_distances()`. These are calculated with the 'pkgmatch' package
which in turn relies on [https://ollama.com](https://ollama.com).
* `title`: If not `NULL` (default), a string specifying the organizational
title for the dashboard.
* `action`: One of "preview", to start and open a live preview of the
dashboard website, "render" to render a static version without previewing
or opening, or `NULL` to set up the quarto structure in the current
temporary directory without doing anything. This option is useful to
generate the dashboard structure so that it can be moved to a non-temporary
location, and deployed or previewed from there.

## Value

(Invisibly) Path to main "index.html" document of quarto site. Note
that the site must be served with `action = "preview"`, and will not work by
simply opening this "index.html" file.


