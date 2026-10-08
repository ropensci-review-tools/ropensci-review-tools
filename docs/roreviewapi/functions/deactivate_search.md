# Deactivate a volunteer search and delete all associated data

## Description

Deactivate a volunteer search and delete all associated data

## Usage

```r
deactivate_search(repo, issue_id)
```

## Arguments

* `repo`: GitHub review repository in `org/repo` format.
* `issue_id`: Integer issue number in the review repository.

## Seealso

Other email:
`[deactivate_stale_searches()](deactivate_stale_searches)`,
`[handle_click()](handle_click)`,
`[list_searches()](list_searches)`,
`[send_search()](send_search)`

## Concept

email

## Value

Named list with `deactivated` (logical) and `issue_ref`.


