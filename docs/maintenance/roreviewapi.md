
# roreviewapi

The `roreviewapi` package encodes the [Plumber](https://rplumber.io) API that
delivers the bot responses. The endpoint functions are all defined in
[`R/plumber.R`](https://github.com/ropensci-review-tools/roreviewapi/blob/main/R/plumber.R),
which is mirrored in `inst/plumber.R`.

## Debugging

The endpoint includes two main debugging endpoints:

- `/log` to extract the log of submitted queries; and
- `/stdlogs` to extract `stdout` and `stderr` logs from a particular query.

### The `/log` endpoint

The `/log` endpoint can be used to examine or debug calls directly issued by
`ropensci-review-bot`. This endpoint is a `GET` method with a single parameter,
`n`, specifying the number of most recent entries to return, with a default of
10. Example output from a request issued by the `ropensci-review-bot` looks
like this:

```
INFO [2021-12-01 09:26:26] <sending-ip-address> "Faraday v1.8.0" <host-ip-address>:8000 GET /editorcheck ?bot_name=ropensci-review-bot&issue_author=<author>&issue_id=<n>1&repo=ropensci%2Fsoftware-review&repourl=https%3A%2F%2Fgithub.com%2F<org>%2F<repo>&sender=ropensci-review-bot 200 1.235
```

These logs can be used to examine commands issued by the bot, which always have
the machine information "Faraday". The equivalent logs for the bot can be seen
by logging in to [heroku](https://heroku.com), clicking on "radiant-garden",
then under "More" on the upper right, clicking "Logs".

### The `\stdlogs` endpoint

The `check package` command issued either manually or automatically on all new
submissions returns immediately with a message, while starting a background
process for the actual package checks. The `\stdlogs` endpoint is intended to
help diagnose issues with this background checking process. The functions are
all controlled by [the `roreviewapi`
package](https://github.com/ropensci-review-tools/roreviewapi), which is in
turn a plumber API providing access to [the functionality of the `pkgcheck`
package](https://github.com/ropensci-review-tools/pkgcheck).

This background process dumps all `stdout` and `stderr` messages to a cached
log, the contents of which can be accessed with the `\stdlogs` endpoint. This
is a `GET` endpoint with the single parameter of `repourl` specifying the URL
of the package being checked. Logs are cached only for the most recent calls
for any one package.

