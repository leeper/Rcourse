---
layout: default
---

# Introduction to R

Created 2013-08-12

Last updated 2013-09-19


## Pre-Session (30 minutes)
* Installing R

## Introductions (20 minutes)
* Names
* Backgrounds
* Typical research software and workflow
* Likes and wishes with current software and workflow
* Problems you had learning your current software

## Introduction to R (10 minutes)
* Goals for this course
* The system/history/principles
* Why R?
* Principles of reproducible scientific workflow
  * Software available in perpetuity
  * Constructing and sharing data and code
  * Simplifying the move from analysis to publication
* installing packages
* Why scripting?
  * Moving from console to scripting
  * Analogue to do-files
  * Reproducibility
  * Commenting ("Advice to help your future self"), see [Comments](Scripts/comments.r)
* working directory
* Getting help
* interfaces (RStudio, Rcmdr, rite, Revolution Analytics; etc.)

## The R language
* [Basic math](Scripts/basicmath.r)
* [Variables and assignment](Scripts/variables.r)
* [Matrix algebra](Scripts/matrixalgebra.r)
* Data structures:
  * [Vectors](Scripts/vectors.r) and [Vector indexing](Scripts/vectorindexing.r)
  * [Matrices](Scripts/matrices.r)
  * [Lists](Scripts/lists.r)
  * [Dataframes](Scripts/dataframes.r)
* Object [classes](Scripts/classes.r), plus more information on:
  * [Factors](Scripts/factors.r)
  * [Logicals](Scripts/logicals.r)
* [Missing values](Scripts/NA.r)

Solve Problem Set

## Data as dataframes
* Reading in data
  * `read.csv`, `read.table`, `scan`
  * `load`
  * `library(foreign)`: `read.spss`, `read.dta`, etc.
  * Rarer cases: `readLines` and `read.fwf`
* `fix`
* `names` and `str`
* `head` and `tail`
* `write.csv`

Solve Problem Set

## Data processing
* [Recoding vectors](Scripts/recoding.r)
* scale construction (additive, multiplicative, logical)
  * vector addition with `+`
    * `rowSums` and `colSums`
    * `rowMeans` and `colMeans`
    * See also: [Matrix algebra](Scripts/matrixalgebra.r)
  * Note also other more advanced tools: `factanal`, `princomp`, `library(psych)`, and `library(IRToys)`
* handling missing data
  * Global: `na.omit`
  * Command-specific options: `na.rm=...`
* `subset` and `sample` and `order

Solve Problem Set

## Data summaries
* [Univariate data summaries](Scripts/univariate.r) (including `summary`)
* [Data tables and crosstables](Scripts/tables.r)
* [Correlations and partial correlations](Scripts/correlation.r)
* Printing numerics

Solve Problem Set

## Plotting as data summary
* [Data summary plots](Scripts/summaryplots.r)
  * [Rugs: Marginal distributions for scatterplots](Scripts/rugs.r)
  * [Local regression (LOWESS/LOESS) for scatterplots](Scripts/localregression.r) TODO
  * [`jitter` for scatterplots of categorical data](Scripts/jitter.r) TODO
  * `plot` for [Line plots](Scripts/lineplots.r) TODO
  * add ons: `lines`, `segments` (for error bars), `polygon`, `points`, `abline`, `text`, `legend`
* [Graphical parameters](Scripts/graphicalparameters.r) TODO
* [Plotting Colors](Scripts/plotcolors.r) TODO
  * `gray`, `rgb`, `rainbow`, `heat.colors`
* [Saving plots](Scripts/savingplots.r) TODO
  * `pdf`, `jpeg`, `png`, `tiff`, `bmp`
* [Plotting functions with `curve`](Scripts/curve.r) TODO
* Note: **ggplot2**, **lattice**, and **grid**

Solve Problem Set

## Statistics
* `chisq.test`, `t.test`, `cor.test`, `prop.test`, `binom.test`
* `aov`
* other significance tests (nonparametrics and library(coin))
  * `t.test` versus `wilcox_test` versus `coin::independence_test`
  * `aov` versus `kruskal.test`
  * Variance tests: `var.test`, `fligner.test`, `bartlett.test`
* `by`
* Distributions
  * Normal: `rnorm`, `pnorm`, `qnorm`, and `dnorm`
  * Also look at uniform, binomial, and t distributions

Solve Problem Set

## Regression
* [bivariate OLS](Scripts/olsbivariate.r) TODO
* multivariate OLS
* `summary`
* model output (coef, etc.)
* Heteroskedasticity-consistent SEs with `sandwich::vcovHC`
* [Standardized coefficients](Scripts/standardizedcoefficients.r)
* [Regression in matrix form](Scripts/matrixols.r)
* Model predicted values (`predict`)
* model formulae
  * interactions
  * factors versus continuous entry of variables continuous
  * intercepts

Solve Problem Set

## Regression plotting
* [Plots for regression diagnostics](Scripts/olsplots.r)
  * Default plots from `plot(lm)`
  * Residual plots
  * Scatterplots
* [Plots for regression summaries](Scripts/olsresultplots.r)
  * Plotting slopes and regression results
* [Plots for linear interaction effects](Scripts/olsinteractionplots.r)
  * Predicted outcomes
  * Marginal effects

Solve Problem Set

## GLM
* models, again
* Revisit distributions and link functions
* prediction
* plotting data
* plotting predicted probabilities

Solve Problem Set

## Reproducible research
* Using `source`
* comments, again
* knitr `stitch`
* Integration with LaTeX reports
  * `knit`
  * `xtable`
* Presentations with beamer
* Web publishing with Rmarkdown

## Briefly on advanced topics
* loops
* user-defined functions
* apply family
* scope/environments
* bootstrapping/permutations
* time-series
* multi-level models/panel data
* Bayes: **MCMCpack**, **RJags**, **RBugs**, RStan
* Big data: data.table, parallel computing
