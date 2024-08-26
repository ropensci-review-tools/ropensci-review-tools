# Debugging

This section describes procedures which may be used to debug `ropensci-review-bot` problems.
The most common problem is a failure of the bot to respond.
This section describes how to diagnose and resolve that problem, with solutions to other problems also generally found by following similar procedures. 

## The Heroku service

The bot itself is hosted on Heroku, which is the first point of diagnosis.
The logs for the bot will reveal whether commands were successfully received.
These logs can be viewed by 

- logging in to [heroku](https://heroku.com), clicking on "radiant-garden", then under "More" on the upper right, clicking ["Logs"](https://devcenter.heroku.com/articles/logging#view-logs-with-the-heroku-dashboard). This will allow you to see the current log, from the moment you open it. You can open the log this way, launch a command from a GitHub software-review issue and see it appear in the log.

- using the [Heroku CLI](https://devcenter.heroku.com/articles/heroku-cli) on your machine: [logging in](https://devcenter.heroku.com/articles/heroku-cli#get-started-with-the-heroku-cli) and then running [`heroku logs`](https://devcenter.heroku.com/articles/logging#view-logs-with-the-heroku-cli).

:::{admonition} Debug Step 1
:class: tip
Ensure that the bot request was received by Heroku.
:::


If a failed command was logged by Heroku and passed on to our service, then the problem will have arisen within the `roreviewapi` instance hosted on Digital Ocean.

## The Digital Ocean Service

The Digital Ocean droplet can be accessed via the Digital Ocean web interface, or via SSH.
The latter requires a public SSH key to be registered in the droplet.
The [`roreviewapi` package](/roreviewapi/roreviewapi) defines the functions called by the `ropensci-review-bot`, run within the Digital Ocean droplet as a [Plumber](https://rplumber.io) API.

Once in the SSH shell, you'll need to also enter in to the docker container hosting the currently running `roreviewapi` process.
This command lists all current docker processes:

``` bash
docker ps -a
```

There should be only a single processes with a "STATUS" field of "Up".
To enter that container, copy the "CONTAINER ID" and type,

``` bash
docker exec -it <container-id> /bin/bash
```

All files are held in the `/home/` directory (and not in `~`), with all cached files from the bot services within the `.cache` sub-directory.
The container includes tab autocompletion, so debugging generally begins by auto-filling this command:

``` bash
cd /home/.cache/R/pkgcheck/
```

That directory should contain a clone of the repository being reviewed in the issue of interest, so the next debug step is:

:::{admonition} Debug Step 2
:class: tip
Ensure that repository has been cloned and directory exists in
`/home/.cache/R/pkgcheck/` directory.
:::

If the repository has been successfully cloned, then you'll need to dig deeper within the code to debug further.
The plumber endpoint functions called by the bot are defined in [`R/plumber.R`](https://github.com/ropensci-review-tools/roreviewapi/blob/main/R/plumber.R), which is mirrored in `inst/plumber.R`.
The endpoint includes two main debugging endpoints:

- `/log` to extract the log of submitted queries; and
- `/stdlogs` to extract `stdout` and `stderr` logs from a particular query.

## The `/log` endpoint

The `/log` endpoint records all calls received by the `roreviewapi` service.
This endpoint is a `GET` method with a single parameter, `n`, specifying the number of most recent entries to return, with a default of 10.
Example output from a request issued by the `ropensci-review-bot` looks like this, reformatted here for clarity:

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

These logs can be used to examine commands issued by the bot and passed on by the Heroku service, which always have the machine information "Faraday".

:::{admonition} Debug Step 3
:class: tip
Ensure that the command was received and logged by the `roreviewapi` service.
:::


## The `/stdlogs` endpoint

Most commands, including `check package` and `check srr`, issued either manually or automatically on all new submissions return immediately with a message, while starting a background process for the actual package checks.
The `\stdlogs` endpoint is intended to help diagnose issues with this background checking process.

This background process dumps all `stdout` and `stderr` messages to cached log files.
The contents of these can be accessed either as HTTP requests to the running process.
This is a `GET` endpoint with the single parameter of `repourl` specifying the URL of the package being checked.
Logs are cached only for the most recent calls for any one package, and are over-written by any subsequent calls.

It is nevertheless often easier to directly log in to the running processes via SSH as described above, in which case the logs are dumped within a `templogs` sub-directory of `/home/.cache/R/pkgcheck/`.
These log files are all prefixed with the name of the package being checked.

:::{admonition} Debug Step 4
:class: tip
Ensure that log files were generated for the package.

- If using the HTTP endpoints, calls should always succeed as long as log files exist.
- If using SSH, there should be two files prefixed with the package name.
:::

If the bot has entirely failed to respond, it is likely because of an internal error, in which case the `stderr` log should hopefully contain sufficient information to help debug the problem.
The `stdout` log may provide additional detail in some cases.

If these logs confirm an internal error, the next step is generally to try to reproduce that error locally, through cloning the package and calling, or stepping through, the relevant [endpoint function](/roreviewapi/vignettes/endpoints).

:::{admonition} Debug Step 5
:class: tip
Try to locally reproduce any errors in the `stderr` log files, and solve problem from there.
:::

## Manual Debugging

Some errors may arise in which a `log` entry appears to have been correctly sent, and yet no `stdlogs` are generated.
These typically require manual debugging.
The best approach is then to manually run the `roreviewapi` Docker container on the Digital Ocean server, and step through the code to locate the source of the problem.
The general procedure for this is described in [the "Debugging" vignette of the `roreviewapi` package](https://ropensci-review-tools.readthedocs.io/en/latest/roreviewapi/vignettes/debugging.html#manually-running-checks).

The Digital Ocean droplet can be accessed via the Digital Ocean web interface, or via SSH.
The latter requires a public SSH key to be registered in the droplet.
Once in the droplet, the following lines will enter an R session within the Docker container:

``` bash
docker run -it --rm roreviewapi /bin/bash
R
```

The ["Debugging" vignette"](https://ropensci-review-tools.readthedocs.io/en/latest/roreviewapi/vignettes/debugging.html#manually-running-checks) then includes the following code chunk which can be stepped through to identify sources of any bugs:

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


These lines represent the main function calls within the ["editor check" endpoint](https://github.com/ropensci-review-tools/roreviewapi/blob/main/R/plumber.R) in the plumber function, which in turns calls [the `roreviewapi::editor_check()` function](https://docs.ropensci.org/roreviewapi/reference/editor_check.html).
The plumber endpoints themselves should generally be bug-free, although it may be worthwhile calling the two functions prior to that call (`check_issue_template()` and `stdout_stderr_cache()`).

See the actual code of [the `roreviewapi::editor_check()` function](https://docs.ropensci.org/roreviewapi/reference/editor_check.html) for further details, including code to handle non-default git branches.
It should be possible to locate the source of most errors somewhere within one of those calls.
