This vignette describes how `roreviewapi` sends editor-search emails
through the Gmail API, sending “from” the `reviewbot@ropensci.org` alias
but authorized under a single Google account. Set that account once as
an environment variable, and every later step refers back to it:

``` bash
export USER_EMAIL=mark@ropensci.org
```

This vignette complements the [admin setup
vignette](https://docs.ropensci.org/roreviewapi/articles/admin-setup.html),
covering only the Gmail-specific pieces of the editor volunteer search
workflow.

## Prerequisites

- A Google Cloud Console project owned by the rOpenSci Workspace’s Cloud
  Identity org
- A local machine with a browser, for the one-time OAuth authorization
- SSH access to the Digital Ocean droplet

## 1. Google Cloud Console

In the `ro-auto-email` project:

1.  Enable the **Gmail API**.
2.  Configure the **OAuth consent screen** with **Audience: Internal**
    (requires the project to be owned by the Workspace’s Cloud Identity
    org). Internal governs who can *authorize* the app, not who receives
    mail — it skips Google verification and the 7-day refresh-token
    expiry that applies to unverified External apps. Request scope
    `https://www.googleapis.com/auth/gmail.send`.
3.  Create an **OAuth 2.0 Client ID**, type **Desktop app**. Download
    `client_secret_<id>.apps.googleusercontent.com.json`.

## 2. Authorize once, locally

Run this on a local machine, not the droplet (it needs a browser and a
`localhost` redirect):

``` r
library (gmailr)
gm_auth_configure (path = "client_secret_<id>.apps.googleusercontent.com.json")
gm_auth (
    email  = Sys.getenv ("USER_EMAIL"),
    scopes = c ("gmail.modify", "gmail.settings_basic"),
    cache  = "gmailr_token"
)
```

Log in as `$USER_EMAIL` and grant consent. This caches a refresh token
to the `gmailr_token/` directory, which is portable to the droplet
afterward since it is tied to the Google account, not the machine.

Always pass the same `scopes` used here in any later `gm_auth()` call —
a mismatch forces a fresh interactive re-authorization, which does not
work headless on the droplet.

## 3. Send-as alias

Add `reviewbot@ropensci.org` as a “Send mail as” address under
`$USER_EMAIL`’s Gmail settings (Settings → Accounts → Send mail as). No
separate authorization is needed, as the `gmail.send` scope already
covers sending as any verified alias of that account. This is set via
`gm_from()` on each outgoing message.

## 4. Code

[`R/editor-search.R`](https://github.com/ropensci-review-tools/roreviewapi/blob/main/R/editor-search.R):

- `gmail_auth()` configures and authorizes `gmailr` from the cached
  credentials.
- `gmail_send(to, subject, html_body)` builds and sends one message via
  `gm_mime()`/`gm_from()`/`gm_to()`/`gm_subject()`/`gm_html_body()`/
  `gm_send_message()`.
- `gmail_send_batch(emails, links, subject, repo, issue_id)` loops
  `gmail_send()` once per recipient with `Sys.sleep(0.1)` between sends,
  since there is no Gmail equivalent of a batch-send endpoint for
  personalized messages.

The `send_search` and `handle_click` endpoints each take an injectable
`sender` parameter (default `gmail_send_batch` / `gmail_send`) for
testing.

## 5. Environment variables

| Variable | Value |
|----|----|
| `GMAIL_SENDER` | `reviewbot@ropensci.org` |
| `GMAIL_OAUTH_CLIENT_SECRET` | `/data/email/client_secret_<id>.apps.googleusercontent.com.json` |
| `GMAIL_TOKEN_CACHE` | `/data/email/gmailr_token` |
| `GMAIL_AUTH_EMAIL` | `$USER_EMAIL` |

Set these in a local `.env` file for local runs. In production they are
baked into the image via `Dockerfile` `ENV` placeholders plus a
`RUN echo ... >> ~/.Renviron` line — fill in the real values directly in
the `Dockerfile` on the droplet before building. Do **not** add them to
`docker-compose.yml`’s `environment:` block: the droplet has no `.env`,
so `${VAR}` there resolves to an empty string and overrides the
Dockerfile’s baked-in value.

## 6. Deploy credentials to the droplet

Copy `client_secret_<id>.apps.googleusercontent.com.json` and the
`gmailr_token/` directory to `/srv/roreviewapi/data/` (bind-mounted into
the container at `/data/email`). That directory is Docker/root-owned, so
`scp` to your home directory first, then move into place:

``` bash
scp client_secret_<id>.apps.googleusercontent.com.json youruser@droplet:~/
scp -r gmailr_token youruser@droplet:~/

# on the droplet:
sudo mv ~/client_secret_<id>.apps.googleusercontent.com.json /srv/roreviewapi/data/
sudo mv ~/gmailr_token /srv/roreviewapi/data/
sudo chmod 600 /srv/roreviewapi/data/client_secret_<id>.apps.googleusercontent.com.json
sudo chmod 700 /srv/roreviewapi/data/gmailr_token
sudo chmod 600 /srv/roreviewapi/data/gmailr_token/*
```

## 7. Verify

- Call `send_search()` against a real/test issue; confirm delivery from
  `reviewbot@ropensci.org`.
- Click a tracking link; confirm the notify-email arrives via
  `gmail_send()`.
- Run the test suite.

## 8. Transfer maintenance

**Operations only** (a new person deploys/debugs, auth stays as
`$USER_EMAIL`) — nothing about the token changes:

1.  Add them to the `ro-auto-email` Google Cloud project’s IAM.
2.  Add their SSH key / sudo access on the droplet.
3.  Add them to the `roreviewapi` GitHub repo.
4.  Hand over this document.

**Authorizing identity itself** (needed if `mark@ropensci.org` becomes
unusable, e.g. leaving the org):

1.  Add `reviewbot@ropensci.org` as a “Send mail as” alias under the new
    maintainer’s Gmail account.
2.  They run the authorization in Section 2 as themselves, with the same
    `client_secret_....json`, producing their own `gmailr_token/`.
3.  Update `GMAIL_AUTH_EMAIL` (local `.env` and `Dockerfile`
    placeholder) to their address; `GMAIL_SENDER` stays
    `reviewbot@ropensci.org`.
4.  Deploy their `client_secret_....json` and `gmailr_token/` to
    `/srv/roreviewapi/data/`, replacing the old ones (Section 6).
5.  Rebuild and redeploy (`restart.sh`).
6.  Revoke the old grant from the departing account’s Google Account →
    Security → “Third-party apps with account access”.
