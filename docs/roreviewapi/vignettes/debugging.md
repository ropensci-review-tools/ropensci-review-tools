The main API endpoint for the Digital Ocean server is the
[`editorcheck`](https://docs.ropensci.org/roreviewapi/articles/endpoints.html#editorcheck),
called by the `ropensci-review-bot` on every submission, and also
manually (re-)triggered by the command
`@ropensci-review-bot check package`. This vignette describes procedures
which may be used to debug any instances in which package checks fail.

Most failures at the server end will deliver HTTP error codes of “500”
[like this
example](https://github.com/ropensci/software-review/issues/463#issuecomment-920941332).
This code *may* indicate that the server is currently unavailable, which
will arise once per week during rebuild and redeploy processes,
scheduled every Monday at 23:59 UTC. If a submission happens to be
roughly at this time, the recommended procedure is to wait at least an
hour before manually trying `@ropensci-review-bot check package`. Other
500 codes should be reported straight to maintainers of the check
system, currently to [@mpadge](https://github.com/mpadge) and
[@noamross](https://github.com/noamross) as respective first and second
points of contact. This vignette describes the procedures they would
follow to debug any problems.

Debugging generally requires stepping through the code as called by the
main [`editorcheck`
endpoint](https://github.com/ropensci-review-tools/roreviewapi/blob/main/R/plumber.R),
and into the [`editor_check()`
function](https://github.com/ropensci-review-tools/roreviewapi/blob/main/R/editor-check.R)
called by the endpoint as a background process.

# Debugging Procedure

## Check that the API is online

The following code will confirm that the API is online, by returning a
single numeric value:

``` r
httr::GET ("http://<ip-address>:8000/mean") |>
    httr::content ()
```

## Check log of recent requests

The log entries are illustrated in the [endpoints
vignette](https://docs.ropensci.org/roreviewapi/articles/endpoints.html#5-log),
and can be used to ensure that all variables were successfully delivered
in the request. Any missing or malformed variables most likely indicate
problems with the submission template. These should be caught by the
initial call make by the [`editorcheck` function to the
`check_issue_template()`
function](https://github.com/ropensci-review-tools/roreviewapi/blob/82c9724a712094e4ccabb3974cb952f68ad5180f/R/plumber.R#L23).
Potential issues can be debugged by calling that function locally:

``` r
roreviewapi::check_issue_template (orgrepo = "ropensci/software-review",
                                   issue_num = <issue_num>)
```

That should return an empty string with an additional attribute,
`"proceed_with_checks"`, which should be `TRUE`. Any other return value
indicates an issue with the submission template, for which the return
value should contain text describing the problem.

## Check installation of system dependencies

This and the following checks are components of the [`editor_check()`
function](https://github.com/ropensci-review-tools/roreviewapi/blob/main/R/editor-check.R)
called by the main endpoint as a background process, the first step of
which is to identify and install system dependencies. This step is error
prone, as is also the case on all CRAN machines. A final step of the
check is to identify any packages which were unable to be installed, and
to post a list of these directly in the submission issue. Such instances
should generally be temporary, and fixed by forthcoming CRAN updates.
These happen because of temporary breakages in one package which lead to
other packages becoming unable to be installed from CRAN, with these
temporary breakages in turn generally arising because of changes to
external (non-R) system libraries. If any notified inabilities to
install packages adversely affect final check results, debugging may
require manually running checks on the Digital Ocean server, as
described in the final section below.

## Check system output and error logs

The system output and error logs from checks for a specified package are
accessible from [the `stdlogs`
endpoint](https://docs.ropensci.org/roreviewapi/articles/endpoints.html#7-stdlogs),
which requires the single parameter of the `repourl` of the repository
being checked. Logs are kept for the latest git head, and are accessible
if and only if the latest GitHub commit matches the points at which the
logs were generated. In those cases, the return value may offer useful
diagnostic insights into potential problems either with submitted
packages, or the check system itself.

# Manually running checks

If all else fails, checks can be manually run directly from the Digital
Ocean server, and sent straight to the relevant issue. The following
procedure describe how, generally following the main [`editor_check()`
function](https://github.com/ropensci-review-tools/roreviewapi/blob/main/R/editor-check.R).

1.  Enter the `roreviewapi` Docker image via
    `docker run -it --rm roreviewapi /bin/bash` and start R.
2.  Set `repourl <- <url>` and run
    `path <- roreviewapi::dl_gh_repo (repourl)` to download a clone of
    the repository.
3.  Type `os <- "ubuntu"` and `os_release <- "20.04"`.
4.  Run `p <- roreviewapi::pkgrep_install_deps (path, os, os_release)`.
    The value, `p`, will list any packages which were unable to be
    installed. These will then need to be manually installed, generally
    through finding the remote/dev URLs for the packages, and running
    `remotes::install_github()` or similar. Note that successful
    installation may only be possible in a particular order, and in the
    worst cases may be a process of trial and error.
5.  Finally generate the main checks by running
    `checks <- pkgcheck::pkgcheck(path)`, during which diagnostic output
    will be dumped directly to the screen.
6.  Convert checks to markdown format by running
    `out <- roreviewapi::collate_editor_check (checks)`.
7.  Finally, post the checks to the desired issue with
    `out <- roreviewapi::post_to_issue (out, orgrepo, issue_num)`.
    Alternative values for `orgrepo` and `issue_num` can be used to
    first confirm that the checks look okay before posting them to
    `ropensci/software-review`.
