# Course materials for teaching R #

This repository will hold materials for teaching R (principally to beginners), which can be found [here](http://www.thomasleeper.com/Rcourse).

The following code (run from the root directory of this repository) will convert all of the enclosed scripts to Rmarkdown and to HTML, allowing them to be viewed directly in a web browser:

```
setwd('./Scripts')
lapply(dir(pattern='.r$'), knitr::spin)
```

## Why produce original materials? ##

There is an ever increasing library of online tutorials, books, and other resources for learning R. So why create something new? Unlike the books or other tutorials, the idea behind this course is to create an ever-increasing library of short resources that allow students to quickly grasp one small facet of R programming. The course is therefore structured around small R scripts, which students can read and run on their own, in order to both learn R and simultaneously observe good reproducible research practice.

And, building on theories of student learning, the course will supply both short lectures (as slides) and problem sets that enable students to follow along when the scripts are confusing and to directly test their learning in R.

By breaking up learning R into a large number of small pieces, the materials here will become a modular set of tools that can be used by courses of different sizes, levels, lengths, and objectives without having to change to a different text or combine parts of multiple texts to teach the intended material.


## Why GitHub? ##

Read more about why this course is on GitHub [here](fork.md).
