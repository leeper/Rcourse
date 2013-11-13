---
layout: default
title: Scripts
scripturl: https://github.com/leeper/Rcourse/tree/gh-pages/Scripts
tutorialurl: https://github.com/leeper/Rcourse/tree/gh-pages/Tutorials
---

# Tutorial Scripts #

Below you will find links to a number of fully executable R scripts (written in [roxygen comments](https://github.com/yihui/knitr/blob/master/inst/examples/knitr-spin.R)) that walk through various aspects of R programming.

---
## The R language ##

* [Basic math]({{ page.scripturl }}/basicmath.r)

* [Variables and assignment]({{ page.scripturl }}/variables.r)

* [Matrix algebra]({{ page.scripturl }}/matrixalgebra.r)

* Data structures:
  * [Vectors]({{ page.scripturl }}/vectors.r) and [Vector indexing]({{ page.scripturl }}/vectorindexing.r)
  * [Matrices]({{ page.scripturl }}/matrices.r)
  * [Lists]({{ page.scripturl }}/lists.r)
  * [Dataframes]({{ page.scripturl }}/dataframes.r)
  
* Object [classes]({{ page.scripturl }}/classes.r), plus more information on:
  * [Factors]({{ page.scripturl }}/factors.r)
  * [Logicals]({{ page.scripturl }}/logicals.r)

* [Looking at objects]({{ page.scripturl }}/objects.r)
* [Missing values]({{ page.scripturl }}/NA.r)


---
## Data as dataframes ##

* [Reading data into R]({{ page.scripturl }}/loadingdata.r)
  * Built-in data (`data`)
  * R data files (`load`)
  * Tabular data (`read.csv`, `read.table`, etc.)
  * Manual data entry and file scans (`scan` and `readLines`)
  * Reading foreign data (`read.spss`, `read.dta`, etc.)
  
* [Viewing dataframe structure]({{ page.scripturl }}/dataframe-structure.r)

* [Saving R data]({{ page.scripturl }}/savingdata.r)
  * `save` and `load`
  * `dput` and `dget`
  * `dump` and `source`
  * `write.csv` and `write.table`

* [Dataframe rearrangement]({{ page.scripturl }}/dataframe-arrangement.r)
  * `order`
  * `subset`
  * `split`
  * `sample`

  
---
## Data processing ##

* [Recoding vectors]({{ page.scripturl }}/recoding.r)

* [Scale construction (additive, multiplicative, logical)]({{ page.scripturl }}/basicscales.r)

  * See also: [Matrix algebra]({{ page.scripturl }}/matrixalgebra.r)
  * Base R has many tools for scale construction, like `factanal` and `princomp`
  * Packages for advanced scaling include **psych** and **IRToys**. Details can be found on the [Psychometrics Task View](http://cran.r-project.org/web/views/Psychometrics.html)
  
* [Handling missing data]({{ page.scripturl }}/NAhandling.r)

* [Multiple imputation of missing data]({{ page.scripturl }}/mi.r)


---
## Data summaries ##

* [Univariate data summaries]({{ page.scripturl }}/univariate.r) (including `summary`)
* [Data tables and crosstables]({{ page.scripturl }}/tables.r)
* [Correlations and partial correlations]({{ page.scripturl }}/correlation.r)
* [Printing numerics]({{ page.scripturl }}/numeric-printing.r)


---
## Plotting as data summary ##

* [Data summary plots]({{ page.scripturl }}/summaryplots.r)

  * [Rugs: Marginal distributions for scatterplots]({{ page.scripturl }}/rugs.r)
  * [Local regression (LOWESS/LOESS) for scatterplots]({{ page.scripturl }}/localregression.r)
  * [`jitter` for scatterplots of categorical data]({{ page.scripturl }}/jitter.r)
  * `plot` for [Line plots]({{ page.scripturl }}/lineplots.r) TODO
  * add ons: `lines`, `segments` (for error bars), `polygon`, `points`, `abline`, `text`, `legend`
  * [Plotting functions with `curve`]({{ page.scripturl }}/curve.r) TODO

* [Graphical parameters]({{ page.scripturl }}/graphicalparameters.r) TODO

  * For full details on graphical parameters, see [Graphical Parameters](http://stat.ethz.ch/R-manual/R-patched/library/graphics/html/par.html).

* [Plotting Colors]({{ page.scripturl }}/plotcolors.r)

* [Saving plots]({{ page.scripturl }}/savingplots.r) TODO

  * `pdf`, `jpeg`, `png`, `tiff`, `bmp`, `svg`
  * `dev.print`, `dev.copy`, `dev2bitmap`, `savePlot`

* Note: There are several other graphics packages (including **ggplot2**, **lattice**, and **grid**). My personal preference is to rely on the flexibility of base graphics, but these alternative approaches are preferred by some.


---
## Statistics ##

* [Basic parametric statistical tests]({{ page.scripturl }}/basicparametrictests.r) TODO
  * `chisq.test`
  * `t.test`
  * `cor.test`
  * `prop.test`
  * `binom.test`

* [ANOVA (`aov`)]({{ page.scripturl }}/anova.r)

* Nonparametric statistical tests
  * `t.test` versus `wilcox_test` 
  * `aov` versus `kruskal.test`

* [Variance tests]({{ page.scripturl }}/variancetests.r) TODO
  * `var.test`
  * `fligner.test`
  * `bartlett.test`
  * `ansari.test`

* [Permutation tests]({{ page.scripturl }}/permutationtests.r)

* `by` and `*apply`

* Statistical distributions
  * Normal: `rnorm`, `pnorm`, `qnorm`, and `dnorm`
  * Also look at uniform, binomial, and t distributions


---
## Linear Regression (OLS) ##

* [Model formulae]({{ page.scripturl }}/formulae.r)

* [Bivariate OLS]({{ page.scripturl }}/olsbivariate.r)

* [Multivariate OLS]({{ page.scripturl }}/olsmultivariate.r)

* Model predicted values (`fitted` and `predict`)

* [Goodness of fit and model comparison]({{ page.scripturl }}/olsfit.r)
  
  * Regression tests (**lmtest**) TODO

* [Heteroskedasticity-consistent SEs]({{ page.scripturl }}/olsrobustSEs.r)

* [Standardized coefficients]({{ page.scripturl }}/standardizedcoefficients.r)

* [Regression in matrix form]({{ page.scripturl }}/matrixols.r)

* [Regression as a curve of conditional mean outcomes]({{ page.scripturl }}/olsmeans.r)

* Two-stage least squares (instrumental variables) TODO


---
## Regression plotting ##

* [Plots for regression diagnostics]({{ page.scripturl }}/olsplots.r)
  * Default plots from `plot(lm)`
  * Residual plots and `qqplot`
  * Scatterplots

* [Regression coefficient summary plots]({{ page.scripturl }}/olscoefplot.r)

* [Plots for OLS linear effects]({{ page.scripturl }}/olsresultplots.r)

* Plots for interaction effects

  * [Plots for binary interactions]({{ page.scripturl }}/olsinteractionplots.r)
  * [Plots for continuous-by-continuous interactions]({{ page.scripturl }}/olsinteractionplots2.r)
  * Predicted outcomes
  

---
## Generalized Linear Models ##

The tutorials below supply a basic introduction to many GLM techniques. A guide to all of the available packages and functions for GLMs can be found in the [Econometrics Task View](http://cran.r-project.org/web/views/Econometrics.html).

* [Binary outcome models (and link functions)]({{ page.scripturl }}/binaryglm.r) TODO -> bivariate and multivariate

  * [Simple plots (Bivariate predicted probabilities)]({{ page.scripturl }}/binaryglmplots.r)
  * [Multivariate predicted probabilities, interactions, and marginal effects]({{ page.scripturl }}/binaryglmeffects.r)
  
* [Ordered outcome models]({{ page.scripturl }}/orderedglm.r)

  * Estimation, predicted probabilities, and plots

* [Count outcome models]({{ page.scripturl }}/countglm.r) TODO

  * [Count model plots]({{ page.scripturl }}/countglmplots.r) TODO

* [Multinomial outcome models]({{ page.scripturl }}/nominalglm.r)
  * Estimation, predicted probabilities, and plots
  * Multinomial logit is also available from the **mlogit** package
  * Multinomial probit is available in the **MNP** package

* Survival models from **survival** TODO

* Note: Gary King's **[Zelig](http://projects.iq.harvard.edu/zelig)** set of packages provides a slightly more unified interface for GLMs, but it is basically just a convenient wrapper for the functions described in the above tutorials.

 
---
## Experiments ##

* [ANOVA]({{ page.scripturl }}/anova.r)
* [Permutation tests]({{ page.scripturl }}/permutationtests.r)
* [Power and minimum detectable effects]({{ page.scripturl }}/power.r)
* Plotting means and effects
* Clustering
* Analysis of noncompliance/LATEs


---
## Reproducible research ##

* Using `source`

* Using `sink`

* [Comments]({{ page.scripturl }}/comments.r)

* [Public data archiving with **dvn**]({{ page.scripturl }}/dvn.r)

* Integration with Microsoft Word
  * [Writing output to Word]({{ page.scripturl }}/wordoutput.r)
  * [Dynamic reports with odfSweave]({{ page.scripturl }}/odfsweave.r) TODO

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

* [String manipulation]({{ page.scripturl }}/stringmanipulation.r)
* [Regular expressions]({{ page.scripturl }}/regex.r) TODO
* Reading and writing to console, files, and connections


---
## Other advanced topics ##

* File manipulation: `list.files`/`dir`, `file.create`, etc.
* System calls: `shell`, `shell.exec`, and `system`
* Bayes: **MCMCpack**, **RJags**, **RBugs**, RStan
* Big data: data.table, parallel computing
* Mapping
* Web services: **twitteR**, **MTurkR**
