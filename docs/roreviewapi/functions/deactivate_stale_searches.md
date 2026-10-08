# Auto-deactivate and delete stale volunteer searches

## Description

Searches are never automatically closed otherwise, so this is intended to
be called periodically (see `serve_api()`) to stop searches that are
never explicitly deactivated from accumulating in the database forever.
Any search whose `created_at` is older than `max_age_days` is
deactivated and has all its data removed, exactly as `deactivate_search()`does for a single search.

## Usage

```r
deactivate_stale_searches(max_age_days = 100L)
```

## Arguments

* `max_age_days`: Default: 100. Integer number of days after creation at
which a search is considered stale and is automatically deactivated.

## Seealso

Other email:
`[deactivate_search()](deactivate_search)`,
`[handle_click()](handle_click)`,
`[list_searches()](list_searches)`,
`[send_search()](send_search)`

## Concept

email

## Value

Integer count of searches deactivated, invisibly.


