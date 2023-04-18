
# GitHub tokens

This section describes procedures to update and maintain
GitHub tokens, which are needed for the 
[`pkgcheck`](https://github.com/ropensci-review-tools/pkgcheck),
[`pkgcheck-action`](https://github.com/ropensci-review-tools/pkgcheck-action), and
[`roreviewapi`](https://github.com/ropensci-review-tools/roreviewapi) 
packages.

## The "RRT_TOKEN"

"RRT" is the abbreviation of "ROpenSci Review Tools", and the "RRT_TOKEN" is
the main token used in `pkgcheck` to build the Docker image needed by the
external bot service, as well as the `pkgcheck-action`.

This token must be generated as a personal token by somebody with
administrative rights to all repositories. That means the token must first be
generated from that person's personal GitHub settings. Once (re-)generated, the
token can then be copied across to the tokens in both the 
[`pkgcheck`](https://github.com/ropensci-review-tools/pkgcheck) and
[`pkgcheck-action`](https://github.com/ropensci-review-tools/pkgcheck-action)
repositories.

All token should be given durations of 60 days at most. A [GitHub Actions
workflow run in the `pkgcheck`
repository](https://github.com/ropensci-review-tools/pkgcheck/blob/main/.github/workflows/monthly.yaml)
issues a monthly notification to a specified `pkgcheck` issue for the nominated
person to update the token.

### Assigning "RRT_TOKEN" updates to a different person

The person assuming responsibility for "RRT_TOKEN" updates must:

1. Update the [`pkgcheck` workflow
   file](https://github.com/ropensci-review-tools/pkgcheck/blob/main/.github/workflows/monthly.yaml)
   to ping their own GitHub name on the first line of the `body` command
   (currently [@mpadge](https://github.com/mpadge)).
2. Respond to the notifications each time they are issued, which is currently
   every month. (The "0 0 1" cron specification is "hour minute day-of-month",
   so 00:00 on the 1st day of each month.)

## Other tokens

### roreviewapi

The [`roreviewapi`
repository](https://github.com/ropensci-review-tools/roreviewapi) holds one
single token, "DO_IP", which stores the IP address of the Digital Ocean droplet
used to host the `pkgcheck` external service called by the bot.

### pkgcheck-action

The only token held in the [`pkgcheck-action`
repository](https://github.com/ropensci-review-tools/pkgcheck-action) is the "RRT_TOKEN" described above.

### pkgcheck

The [`pkgcheck`
repository](https://github.com/ropensci-review-tools/pkgcheck) holds the following tokens:

- `DOCKER_USERNAME` & `DOCKER_PASSWORD`: Currently set for private account of
  [@mpadge](https://github.com/mpadge), but could easily be modified to other
  values. Modification would then require updating the first line of [the
  Dockerfile in the `roreviewapi`
  repository](https://github.com/ropensci-review-tools/roreviewapi/blob/main/Dockerfile)
  to update the source of the base Docker image used to build that container.
- `NETLIFY_SITE_ID` & `NETLIFY_TOKEN`: Currently not used.
- `UNAME`: Currently not used.

No other tokens in `pkgcheck` are currently used.
