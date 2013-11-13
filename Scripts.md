---
layout: default
title: Scripts
scripturl: https://github.com/leeper/Rcourse/tree/gh-pages/Scripts
tutorialurl: http://www.thomasleeper.com/Rcourse/Tutorials
---

# Tutorial Scripts #

Below you will find links to a number of fully executable R scripts (written in [roxygen comments](https://github.com/yihui/knitr/blob/master/inst/examples/knitr-spin.R)) that walk through various aspects of R programming.

---
## The R language ##

* Basic math: [Script]({{ page.scripturl }}/basicmath.r) and [Tutorial]({{ page.tutorialurl }}/basicmath.html)

* Variables and assignment: [Script]({{ page.scripturl }}/variables.r) and [Tutorial]({{ page.tutorialurl }}/variables.html)

* Matrix algebra: [Script]({{ page.scripturl }}/matrixalgebra.r) and [Tutorial]({{ page.tutorialurl }}/matrixalgebra.html)

* Data structures:
  * Vectors: [Script]({{ page.scripturl }}/vectors.r) and [Tutorial]({{ page.tutorialurl }}/vectors.html)
  * Vector indexing: [Script]({{ page.scripturl }}/vectorindexing.r) and [Tutorial]({{ page.tutorialurl }}/vectorindexing.html)
  * Matrices: [Script]({{ page.scripturl }}/matrices.r) and [Tutorial]({{ page.tutorialurl }}/matrices.html)
  * Lists: [Script]({{ page.scripturl }}/lists.r) and [Tutorial]({{ page.tutorialurl }}/lists.html)
  * Dataframes: [Script]({{ page.scripturl }}/dataframes.r) and [Tutorial]({{ page.tutorialurl }}/dataframes.html)
  
* Object classes ([Script]({{ page.scripturl }}/classes.r) and [Tutorial]({{ page.tutorialurl }}/classes.html)), plus more information on:
  * Factors: [Script]({{ page.scripturl }}/factors.r) and [Tutorial]({{ page.tutorialurl }}/factors.html)
  * Logicals: [Script]({{ page.scripturl }}/logicals.r) and [Tutorial]({{ page.tutorialurl }}/logicals.html)

* Looking at objects: [Script]({{ page.scripturl }}/objects.r) and [Tutorial]({{ page.tutorialurl }}/objects.html)
* Missing values: [Script]({{ page.scripturl }}/NA.r) and [Tutorial]({{ page.tutorialurl }}/NA.html)


---
## Data as dataframes ##

* Loading/reading data into R: [Script]({{ page.scripturl }}/loadingdata.r) and [Tutorial]({{ page.tutorialurl }}/loadingdata.html)
  * Built-in data (`data`)
  * R data files (`load`)
  * Tabular data (`read.csv`, `read.table`, etc.)
  * Manual data entry and file scans (`scan` and `readLines`)
  * Reading foreign data (`read.spss`, `read.dta`, etc.)
  
* Viewing dataframe structure: [Script]({{ page.scripturl }}/dataframe-structure.r) and [Tutorial]({{ page.tutorialurl }}/dataframe-structure.html)

* Saving R data: [Script]({{ page.scripturl }}/savingdata.r) and [Tutorial]({{ page.tutorialurl }}/savingdata.html)
  * `save` and `load`
  * `dput` and `dget`
  * `dump` and `source`
  * `write.csv` and `write.table`

* Dataframe rearrangement: [Script]({{ page.scripturl }}/dataframe-arrangement.r) and [Tutorial]({{ page.tutorialurl }}/dataframe-arrangement.html)
  * `order`
  * `subset`
  * `split`
  * `sample`

  
---
## Data processing ##

* Recoding vectors: [Script]({{ page.scripturl }}/recoding.r) and [Tutorial]({{ page.tutorialurl }}/recoding.html)

* Scale construction (additive, multiplicative, logical): [Script]({{ page.scripturl }}/basicscales.r) and [Tutorial]({{ page.tutorialurl }}/basicscales.html)

  * See also: Matrix algebra ([Script]({{ page.scripturl }}/matrixalgebra.r) and [Tutorial]({{ page.tutorialurl }}/matrixalgebra.html))
  * Base R has many tools for scale construction, like `factanal` and `princomp`
  * Packages for advanced scaling include **psych** and **IRToys**. Details can be found on the [Psychometrics Task View](http://cran.r-project.org/web/views/Psychometrics.html)
  
* Handling missing data: [Script]({{ page.scripturl }}/NAhandling.r) and [Tutorial]({{ page.tutorialurl }}/NAhandling.html)

* Multiple imputation of missing data: [Script]({{ page.scripturl }}/mi.r) and [Tutorial]({{ page.tutorialurl }}/mi.html)


---
## Data summaries ##

* Univariate data summaries (including `summary`): [Script]({{ page.scripturl }}/univariate.r) and [Tutorial]({{ page.tutorialurl }}/univariate.html)
* Data tables and crosstables: [Script]({{ page.scripturl }}/tables.r) and [Tutorial]({{ page.tutorialurl }}/tables.html)
* Correlations and partial correlations: [Script]({{ page.scripturl }}/correlation.r) and [Tutorial]({{ page.tutorialurl }}/correlation.html)
* Printing numerics: [Script]({{ page.scripturl }}/numeric-printing.r) and [Tutorial]({{ page.tutorialurl }}/numeric-printing.html)


---
## Plotting as data summary ##

* Data summary plots: [Script]({{ page.scripturl }}/summaryplots.r) and [Tutorial]({{ page.tutorialurl }}/summaryplots.html)

  * Rugs (Marginal distributions for scatterplots): [Script]({{ page.scripturl }}/rugs.r) and [Tutorial]({{ page.tutorialurl }}/rugs.html)
  * Local regression (LOWESS/LOESS) for scatterplots: [Script]({{ page.scripturl }}/localregression.r) and [Tutorial]({{ page.tutorialurl }}/localregression.html)
  * `jitter` for scatterplots of categorical data: [Script]({{ page.scripturl }}/jitter.r) and [Tutorial]({{ page.tutorialurl }}/jitter.html)
  * add ons: `lines`, `segments` (for error bars), `polygon`, `points`, `abline`, `text`, `legend`
  * Plotting functions with `curve`: [Script]({{ page.scripturl }}/curve.r) and [Tutorial]({{ page.tutorialurl }}/curve.html) TODO

* Graphical parameters: [Script]({{ page.scripturl }}/graphicalparameters.r) and [Tutorial]({{ page.tutorialurl }}/graphicalparameters.html) TODO

  * For full details on graphical parameters, see [Graphical Parameters](http://stat.ethz.ch/R-manual/R-patched/library/graphics/html/par.html).

* Plotting Colors: [Script]({{ page.scripturl }}/plotcolors.r) and [Tutorial]({{ page.tutorialurl }}/plotcolors.html)

* Saving plots:
  * In RGui, you can use point-and-click menus to save plots, but it also possible to save plots using code. The appropriate function depends on the file format you desire for the resulting plot. The main ones are: `pdf`, `jpeg`, `png`, `tiff`, `bmp`, and `svg`. PDF and PNG are good choices, though TIFF is often required for academic publishing.
  * If building a plot in stages (e.g. overlaying different model fits), it is also possible to save the plot in different stages. This can be useful for building plots to be used in slides (e.g., to control the display the contents of a plot during the talk). Relevant functions here are: `dev.print`, `dev.copy`, `dev2bitmap`, and `savePlot`.

* Note: There are several other graphics packages (including **ggplot2**, **lattice**, and **grid**). My personal preference is to rely on the flexibility of base graphics, but these alternative approaches are preferred by some.


---
## Statistics ##

* Basic parametric statistical tests: [Script]({{ page.scripturl }}/basicparametrictests.r) and [Tutorial]({{ page.tutorialurl }}/basicparametrictests.html) TODO
  * `chisq.test`
  * `t.test`
  * `cor.test`
  * `prop.test`
  * `binom.test`

* One-way ANOVA (`aov`, `oneway.test`, and `kruskal.test`): [Script]({{ page.scripturl }}/anova.r) and [Tutorial]({{ page.tutorialurl }}/anova.html)

* Nonparametric statistical tests (e.g., `t.test` versus `wilcox_test`)

* Variance tests: [Script]({{ page.scripturl }}/variancetests.r) and [Tutorial]({{ page.tutorialurl }}/variancetests.html) TODO
  * `var.test`
  * `fligner.test`
  * `bartlett.test`
  * `ansari.test`

* Permutation tests: [Script]({{ page.scripturl }}/permutationtests.r) and [Tutorial]({{ page.tutorialurl }}/permutationtests.html)

* `by` and `*apply`

* Statistical distributions
  * Probability density, cumulative distribution, and quantile functions: [Script]({{ page.scripturl }}/distributions.r) and [Tutorial]({{ page.tutorialurl }}/distributions.html)
  * Random number generation


---
## Linear Regression (OLS) ##

* Model formulae: [Script]({{ page.scripturl }}/formulae.r) and [Tutorial]({{ page.tutorialurl }}/formulae.html)

* Bivariate OLS: [Script]({{ page.scripturl }}/olsbivariate.r) and [Tutorial]({{ page.tutorialurl }}/olsbivariate.html)

* Multivariate OLS: [Script]({{ page.scripturl }}/olsmultivariate.r) and [Tutorial]({{ page.tutorialurl }}/olsmultivariate.html)

* Model predicted values (`fitted` and `predict`)

* Goodness of fit and model comparison: [Script]({{ page.scripturl }}/olsfit.r) and [Tutorial]({{ page.tutorialurl }}/olsfit.html)
  
  * Regression tests (**lmtest**) TODO

* Heteroskedasticity-consistent SEs: [Script]({{ page.scripturl }}/olsrobustSEs.r) and [Tutorial]({{ page.tutorialurl }}/olsrobustSEs.html)

* Standardized coefficients: [Script]({{ page.scripturl }}/standardizedcoefficients.r) and [Tutorial]({{ page.tutorialurl }}/standardizedcoefficients.html)

* Regression in matrix form: [Script]({{ page.scripturl }}/matrixols.r) and [Tutorial]({{ page.tutorialurl }}/matrixols.html)

* Regression as a curve of conditional mean outcomes: [Script]({{ page.scripturl }}/olsmeans.r) and [Tutorial]({{ page.tutorialurl }}/olsmeans.html)

* Two-stage least squares (instrumental variables) TODO


---
## Regression plotting ##

* Plots for regression diagnostics: [Script]({{ page.scripturl }}/olsplots.r) and [Tutorial]({{ page.tutorialurl }}/olsplots.html)
  * Default plots from `plot(lm)`
  * Residual plots and `qqplot`
  * Scatterplots

* Regression coefficient summary plots: [Script]({{ page.scripturl }}/olscoefplot.r) and [Tutorial]({{ page.tutorialurl }}/olscoefplot.html)

* Plots for OLS linear effects: [Script]({{ page.scripturl }}/olsresultplots.r) and [Tutorial]({{ page.tutorialurl }}/olsresultplots.html)

* Plots for interaction effects

  * Plots for binary interactions: [Script]({{ page.scripturl }}/olsinteractionplots.r) and [Tutorial]({{ page.tutorialurl }}/olsinteractionplots.html)
  * Plots for continuous-by-continuous interactions: [Script]({{ page.scripturl }}/olsinteractionplots2.r) and [Tutorial]({{ page.tutorialurl }}/olsinteractionplots2.html)
  * Predicted outcomes
  

---
## Generalized Linear Models ##

The tutorials below supply a basic introduction to many GLM techniques. A guide to all of the available packages and functions for GLMs can be found in the [Econometrics Task View](http://cran.r-project.org/web/views/Econometrics.html).

* Binary outcome models (and link functions): [Script]({{ page.scripturl }}/binaryglm.r) and [Tutorial]({{ page.tutorialurl }}/binaryglm.html) TODO -> bivariate and multivariate

  * Simple plots (Bivariate predicted probabilities): [Script]({{ page.scripturl }}/binaryglmplots.r) and [Tutorial]({{ page.tutorialurl }}/binaryglmplots.html)
  * Multivariate predicted probabilities, interactions, and marginal effects: [Script]({{ page.scripturl }}/binaryglmeffects.r) and [Tutorial]({{ page.tutorialurl }}/binaryglmeffects.html)
  
* Ordered outcome models: [Script]({{ page.scripturl }}/orderedglm.r) and [Tutorial]({{ page.tutorialurl }}/orderedglm.html)

  * Estimation, predicted probabilities, and plots

* Count outcome models: [Script]({{ page.scripturl }}/countglm.r) and [Tutorial]({{ page.tutorialurl }}/countglm.html) TODO

  * Count model plots: [Script]({{ page.scripturl }}/countglmplots.r) and [Tutorial]({{ page.tutorialurl }}/countglmplots.html) TODO

* Multinomial outcome models: [Script]({{ page.scripturl }}/nominalglm.r) and [Tutorial]({{ page.tutorialurl }}/nominalglm.html)
  * Estimation, predicted probabilities, and plots
  * Multinomial logit is also available from the **mlogit** package
  * Multinomial probit is available in the **MNP** package

* Survival models from **survival** TODO

* Note: Gary King's **[Zelig](http://projects.iq.harvard.edu/zelig)** set of packages provides a slightly more unified interface for GLMs, but it is basically just a convenient wrapper for the functions described in the above tutorials.

 
---
## Experiments ##

* ANOVA: [Script]({{ page.scripturl }}/anova.r) and [Tutorial]({{ page.tutorialurl }}/anova.html)
* Permutation tests: [Script]({{ page.scripturl }}/permutationtests.r) and [Tutorial]({{ page.tutorialurl }}/permutationtests.html)
* Power and minimum detectable effects: [Script]({{ page.scripturl }}/power.r) and [Tutorial]({{ page.tutorialurl }}/power.html) TODO
* Plotting means and effects
* Clustering
* Analysis of noncompliance/LATEs


---
## Reproducible research ##

* Using `source`

* Using `sink`

* Comments: [Script]({{ page.scripturl }}/comments.r) and [Tutorial]({{ page.tutorialurl }}/comments.html)

* Public data archiving with **dvn**: [Script]({{ page.scripturl }}/dvn.r) and [Tutorial]({{ page.tutorialurl }}/dvn.html)

* Integration with Microsoft Word
  * Writing output to Word: [Script]({{ page.scripturl }}/wordoutput.r) and [Tutorial]({{ page.tutorialurl }}/wordoutput.html)
  * Dynamic reports with odfSweave: [Script]({{ page.scripturl }}/odfsweave.r) and [Tutorial]({{ page.tutorialurl }}/odfsweave.html) TODO

* knitr `stitch`

* Integration with LaTeX reports
  * `knit`
  * `xtable` (also `hmisc::Latex`, **apsrtable**, and **stargazer**)

* Presentations with beamer

* Web publishing with Rmarkdown
  * knitr
  * R2HTML
  * Slidify


---
## Repeated tasks ##

* `apply` and `*apply` family
* loops (`for`, `while`)
* Split-Apply-Combine (`by`, `split`)
* Sampling/Bootstrapping/permutations (`sample` and `replicate`)
* Aggregation functions (`ave`, `aggregate`, etc.)


---
## User-Defined functions ##

* Variable scope and environments
* Return values (`return` and `invisible`)
* Custom classes
* Default arguments
* `print` and `summary` S3 methods


---
## Over-time data ##

* Time-series (`ts` class)
* Panel data (`plm`)
* Mixed effects
* Multi-level models


---
## Text processing ##

* String manipulation: [Script]({{ page.scripturl }}/stringmanipulation.r) and [Tutorial]({{ page.tutorialurl }}/stringmanipulation.html)
* Regular expressions: [Script]({{ page.scripturl }}/regex.r) and [Tutorial]({{ page.tutorialurl }}/regex.html) TODO
* Reading and writing to console, files, and connections


---
## Other advanced topics ##

* File manipulation: `list.files`/`dir`, `file.create`, etc.
* System calls: `shell`, `shell.exec`, and `system`
* Bayes: **MCMCpack**, **RJags**, **RBugs**, RStan
* Big data: data.table, parallel computing
* Mapping
* Web services: **twitteR**, **MTurkR**
