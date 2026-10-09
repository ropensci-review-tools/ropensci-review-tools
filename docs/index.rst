.. ropensci-review-tools documentation master file, created by
   sphinx-quickstart on Wed Aug 25 10:43:40 2021.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

ropensci-review-tools
================================

This organisation contains `several packages
<https://github.com/ropensci-review-tools>`_ developed for `rOpenSci
<https://ropensci.org>`_’s review process, including packages specifically for
the review of `statistical software <https://stats-devguide.ropensci.org>`_.


.. toctree::
   :maxdepth: 1
   :caption: Overview

   overview

The following are links to the primary documentation for each package. Those
wanting to use any one of these individual packages should follow the
appropriate link.

.. toctree::
   :maxdepth: 1
   :caption: Packages

   autotest/autotest.md
   dashboard/dashboard.md
   goodpractice/goodpractice.md
   pkgcheck/pkgcheck.md
   pkgcheck-action/pkgcheck-action.md
   pkgmatch/pkgmatch.md
   pkgstats/pkgstats.md
   orgmetrics/orgmetrics.md
   repometrics/repometrics.md
   roreviewapi/roreviewapi.md
   srr/srr.md

.. admonition:: Local Testing
   :class: tip

    Many of these packages have "extended tests" run only in response to a
    local environment variable:

    .. code-block:: bash

       RRT_TEST_ALL=true

    Maintainers of this entire suite should always have that permanently set in
    their ``~/.Renviron`` file.

.. admonition:: Makefiles
   :class: attention

   Most repositories include a `Makefile
   <https://www.gnu.org/software/make/manual/make.html#Introduction>`_.
   These work by typing ``make`` as a shell command -- not in an R console.
   Entering ``make`` alone will usually show a menu of options which include
   things like:

   .. code-block:: bash

      check                Run `rcmdcheck`
      doc                  Update package documentation with `roxygen2`
      help                 Show this help
      pkgcheck             Run `pkgcheck` and print results to screen.
      test                 Run test suite

   ... and generally many more. For example ``make doc`` will then run
   ``roxygenise()`` to update all docs.

.. admonition:: Pre-commit hooks
   :class: note

    All repositories also include `pre-commit hooks <https://pre-commit.com>`_,
    so each has a ``.pre-commit-config.yaml`` file, sometimes with extra hooks
    in a ``.hooks/`` sub-directory. These can be activated by running the R
    command, ``precommit::use_precommit()``, within the root directory of each
    pacakge. See the `precommit package
    <https://lorenzwalthert.github.io/precommit/>`_ for details.

----

The following are links to notes on maintaining the individual components of
the `"ropensci-review-tools" software ecosystem
<https://github.com/ropensci-review-tools>`_.

.. toctree::
   :maxdepth: 1
   :caption: Maintenance

   maintenance/pkgstats
   maintenance/pkgcheck
   maintenance/ropensci-review-bot
   maintenance/tokens

The following describe the main debugging processes.

.. toctree::
   :maxdepth: 1
   :caption: Debugging

   debugging/debugging


Finally, the following section describes components of our system used to
construct and maintain badges on GitHub README pages and package documentation.

.. toctree::
   :maxdepth: 1
   :caption: Badges

   badges/badges
