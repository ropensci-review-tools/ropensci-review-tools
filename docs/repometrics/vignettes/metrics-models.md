# Metrics models

The `repometrics` package allows the construction of
[“models”](https://chaoss.community/kbtopic/all-metrics-models/) adapted
from those developed by the [CHAOSS community (“Community Health
Analytics in Open Source Software”)](https://chaoss.community/). These
models collate various numbers of individual
[“metrics”](https://chaoss.community/kbtopic/all-metrics/):

> to provide deeper context and answer more complex questions about a
> community’s health.

The metrics used in the models are described in the separate [*CHAOSS
metrics*
vignette](https://docs.ropensci.org/repometrics/articles/chaoss-models.html),
and are detailed in the `data.frame` returned by [the
`rm_metrics_list()`
function](https://docs.ropensci.org/repometrics/reference/rm_metrics_list.html).

In contrast to the metrics, each of which is encoded as a separate
function within this package, the models are not hard-coded, rather the
metrics used in each are defined within a single JSON file stored at
[`extdata/metrics-models/metrics-models.json`](https://github.com/ropensci-review-tools/repometrics/blob/main/inst/extdata/metrics-models/metrics-models.json)
in the `inst` sub-directory of the package. This allows the model
construction to be easily modified without needing to modify the
underlying code of this package.

The file can be accessed by loading the package:

``` r
library (repometrics)
```

and then locating the file with:

``` r
f <- system.file (
    fs::path ("extdata", "metrics-models", "metrics-models.json"),
    package = "repometrics"
)
```

This file defines all [CHAOSS
metrics](https://chaoss.community/kbtopic/all-metrics/) used in this
package, and lists the metrics used to construct each model.

## The models used here

- [Developer
  responsiveness](https://chaoss.community/kb/metrics-model-development-responsiveness/)
- [Project
  engagement](https://chaoss.community/kb/metrics-model-project-engagement/)
- [Project
  awareness](https://chaoss.community/kb/metrics-model-project-awareness/)
- [Community
  activity](https://chaoss.community/kb/metrics-model-community-activity/)
- [OSS compliance and
  security](https://chaoss.community/kb/metrics-model-oss-project-viability-compliance-security/)
- [OSS project viability:
  community](https://chaoss.community/kb/metrics-model-oss-project-viability-community/)
- [OSS project viability:
  starter](https://chaoss.community/kb/metrics-model-project-viability-starter/)
- [OSS project viability:
  governance](https://chaoss.community/kb/metrics-model-oss-project-viability-governance/)
- [OSS project viability:
  strategy](https://chaoss.community/kb/metrics-model-oss-project-viability-strategy/)
- [Collaboration development
  index](https://chaoss.community/kb/metrics-model-collaboration-development-index/)
- [Community service and
  support](https://chaoss.community/kb/metrics-model-community-service-and-support/)
- [Starter project
  health](https://chaoss.community/kb/metrics-model-starter-project-health/)
- [Community
  welcomingness](https://chaoss.community/kb/metrics-model-community-welcomingness/)

Each model collates individual metrics defined in the
[`chaoss-models.json`
file](https://github.com/ropensci-review-tools/repometrics/blob/main/inst/extdata/chaoss-models/chaoss-models.json),
with final model values summing individual values of all component
metrics, as described in the following sub-section.

## Combining metrics within models

Different [CHAOSS
metrics](https://chaoss.community/kbtopic/all-metrics/) quantify
different properties, and are measured on different scales. To combine
metrics into a single model, differences in scale must be reconciled.
The [`metrics-models.json`
file](https://github.com/ropensci-review-tools/repometrics/blob/main/inst/extdata/metrics-models/metrics-models.json)
defines each metrics according to one of five types of measurement:

- *binary*, translated to 0 for false and 1 for true;
- *count*, for integer numbers greater than or equal to 0;
- *ratio*, for floating-point numbers between 0 and 1;
- *days*, for integer measurements in days; and
- *real*, for single, real values greater than zero.

Metrics measured as *counts* or *days* are log-transformed before being
aggregated to final models. Each metric also indicates where higher or
lower values are desirable. Aggregate model scores are designed so that
higher values are better, so any metrics for which lower values are
better are first negated before being aggregated into overall model
scores.
