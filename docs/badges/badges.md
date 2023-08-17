
# Badges

This section describes procedures to create, maintain, and update badges which
ultimately appear on each repositories README page.

---

## Source for badges

The source "svg" files for all badges are held in [the "svgs" directory of 
github.com/ropensci-org/badges](https://github.com/ropensci-org/badges/tree/main/svgs).
New badges needs to be created there, generally by copying an existing badge
and then editing the "svg" file. These files should be edited in a code (text)
editor, and *not* in an image editor.

### Statistical Software Review Badges

Badges for statistics packages include the version number of [the *Statistical
Software Standards*](https://stats-devguide.ropensci.org/standards.html)
current at the time of package acceptance, coloured according to [the "grade"
of standards
compliance](https://stats-devguide.ropensci.org/pkgdev.html#pkgdev-badges)
(either bronze, silver, or gold). They look like this:

![](https://raw.githubusercontent.com/ropensci-org/badges/main/svgs/gold-v0.2.svg)

Each new version of the standards requires three corresponding badges to be
added to the "svgs" directory [of the "badges"
repository](https://github.com/ropensci-org/badges/tree/main/svgs), one for
each colour. This can be done by simply copying one of the previous versions,
and replacing the version numbers on the last two lines of each file with
updated ones.

---

## The 'badges' server and repository

The repository holding the source badges
([github.com/ropensci-org/badges](https://github.com/ropensci-org/badges))
serves the primary function of assigning an appropriate badge to each rOpenSci
repository. These badges are served by our "badge server" which is deployed in
the last step of [the GitHub Action in that
repository](https://github.com/ropensci-org/badges/blob/main/.github/workflows/badges.yml).
The badge for each repository is uniquely identified by the issue number of
[the software-review
repository](https://github.com/ropensci/software-review/issues), for example
'badges.ropensci.org/222_stats.svg' for [the {epubr}
package](https://github.com/ropensci/epubr) reviewed in [issue number
222](https://github.com/ropensci/software-review/issues/222), which looks like
this:

![](https://badges.ropensci.org/222_status.svg)

The rOpenSci package reviewed in issue number XYZ can then display the
appropriate badge by simply linking to
'https://badges.ropensci.org/XYZ_status.svg'.

### The badge script

The server providing the badges reads them directly from the "pkgsvgs"
directory of the "gh-pages" branch of that repository. This directory is
populated by the [main script,
`update_badges.rb`](https://github.com/ropensci-org/badges/blob/main/update_badges.rb).
This script is called from [the GitHub
Action](https://github.com/ropensci-org/badges/blob/main/.github/workflows/badges.yml#L25-L26),
and copies the appropriate badges from the source directory ("svgs") in the
main branch to the "pkgsvgs" directory in the gh-pages branch, renaming each
according to the review issue number of each package.


---

## Constructing and implementing new badges

The following steps describe the procedure which must be followed to construct and implement new badges.

1. Design a new badge and save it in [the "svgs" folder of the badges
   repository](https://github.com/ropensci-org/badges/tree/main/svgs).
2. Design a corresponding GitHub "approved" issue label in [the main
   software-review
   repository](https://github.com/ropensci/software-review/labels). This label
   must begin with "6/approved-", followed by the desired new text. Note the
   slash after "6" is forward, not backward!
3. The bot then needs to be modified to recognise any new badges, like [this
   code which processes statistics
   badges](https://github.com/ropensci-org/buffy/blob/044d630b554a7963aa2a1d8febe9422edd5643bd/app/responders/ropensci/approve_responder.rb#L34-L46).
   That will then ensure that the `approve` command will also add the
   corresponding label to the issue thread.
4. Modify [the `update_badges.rb` script in the badges
   repository](https://github.com/ropensci-org/badges/blob/main/update_badges.rb)
   to recognise the new labels. The value of these new values will then
   generally be in the first field of [the `iss_peer_rev_files` object,
   currently called
   "color"](https://github.com/ropensci-org/badges/blob/358a433204b89f4fa2f8b09661d2d6dec9ea4cab/update_badges.rb#L44-L49).
   The remainder of that script will then also need modifying to process
   entires with `color` values but no `version` values...

After updating the script, the new badges should be automatically deployed and
assigned to the appropriate review issues.
