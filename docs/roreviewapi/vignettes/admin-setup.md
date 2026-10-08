# Admin Setup

This vignette describes the one-time infrastructure steps required to
deploy `roreviewapi` on a Digital Ocean droplet, including the editor
volunteer search feature introduced in v0.2.

<div class="alert alert-info">

The Software Peer Review Lead should set up a regular alert system to
automatically check the deployment status. This bash script issues an
alert if anything is wrong:

``` bash
#!/usr/bin/env bash

URL="https://reviewbot.ropensci.org"
status=$(curl -s -o /dev/null -w "%{http_code}" "$URL")

if [[ "$status" != "404" ]]; then
    echo -e "reviewbot is down"
    exit 1
fi
```

That should then be regularly called, for example by calling it within a
`~/.bashrc` file, or via a local cron job.

</div>

## Prerequisites

- SSH access to the Digital Ocean droplet
- A [Postmark](https://postmarkapp.com) account with a verified sender
  address
- Access to the AirTable base containing the editor-in-chief rotation
  table
- Ability to request DNS records for your institution’s domain

## Environment variables

The following environment variables must be set in the `Dockerfile`
before building the image. Each appears twice: once as an `ENV`
declaration at the top of the file, and once in the `~/.Renviron` block
that makes the value available to R at runtime.

| Variable | Description |
|----|----|
| `GITHUB_PAT` | GitHub personal access token |
| `POSTMARK_API_TOKEN` | Postmark server API token (from the Postmark dashboard) |
| `POSTMARK_FROM` | Verified sender address registered with Postmark |
| `AIRTABLE_API_KEY` | AirTable personal access token |
| `AIRTABLE_BASE_ID` | ID of the AirTable base containing the EiC rotation table |
| `ROREVIEWAPI_BASE_URL` | Public HTTPS base URL of the deployed API (`https://reviewbot.ropensci.org`) |
| `PKGCHECK_TOKEN` | pkgcheck authentication token (set directly in `~/.Renviron`) |

Replace each `<placeholder>` in `Dockerfile` with the real value before
building.

## Postmark

1.  Create a Postmark account at <https://postmarkapp.com>.
2.  Add and verify a sender address under **Sender Signatures**. This
    address will appear as the `From:` address on all outgoing emails
    and must be set as `POSTMARK_FROM`.
3.  Navigate to **Servers → Your Server → API Tokens** and copy the
    server API token. Set this as `POSTMARK_API_TOKEN` in the
    `Dockerfile`.

## AirTable

1.  Generate a personal access token at
    <https://airtable.com/create/tokens> with at least
    `data.records:read` scope on the relevant base. Set this as
    `AIRTABLE_API_KEY`.
2.  Open the AirTable base and copy the base ID from the URL
    (`https://airtable.com/appXXXXXXXX/...`). Set this as
    `AIRTABLE_BASE_ID`.

The `editor-in-chief-rotation` table within that base must have
`period_start`, `period_end`, and `acting_eic_email` fields.

## Droplet preparation

Create the persistent data directory that will be bind-mounted into the
container. This directory holds the SQLite database and the notify-email
cache file and must survive container rebuilds.

``` bash
sudo mkdir -p /srv/roreviewapi/data
sudo chmod 700 /srv/roreviewapi/data
```

## DNS

Ask your DNS administrator to add an `A` record pointing your chosen
subdomain to the droplet’s IP address, for example:

    review.example.org.  IN  A  <droplet-ip>

Allow up to 24 hours for propagation, though it is usually much faster.

## TLS certificate

Once the DNS record is live, obtain a Let’s Encrypt certificate on the
droplet. The `--standalone` method requires port 80 to be free (stop the
running stack first if necessary):

``` bash
sudo apt install certbot
sudo certbot certonly --standalone -d reviewbot.ropensci.org
```

The certificate and key are written to
`/etc/letsencrypt/live/review.example.org/`. Certbot installs a systemd
timer that renews certificates automatically; confirm it is active:

``` bash
systemctl status certbot.timer
```

### Troubleshooting: HTTP-01 challenge failed

The HTTP-01 challenge works by certbot binding a temporary server to
port 80. Two things can prevent this:

**Port 80 occupied.** The Docker stack must be stopped before running
certbot, otherwise nginx holds port 80 and the challenge fails
immediately:

``` bash
docker-compose down
sudo certbot certonly --standalone -d review.example.org
docker-compose up -d
```

**Port 80 blocked by a firewall.** There are two independent firewalls
to check:

*Droplet firewall (ufw):*

``` bash
sudo ufw status
```

If ufw is active and port 80 is not listed, open it:

``` bash
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
```

*Digital Ocean cloud firewall:* in the DO console under **Networking →
Firewalls**, confirm there is an inbound rule allowing TCP port 80 from
all sources. The cloud firewall sits in front of the droplet and blocks
traffic before it reaches ufw, so both layers must allow port 80.

To confirm DNS has propagated before retrying certbot, check that the A
record resolves to the droplet IP:

``` bash
dig +short review.example.org
```

## Deployment

Set `NGINX_SERVER_NAME` in the environment before starting the stack —
this value is substituted into `nginx.conf` at container startup:

``` bash
export NGINX_SERVER_NAME=review.example.org
docker-compose up -d --build
```

The compose file:

- Mounts `/srv/roreviewapi/data` into the plumber container at
  `/data/email`, and sets
  `ROREVIEWAPI_EMAIL_DB=/data/email/searches.sqlite` so the SQLite
  database persists across rebuilds.
- Mounts `/etc/letsencrypt` read-only into the nginx container so the
  certificate is available.
- Exposes ports 80 (HTTP → HTTPS redirect) and 443 (HTTPS).

## Editor search endpoints

Four endpoints support the volunteer editor search workflow. All require
the shared `secret` token.

### `GET /send_search`

Fetches current editor email addresses from AirTable and GitHub, inserts
a search record into the database, and dispatches personalised
click-link emails via Postmark. The submission type (standard vs. stats)
is determined automatically from the GitHub issue template.

Parameters: `repourl`, `repo` (org/repo), `issue_id`, `secret`.

### `GET /click/<token>`

Records a volunteer response. Returns an HTTP 200 confirmation page, an
“already used” page on duplicate clicks, or an “expired” page if the
search has been deactivated. Sends a notification email to the current
editor-in-chief on the first valid click.

No authentication required — the token itself is the credential.

### `GET /list_searches`

Returns a data frame of all active and inactive searches with recipient
totals and click counts. Use this to find the `repourl` value needed to
deactivate a search.

Parameters: `secret`.

### `GET /deactivate_search`

Marks the search inactive (preventing further click responses) and
permanently deletes all recipient rows and the search record from the
database.

Parameters: `repourl`, `secret`.

## Notify email cache

At startup, `serve_api()` fetches the current editor-in-chief email
address from AirTable and writes it to `/data/email/notify_email.txt`
(alongside the SQLite database). This cache is refreshed every 24 hours
via a background timer. If the AirTable call fails, the existing cached
value is preserved and an error is logged.

The cached address is used as the notification recipient whenever a
volunteer clicks a search link.
