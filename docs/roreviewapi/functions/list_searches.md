# List all volunteer searches with recipient and click counts

## Description

List all volunteer searches with recipient and click counts

## Usage

```r
list_searches()
```

## Seealso

Other email:
`[deactivate_search()](deactivate_search)`,
`[deactivate_stale_searches()](deactivate_stale_searches)`,
`[handle_click()](handle_click)`,
`[send_search()](send_search)`

## Concept

email

## Value

Data frame with columns `search_id`, `created_at`,
`notify_email`, `active`, `total`, `clicked`.


