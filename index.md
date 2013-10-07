---
layout: default
title: R Course
subtitle: Teaching materials for R
---

# Course materials for teaching R #

This repository will hold materials for teaching R (principally to beginners). I'm teaching an initial version of this course as a one-day seminar at Aarhus University on November 14, 2013 for faculty and PhD students of the Department of Political Science and Government. I'm gradually adding material as the course approaches.

## Contents ##

Currently you'll find an up-to-date list of [resources](Resources.html) that will be useful for getting started with and becoming more sophisticated with R.

I've also been adding links to scripts, as I write, to the [Course Outline](CourseOutline.html). These scripts are fully executable, meaning they can be copied into the R console, run through a script editor (like [rite](https://github.com/leeper/rite)) or IDE (like [RStudio](http://www.rstudio.com)), or executed on the command line using [RScript](http://stat.ethz.ch/R-manual/R-devel/library/utils/html/Rscript.html). They are also written in roxygen-style so that they can be directly converted to Rmarkdown and HTML using [`knitr::spin`](http://yihui.name/knitr/demo/stitch/).

Specifically, the following code (run from the root directory of this repository, which you can [download as a .zip](https://github.com/leeper/Rcourse/archive/gh-pages.zip)) will convert all of the scripts to Rmarkdown and to HTML, allowing them to be viewed directly in a web browser:

```
setwd('./Scripts')
lapply(dir(pattern='.r'), knitr::spin)
```

These scripts will be complemented by slides for short lectures, to be added soon.

After working through a lecture and set of related scripts, course participants can also complete short problem sets to test their learning. These will be added soon, too.

## Why GitHub? ##

Read more about why this course is on GitHub [here](fork.html). You can access [the GitHub repository here](https://github.com/leeper/Rcourse).

There is an ever increasing library of online tutorials, books, and other resources for learning R. So why create something new? Unlike the books or other tutorials, the idea behind this course is to create an ever-increasing library of short resources that allow students to quickly grasp one small facet of R programming. The course is therefore structured around small R scripts, which students can read and run on their own, in order to both learn R and simultaneously observe good reproducible research practice.

By breaking up learning R into a large number of small pieces, the materials here will become a modular set of tools that can be used by courses of different sizes, levels, lengths, and objectives without having to change to a different text or combine parts of multiple texts to teach the intended material.

