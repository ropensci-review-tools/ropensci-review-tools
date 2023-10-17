
# roreviewapi

This package contains the external service which the `ropensci-review-bot`
calls to run package checks. The service itself is a
[Plumber](https://rplumber.io) API hosted on an external Digital Ocean server
which primarily calls [the `pkgcheck()` function of the `pkgcheck`
package](/pkgcheck/pkgcheck). The `roreviewapi` package implements
post-processing routines to format the checks and deliver the results into
GitHub issues. The endpoint functions are all defined in
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
like this, reformatted here for clarity:

```
INFO [2021-12-01 09:26:26] 
  <sending-ip-address> "Faraday v1.8.0"
  <host-ip-address>:8000
  GET /editorcheck
    ?bot_name=ropensci-review-bot&
     issue_author=<author>&
     issue_id=<n>1&
     repo=ropensci%2Fsoftware-review&
     repourl=https%3A%2F%2Fgithub.com%2F<org>%2F<repo>&
     sender=ropensci-review-bot
  200
  1.235
```

These logs can be used to examine commands issued by the bot, which always have
the machine information "Faraday". The equivalent logs for the bot can be seen
by logging in to [heroku](https://heroku.com), clicking on "radiant-garden",
then under "More" on the upper right, clicking "Logs".

### The `/stdlogs` endpoint

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

These logs can be very detailed, and should provide sufficient information to
diagnose most internal issues with package checking.

## Manual Debugging

Some errors may arise in which a `log` entry appears to have been correctly
sent, and yet no `stdlogs` are generated. These typically require manual
debugging. The best approach is then to manually run the `roreviewapi` Docker
container on the Digital Ocean server, and step through the code to locate the
source of the problem.

The plumber endpoints themselves should generally be bug-free, with the [main
"editor check"
endpoint](https://github.com/ropensci-review-tools/roreviewapi/blob/main/R/plumber.R)
calling [the `roreviewapi::editor_check()`
function](https://docs.ropensci.org/roreviewapi/reference/editor_check.html).
It may nevertheless be worthwhile calling the two functions prior to that call
(`check_issue_template()` and `stdout_stderr_cache()`). The [`editor_check()`
function](https://github.com/ropensci-review-tools/roreviewapi/blob/main/R/editor-check.R)
should be run after first setting the two operating-system variables defined in
[the main
Dockerfile](https://github.com/ropensci-review-tools/roreviewapi/blob/578f7ce7d6efb3d4b3893b73407835d2af8a2c38/Dockerfile#L25)
of,

``` r
os <- "ubuntu"
os_release <- "20.04"
```

The `editor_check()` function then proceeds through the following main sequence
of calls, starting with checks whether the main `repourl` also specifies a
non-default branch (in the form "github.com/\<org\>/\<repo\>/tree/\<branch\>"):

``` r
branch <- get_branch_from_url (repourl)
if (!is.null (branch)) {
    repourl <- gsub (paste0 ("\\/tree\\/", branch, ".*$"), "", repourl)
}
path <- roreviewapi::dl_gh_repo (u = repourl, branch = branch)
p <- roreviewapi::pkgrep_install_deps (path, os, os_release)
# -> check whether `p` is an error

updates <- roreviewapi::rorevapi_updated_pkgs (path)
if (length (updates) > 0L) {
  utils::update.packages (oldPkgs = updates, ask = FALSE)
}

checks <- pkgcheck::pkgcheck (path)
# -> check whether `checks` is an error; if so, try to reproduce as separate
#    pkgcheck call and file issue there if error is reproducible.

out <- roreviewapi::collate_editor_check (checks)
```

It should be possible to locate the source of most errors somewhere within one
of those calls.
