---
layout: default
title: Home
---

# Course materials for teaching R #

This site contains course materials for teaching and learning R. The initial version of this course is a one-day seminar at Aarhus University on November 14, 2013 for faculty and PhD students of the Department of Political Science and Government.s

There is an ever increasing library of online tutorials, books, and other resources for learning R. So why create something new? Unlike the books or other tutorials, the idea behind this course is to create an ever-increasing library of short resources that allow students to quickly grasp one small facet of R programming. The course is therefore structured around small R scripts, which students can read and run on their own, in order to both learn R and simultaneously observe good reproducible research practice.

By breaking up learning R into a large number of small pieces, the materials here will become a modular set of tools that can be used by courses of different sizes, levels, lengths, and objectives without having to change to a different text or combine parts of multiple texts to teach the intended material.


---
## Course Outline ##

I've posted a [Course Outline](CourseOutline.html) that describes the course outline and schedule. It also lists the problem sets that we will be working on during the course. 

Slides for each part of the course are posted on the [Course Outline](CourseOutline.html), as well.


---
## Tutorial Scripts ##
The [scripts page](Scripts.html) lists the various tutorial scripts that I've produced for the course.

These scripts are fully executable, meaning they can be copied into the R console, run through a script editor (like [rite](https://github.com/leeper/rite)) or IDE (like [RStudio](http://www.rstudio.com)), or executed on the command line using [RScript](http://stat.ethz.ch/R-manual/R-devel/library/utils/html/Rscript.html).

They are also written in roxygen-style so that they can be directly converted to Rmarkdown and HTML using [`knitr::spin`](http://yihui.name/knitr/demo/stitch/).

Specifically, the following code (run from the root directory of this repository, which you can [download as a .zip](https://github.com/leeper/Rcourse/archive/gh-pages.zip)) will convert all of the scripts to Rmarkdown and to HTML, allowing them to be viewed directly in a web browser:

```
setwd('./Scripts');
lapply(dir(pattern='.r$'), knitr::spin)
```

These scripts will be complemented by slides for short lectures, to be added soon.

After working through a lecture and set of related scripts, course participants can also complete short problem sets to test their learning. These will be added soon, too.

---
## R Resources ##
I've posted an up-to-date list of [resources](Resources.html) that will be useful for getting started with and becoming more sophisticated with R.


---
## Why GitHub? ##

Read more about why this course is on GitHub [here](fork.html). You can access [the GitHub repository here](https://github.com/leeper/Rcourse).

