# API Endpoints

This vignette provides brief summaries of the endpoints of the
`roreviewapi` package. These are encoded within the identical
[`R/plumber.R`](https://github.com/ropensci-review-tools/roreviewapi/blob/main/R/plumber.R)
and
[`inst/plumber.R`](https://github.com/ropensci-review-tools/roreviewapi/blob/main/inst/plumber.R)
files. All endpoints respond only to `GET` calls.

------------------------------------------------------------------------

## 1. editorcheck

This is the main endpoint called by the `ropensci-review-bot` in
response to package submission. The call itself is configured as part of
an [external service call in
\`ropensci-org/buffy](https://github.com/ropensci-org/buffy/blob/82dd29bae4aeaa6bf5ca77b27be82cacd3a1ba04/config/settings-production.yml#L18-L32),
which passes the parameters specified there of:

1.  `repo` The GitHub repository from where the call originates,
    generally `ropensci/software-review`;
2.  `issue_id` as the number of the issue in `repo` describing the
    software submission; and
3.  `repourl` as specified in the submission template, and specifying
    the GitHub repository of the software being submitted, also in the
    format `<org>/<repo>`.

This endpoint implements the following steps:

1.  Call
    [`roreviewapi::check_issue_template()`](https://docs.ropensci.org/roreviewapi/reference/check_issue_template.html)
    to check the existence and format of HTML variables included within
    the submission template. This function returns an empty string if
    the template is okay; otherwise a descriptive error message. The
    return value also includes a binary attribute,
    `"proceed_with_checks"`, which is set to `FALSE` only if `repourl`
    is improperly specified. In this case the function returns
    immediately with a text string describing the error. Otherwise the
    string is carried through to the next step:
2.  The [`pkgcheck::pkgcheck()`
    function](https://github.com/ropensci-review-tools/pkgcheck) is
    started as a background process, dumping both `stdout` and `stderr`
    messages to specified logfiles (see `stdlogs` endpoint, below).
3.  Any messages generated above are prepended to a return message that
    the package checks have started, that message delivered back to the
    bot, and ultimately dumped in the issue thread.

All messages, and the results of the [`pkgcheck::pkgcheck()`
process](https://github.com/ropensci-review-tools/pkgcheck), are dumped
to the specified `issue_id` in the specified `repo`.

------------------------------------------------------------------------

## 2. editorcheck_contents

The `editorcheck_contents` endpoint implements the main check
functionality of the `editorcheck` endpoint without dumping any results
to the specified issue. It is primarily intended to aid debugging any
issues arising within checks, through the use of the `stdlogs` endpoint
described below. This endpoint accepts the single argument of `repourl`
only.

------------------------------------------------------------------------

## 3. mean

A simple `mean` endpoint can be used to confirm that the server is
running. It accepts a single integer value of `n`, and returns the value
of `mean(rnorm(n))`.

------------------------------------------------------------------------

## 4. stats_badge

This endpoint is used by the bot to extract the stats badge from those
issues which have one, in the form `"6\approved-bronze-v0.0.1"`. This is
used in turn by the bot to respond to `mint` commands used to change
badge grades.

------------------------------------------------------------------------

## 5. log

The `log` endpoint accepts a single parameter, `n`, specifying the
number of latest log entries to retrieve. Each entry contains the
following information:

1.  Date and time at which call was made;
2.  IP address from which call was sent;
3.  Method used to send call;
4.  IP address to which call was delivered (always the address hosting
    the `roreviewapi` instance);
5.  `http` method for the call (always `GET` for all endpoints encoded
    here);
6.  The endpoint called (one of the methods listed above);
7.  The parameters submitted along with the call;
8.  The HTTP status of the call (hopefully 200); and
9.  The total duration of the call response.

The 7th item of parameters submitted along with the call is particularly
useful for debugging purposes; and is specified in [this line of the
`R/api.R`
file](https://github.com/ropensci-review-tools/roreviewapi/blob/e912885f516198efac885f9923318467c304df5a/R/api.R#L86).

------------------------------------------------------------------------

## 6. clear_cache

This endpoint can be used to clear the server’s cache whenever desired
or required. This cache is mainly used to store the results of calls to
[`pkgcheck::pkgcheck()`](https://github.com/ropensci-review-tools/pkgcheck).
The only effect of clearing the cache will be extra time taken to
regenerate any calls which were previously cached.

------------------------------------------------------------------------

## 7. stdlogs

This is the most important endpoint for debugging problems within the
[`pkgcheck`](https://github.com/ropensci-review-tools/pkgcheck) process
itself. The endpoint accepts the single parameter of `repourl`, and will
return the results of both `stdout` and `stderr` connections produced
during [`pkgcheck`](https://github.com/ropensci-review-tools/pkgcheck).
These checks are hashed with the latest git head, ensuring that the
endpoint returns checks for the latest commit.
