
# Debugging

The [`roreviewapi` package](/roreviewapi/roreviewapi) includes code for the
external service which the `ropensci-review-bot` calls to run package checks.
The service itself is a [Plumber](https://rplumber.io) API hosted on an
external Digital Ocean server which primarily calls [the `pkgcheck()` function
of the `pkgcheck` package](/pkgcheck/pkgcheck). The `roreviewapi` package
implements post-processing routines to format the checks and deliver the
results into GitHub issues. The endpoint functions are all defined in
[`R/plumber.R`](https://github.com/ropensci-review-tools/roreviewapi/blob/main/R/plumber.R),
which is mirrored in `inst/plumber.R`.

The endpoint includes two main debugging endpoints:

- `/log` to extract the log of submitted queries; and
- `/stdlogs` to extract `stdout` and `stderr` logs from a particular query.

## The `/log` endpoint

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

## The `/stdlogs` endpoint

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
source of the problem. The general procedure for this is described in [the
"Debugging" vignette of the `roreviewapi`
package](https://ropensci-review-tools.readthedocs.io/en/latest/roreviewapi/vignettes/debugging.html#manually-running-checks).

The Digital Ocean droplet can be accessed via the Digital Ocean web interface,
or via SSH. The latter requires a public SSH key to be registered in the
droplet. Once in the droplet, the following lines will enter an R session
within the Docker container:

``` bash
docker run -it --rm roreviewapi /bin/bash
R
```

The ["Debugging"
vignette"](https://ropensci-review-tools.readthedocs.io/en/latest/roreviewapi/vignettes/debugging.html#manually-running-checks)
then includes the following code chunk which can be stepped through to identify
sources of any bugs:

``` r
repourl <- "https://github.com/org/repo" # replace with actual org/repo values
path <- roreviewapi::dl_gh_repo (repourl)
os <- "ubuntu"
os_release <- "20.04"
p <- roreviewapi::pkgrep_install_deps (path, os, os_release)
checks <- pkgcheck::pkgcheck(path)
out <- roreviewapi::collate_editor_check (checks)
orgrepo <- "ropensci/software-review" # or somewhere else for testing purposes
out <- roreviewapi::post_to_issue (out, orgrepo, issue_num)
```


These lines represent the main function calls within the ["editor check"
endpoint](https://github.com/ropensci-review-tools/roreviewapi/blob/main/R/plumber.R)
in the plumber function, which in turns calls [the
`roreviewapi::editor_check()`
function](https://docs.ropensci.org/roreviewapi/reference/editor_check.html).
The plumber endpoints themselves should generally be bug-free, although it may
be worthwhile calling the two functions prior to that call
(`check_issue_template()` and `stdout_stderr_cache()`).

See the actual code of [the `roreviewapi::editor_check()`
function](https://docs.ropensci.org/roreviewapi/reference/editor_check.html)
for further details, including code to handle non-default git branches. It
should be possible to locate the source of most errors somewhere within one of
those calls.
