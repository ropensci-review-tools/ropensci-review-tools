
# Badges

This section describes procedures to create, maintain, and update badges which
ultimately appear on each repositories README page.

## Source for badges

The source "svg" files for all badges are held in [the "svgs" directory of 
github.com/ropensci-org/badges](https://github.com/ropensci-org/badges/tree/main/svgs).
New badges needs to be created there, generally by copying an existing badge
and then editing the "svg" file.

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
