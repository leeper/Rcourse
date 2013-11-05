---
layout: default
title: Resources
---

# R Resources #

This page provides some resources for getting and using R. There are lots of these kinds of lists on the internet, so this one will show my own personal biases in terms of what is important. I welcome [pull requests](https://github.com/leeper/Rcourse/pulls) for any additions/deletions/edits.

## Get R ##
* You can get R at [CRAN (the Comprehensive R Archive Network)](http://cran.r-project.org/) for any of the usual operating systems

---
## Manuals and Introductions ##
CRAN provides [a number of manuals and other resources for R](http://cran.r-project.org/manuals.html), including:
* [PDF](http://cran.r-project.org/doc/manuals/R-intro.pdf)
[HTML](http://cran.r-project.org/doc/manuals/R-intro.html) _An Introduction to R_, a basic introduction for beginners.
* [PDF](http://cran.r-project.org/doc/manuals/R-lang.pdf) [HTML](http://cran.r-project.org/doc/manuals/R-lang.html) _The R Language Definition_, a more technical discussion of the R language itself.
* [PDF](http://cran.r-project.org/doc/manuals/R-exts.pdf) [HTML](http://cran.r-project.org/doc/manuals/R-exts.html) _Writing R Extensions_, a development guide for R.
* [PDF](http://cran.r-project.org/doc/manuals/R-data.pdf) [HTML](http://cran.r-project.org/doc/manuals/R-data.html) _R Data Import/Export_, a data import and export guide.
* [PDF](http://cran.r-project.org/doc/manuals/R-admin.pdf) [HTML](http://cran.r-project.org/doc/manuals/R-admin.html) _R Installation_, an installation guide (from R source code).
* [PDF](http://cran.r-project.org/doc/manuals/R-ints.pdf) [HTML](http://cran.r-project.org/doc/manuals/R-ints.html) _R Internals_, internal structures and coding guidelines.
* [Contributed Documentation](http://cran.r-project.org/other-docs.html), from a number of authors
  * One such resource is [a Danish-language introduction](http://cran.r-project.org/doc/contrib/Larsen+Sestof-noter-om-R.pdf) from Morten Larsen and Peter Sestoft of Københavns Universitet
  * The [Reference Card](http://cran.r-project.org/doc/contrib/refcard.pdf) and [Reference Card v2](http://cran.r-project.org/doc/contrib/Baggott-refcard-v2.pdf) are helpful for quickly finding functions and operators
* [Task Views](http://cran.r-project.org/web/views/) provide summaries of useful R packages by subject area

Other non-CRAN resources include:
* [PDF](http://lib.stat.cmu.edu/S/Spoetry/Tutor/R_inferno.pdf) *The R Inferno* by Patrick Burns provides some insight into common challenges beginners (and advanced users) face with R.
* [Quick-R](http://www.statmethods.net/) provides some simple tutorials about an array of methods.
* [R-bloggers](http://www.r-bloggers.com/) aggregates blog posts about R from all over the web.
* I've written [a short R introduction](/Intro2R/Intro2R.pdf) for undergraduates that may be helpful.
* [Teppei Yamamoto](http://web.mit.edu/teppei/www/teaching.html) has some simple handouts for Princeton's "Statistical Software Camp".
* Christopher Green's somewhat old [R Primer](http://www.stat.washington.edu/cggreen/rprimer/) provides still useful information.

---
## R Books ##
You can always find the latest R books [on Amazon](http://www.amazon.com/s/ref=sr_nr_n_1?rh=n%3A271582011%2Ck%3Ar&keywords=r&ie=UTF8&qid=1379429658&rnid=2941120011) or wherever, but a couple that are useful (depending on your background):
* [R for SAS and SPSS Users](http://books.google.dk/books?id=9kMy0CBTegYC&dq=r+for+stata+users&source=gbs_navlinks_s)
* [R for Stata Users](http://books.google.dk/books?id=Altdh0pTQ2oC&dq=r+for+stata+users&source=gbs_navlinks_s)

The R Project also supplies a complete (?) list of [R-related books](http://www.r-project.org/doc/bib/R-books.html).

For getting started with the reproducible research process, I might recommend:
* [Dynamic Documents with R and knitr](http://books.google.dk/books?id=QZwAAAAAQBAJ&dq=yihui+xie&source=gbs_navlinks_s)
* [Reproducible Research with R and RStudio](http://books.google.dk/books?id=u-nuzKGvoZwC&dq=reproducible+research+with+r&source=gbs_navlinks_s)

---
## Text editors for R ##
The following editors provide basic features like R syntax highlighting and some (like RStudio) provide more advanced features for R scripting and package development.
* [ESS (Emacs Speaks Statistics)](http://ess.r-project.org/) - package for [Emacs](https://www.gnu.org/software/emacs/)
* [RStudio](http://www.rstudio.com/ide/) - a very powerful, R-specific Integrated Development Environment
* [StatET](http://www.walware.de/goto/statet) - plugin for the [Eclipse](http://www.eclipse.org/eclipse/) IDE
* [Revolution-R](http://www.revolutionanalytics.com/products/revolution-r.php) - a commercial version of R with some "big data" enhancements
* [Tinn-R](http://www.sciviews.org/Tinn-R/) - R-specific code editor, especially for Windows
* [Sciviews-K](http://www.sciviews.org/SciViews-K) - Extension for the [Komodo](http://www.activestate.com/komodo-ide)
* [NppToR](http://sourceforge.net/projects/npptor/) - plugin for [Notepad++](http://notepad-plus-plus.org/) (my preferred text editor on Windows)
* [WinEdt](http://www.winedt.com/)
* [JGR](http://rforge.net/JGR/)
* [Deducer](http://www.deducer.org/pmwiki/pmwiki.php)
* [Vim-R](http://www.vim.org/scripts/script.php?script_id=2628) - a plugin for [Vim](http://en.wikipedia.org/wiki/Vim_(text_editor)

Internal to R there are also several options, including my own package [*rite*](http://cran.r-project.org/web/packages/rite/), which provides a basic script editor and [Rcmdr](http://socserv.mcmaster.ca/jfox/Misc/Rcmdr/), which provides a heavier but more fully featured GUI.


---
## Resources for getting help ##
* From within R, `help` and `?` provide access to help files.
* [R mailing lists](http://www.r-project.org/mail.html), especially the [R-help list](https://stat.ethz.ch/mailman/listinfo/r-help)
* [R FAQ](http://cran.r-project.org/doc/FAQ/R-FAQ.html), the official list of FAQs on CRAN
* [StackOverflow](http://stackoverflow.com/questions/tagged/r), a question/answer site with a large R community
  * [This question about producing reproducible examples](http://stackoverflow.com/questions/5963269/how-to-make-a-great-r-reproducible-example) is an especially helpful read for learning *how to ask* good questions about R
* [R Seek](http://www.rseek.org/) is a Google-powered search engine for R resources
* And, ultimately, Google is your friend. I find that queries of the form "R CRAN [insert issue here]" generally give the best results rather than searching just "R [insert issue here]" given that "R" is [one of the ten most frequent letters in the English language](http://en.wikipedia.org/wiki/Letter_frequency#Relative_frequencies_of_letters_in_the_English_language) and many other European languages.


---
## R Packages ##
There are literally [thousands of R packages on CRAN](http://cran.r-project.org/web/packages/) and maybe dozens or hundreds more floating around the internet on places like [GitHub](https://github.com/), [R-Forge](http://r-forge.r-project.org/), [RForge.net](http://www.rforge.net/), and [OmegaHat](http://www.omegahat.org/). It can sometimes be hard to find the right packages but Googling and use of the [Task Views](http://cran.r-project.org/web/views/) usually get you what you need. That said, beginners, in particular, may find John Fox's [*car*](http://cran.r-project.org/web/packages/car/index.html) package helpful for doing a bunch of regression-type analyses beyond what's provided in base R. Gary King (et al.)'s [*Zelig*](http://gking.harvard.edu/zelig) software also provides a somewhat more consistent interface than base R to a bunch of R modelling functions (especially those written by King and coauthors, not surpisingly). *Zelig* also provides the functionality of [*Clarify*](http://gking.harvard.edu/clarify), familiar to many Stata users for its predicted probability functionality.


---
## R Graphics ##
R basically offers three completely incompatible graphics approaches.
* Base R, which encompasses all of the graphics functionality provided with the default R packages and add-ons to those approaches
* [Lattice](http://cran.r-project.org/web/packages/lattice/index.html), a different approach with a bunch of add-on packages that makes graphs some people consider attractive
* [ggplot2](http://ggplot2.org/), a really huge graphics library with an even larger set of add-ons. *ggplot2* undergoes [constant development](https://github.com/hadley/ggplot2), has a huge community of users, is the basis for several books, and generally makes graphs that many people consider attractive using a consistent design "grammar" that requires you to fundamentally rethink the relationship between data and visualization.

The choice among these alternatives approaches depends largely on what you want to do and how you think about graphics. I am a dedicated base R graphics user, but I occasionally see advantages to *ggplot2* (especially in the area of GIS).

---
## Some more advanced resources ##
* CRAN's [Writing R Extensions](http://cran.r-project.org/doc/manuals/r-release/R-exts.pdf), for package development
* Friedrich Leisch's [Creating R Packages: A Tutorial](http://cran.r-project.org/doc/contrib/Leisch-CreatingPackages.pdf)
* CRAN's [R Internals](http://cran.r-project.org/doc/manuals/r-release/R-ints.pdf), describing the underlying R software
* [Hadley Wickham](http://had.co.nz/)'s [Advanced R Programming Wiki](http://adv-r.had.co.nz/)
* [The R Journal](http://journal.r-project.org/) provides a peer-reviewed outlet for R-related content, especially introductions to new packages
* [crantastic!](http://crantastic.org/) and [CRANberries](http://dirk.eddelbuettel.com/cranberries/) provide some tools for tracking package releases on CRAN
