# Handle a volunteer link click

## Description

Looks up the token, checks whether the parent search is still active, guards
against double-clicks, records the click timestamp, and triggers a Gmail
API notification (Phase 2).

## Usage

```r
handle_click(token, sender = NULL)
```

## Arguments

* `token`: 64-character hex token from the recipient's unique link.
* `sender`: Function used to send the click notification; injectable for
testing.  Must accept `(to, subject, html_body)`.  Defaults to
`gmail_send`.

## Seealso

Other email:
`[deactivate_search()](deactivate_search)`,
`[deactivate_stale_searches()](deactivate_stale_searches)`,
`[list_searches()](list_searches)`,
`[send_search()](send_search)`

## Concept

email

## Value

Named list with `status` (integer HTTP status code) and
`body` (character HTML string).


