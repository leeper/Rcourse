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
  * Commenting ("Advice to help your future self"): # and `if(FALSE){}`
* working directory
* Getting help
* interfaces (RStudio, Rcmdr, rite, Revolution Analytics; etc.)

## The R language
* [Basic math](Scripts/basicmath.r)
* [Variables and assignment](Scripts/variables.r)
* Data structures:
  * [Vectors](Scripts/vectors.r) and [Vector indexing](Scripts/vectorindexing.r)
  * [Matrices](Scripts/matrices.r)
  * [Lists](Scripts/lists.r)
  * [Dataframes](Scripts/dataframes.r)
* Object [classes](Scripts/classes.r), plus more information on:
 * [Factors](Scripts/factors.r)
 * [Logicals](Scripts/logicals.r)

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
* handling missing data
  * Global: `na.omit`
  * Command-specific options: `na.rm=...`
* recoding
  * positional recoding
    * `[` for vectors, matrices, dataframes, and lists
  * logical recoding
    * Introduce more operators: `==`, `<`, `>`, `<=`, `>=`, `!`
	* Difference between vectorized logicals (e.g. with `ifelse`) and `if`-`else` constructions
  * `recode` from `library(car)`
  * scale construction (additive, multiplicative, logical)
    * vector addition with `+`
	* `rowSums` and `colSums`
	* `rowMeans` and `colMeans`
  * Note also other more advanced tools: `factanal`, `princomp`, `library(psych)`, and `library(IRToys)`
* `subset` and `sample` and `order

Solve Problem Set

## Data summaries
* `summary`
* `IQR`, `fivenum`, `median`, `quantile`
* `table`, `xtabs` and `ftable`, `prop.table`
* `mean`, `sd`, `var`
* `cor`

Solve Problem Set

## Plotting as data summary
* `hist`
* `barplot`
* `plot` for scatter and line plots
* add ons: `lines`, `points`, `abline`, `text`, `legend`
* saving plots (`pdf`, `jpeg`, `png`, `tiff`, `bmp`)
### Note: ggplot2

Solve Problem Set

## Statistics
* `chisq.test`, `t.test`, `cor.test`, `prop.test`
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
* bivariate OLS
* `summary`
* model output (coef, etc.)
* `predict`
* model formulae
  * interactions
  * factors versus continuous entry of variables continuous
  * intercepts

Solve Problem Set

## Regression plotting
* Default plots from `plot(lm)`
* residual plots
* scatterplots
* coefs and standard errors

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
* Bayes: MCMCpack, RJags, RBugs, RStan
* Big data: data.table, parallel computing
