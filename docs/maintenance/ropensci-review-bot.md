
# ropensci-review-bot

Maintenance of `ropensci-review-bot`.

## Digital Ocean Server

All external services called by the bot are hosted on the Digital Ocean server,
and defined in the [`roreviewapi`
package](https://github.com/ropensci-review-tools/roreviewapi). The major
endpoint of that API is the `editor_check`, called both as part of the [Welcome
Responder](https://github.com/ropensci-org/buffy/blob/82dd29bae4aeaa6bf5ca77b27be82cacd3a1ba04/config/settings-production.yml#L18-L32),
and also able to be triggered by the [`check package`
command](https://github.com/ropensci-org/buffy/blob/82dd29bae4aeaa6bf5ca77b27be82cacd3a1ba04/config/settings-production.yml#L92-L106).

The service is built using `docker-compose`, as controlled by the
[`docker-compose.yml`
file](https://github.com/ropensci-review-tools/roreviewapi/blob/main/docker-compose.yml).
This in turn is built on top of the main
[`Dockerfile`](https://github.com/ropensci-review-tools/roreviewapi/blob/main/Dockerfile),
the first line of which shows that that in turn is build on top of the
[`mpadge/pkgcheck`
Dockerfile](https://github.com/ropensci-review-tools/pkgcheck/blob/main/Dockerfile).
These three components are now described in reverse order.

### mpadge/pkgcheck

This Docker image contains most of the system libraries required to build the
`roreviewapi` server. These include all libraries contained in the [GitHub
Ubuntu 20.04
runner](https://github.com/actions/virtual-environments/blob/main/images/linux/Ubuntu2004-README.md), 
and a selection of R packages. The image is [stored on
Dockerhub](https://hub.docker.com/r/mpadge/pkgcheck), and
rebuilt as a [GitHub
action](https://github.com/ropensci-review-tools/pkgcheck/blob/main/.github/workflows/docker.yaml)
as a weekly cron job (as well as on every push).

The image itself is built on top of the [`rocker/r-bspm`
image](https://github.com/rocker-org/bspm), for reasons explained at length in
[this arXiv manuscript](https://arxiv.org/abs/2103.08069). In short: `bspm` =
Bridge to System Package Manager, and is a system to enable binary installation
of system libraries as properly shared objects. Other system for installation
of binary R packages in Linux, such as `rspm`, do not properly link system
libraries, so that a library required by one package can not be shared by other
packages. `bspm` is both very fast because of binary installation, and very
robust and scalable, because system libraries are only installed once, after
which they are properly shared between any additional packages which require
them.

### `roreviewapi` Docker container

The docker image of the [`roreviewapi`
repository](https://github.com/ropensci-review-tools/roreviewapi/blob/main/Dockerfile)
is mainly used to pull the latest GitHub versions of the R packages contained
in the [`ropensci-review-tools`
organisation](https://github.com/ropensci-review-tools), as well as to
configure the server with the GitHub credentials of `ropensci-review-bot`.

### docker-compose

The docker compose actions are all contained within the [`restart.sh`
script](https://github.com/ropensci-review-tools/roreviewapi/blob/main/restart.sh)
within the `roreviewapi` repository. The entire service can be rebuilt and
restarted by calling this script, which is also added to the `crontab` of the
Digital Ocean instance, currently to update once a week.

