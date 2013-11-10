#' # Loading Data #
#'
#' In order to use R for data analysis, we need to get our data into R. Unfortunately, because R lacks a graphical user interface, loading data is not particularly intuitive for those used to working with other statistical software. This tutorial explains how to load data into R as a dataframe object.
#'
#' ## General Notes ##
#' As a preliminary note, one of the things about R that causes a fair amount of confusion is that R reads character data, by default, as factor. In other words, when your data contain alphanumeric character strings (e.g., names of countries, free response survey questions), R will read those data in as factor variables rather than character variables. This can be changed when reading in data using almost any of the following techniques by setting a `stringsAsFactors=FALSE` argument.
#'
#' A second point of difficulty for beginners to R is that R offers no obvious visual way to load data into R. Lacking a full graphical user interface, there is no "open" button to read in a dataset. The closest thing to this is the `file.choose` function. If you don't know the name or location of a file you want to load, you can use `file.choose()` to open a dialog window that will let you select a file. The response, however, is just a character string containing the name and full path of the file. No action is taken with regard to that file. If, for example, you want to load a comma-separated value file (described below), you could make a call like the following:
# read.csv(file.choose())
#' This will first open the file choose dialog window and, when you select a file, R will then process that file with `read.csv` and return a dataframe.
#' While `file.choose` is a convenient function for interactively working with R. It is generally better to manually write filenames into your code to maximize reproducibility.
#'
#'
#' ## Built-in Data ##
#' One of the neat little features of R is that it comes with some built-in datasets, and many add-on packages supply additional datasets to demonstrate their functionality. We can access these datasets with the `data()` function. Here we'll just print the first few datasets:
head(data()$results)
#' Datasets in the **dataset** package are pre-loaded with R and can simply be called by name from the R console. For example, we can see the "Monthly Airline Passenger Numbers 1949-1960" dataset by simply calling:
AirPassengers
#' To obtain detailed information about the datasets, you can just access the dataset documention: `? AirPassengers`.
#' We generally want to work with our own data, however, rather than some arbitrary dataset, so we'll have to load data into R.
#'
#' ## Manual data entry ##
#' Because a dataframe is just a collection of data vectors, we can always enter data by hand into the R console. For example, let's say we have two variables (`height` and `weight`) measured on each of six observations. We can enter these simply by typing them into the console and combining them into a dataframe, like:
height <- c(165,170,163,182,175,190)
weight <- c(45,60,70,80,63,72)
mydf <- cbind.data.frame(height,weight)
#' We can then call our dataframe by name:
mydf
#' R also provides a function called `scan` that allows us to type data into a special prompt. For example, we might want to read in six values of gender for our observations above and we could do that by typing `mydf$gender <- scan(n=6, what="numeric")` and entering the six values, one per line when prompted.
#' But entering data manually in this fashion is inefficient and doesn't make sense if we already have data saved in an external file.
#'
#'
#' ## Loading tabular data ##
#' The easiest data to load into R comes in tabular file formats, like comma-separated value (CSV) or tab-separated value (TSV) files. These can easily be created using a spreadsheet editor (like Microsoft Excel), a text editor (like Notepad), or exported from many other computer programs (including all statistical packages).
#'
#' ### `read.table` and its variants ###
#' The general function for reading these kinds of data is called `read.table`. Two other functions, `read.csv` and `read.delim`, provide convenient wrappers for reading CSV and TSV files, respectively. (Note: `read.csv2` and `read.delim2` provide slightly different wrappers designed for reading data that uses a semicolon rather than comma separator and a comma rather than a period as the decimal point.)
#' Reading in data that is in CSV format is easy. For example, let's read in the following file, which contains some data about patient admissions for five patients:
#'
#' ```
#' patient,dob,entry,discharge,fee,sex
#' 001,10/21/1946,12/12/2004,12/14/2004,8000,1
#' 002,05/01/1980,07/08/2004,08/08/2004,12000,2
#' 003,01/01/1960,01/01/2004,01/04/2004,9000,2
#' 004,06/23/1998,11/11/2004,12/25/2004,15123,1
#' ```
#'
#' We can read these data in from from the console by copying and pasting them into a command like the following:
mydf <- read.csv(text="
patient,dob,entry,discharge,fee,sex
001,10/21/1946,12/12/2004,12/14/2004,8000,1
002,05/01/1980,07/08/2004,08/08/2004,12000,2
003,01/01/1960,01/01/2004,01/04/2004,9000,2
004,06/23/1998,11/11/2004,12/25/2004,15123,1")
mydf
#' Or, we can read them from the local file directly:
mydf <- read.csv('../Data/patient.csv')
#' Reading them in either way will produce the exact same dataframe. If the data were tab- or semicolon-separated, the call would be exactly the same except for the use of `read.delim` and `read.csv2`, respectively.
#'
#'
#' ### `scan` and `readLines` ###
#' Occasionally, we need to read in data as a vector of character strings rather than as delimited data to make a dataframe. For example, we might have a file that contains textual data (e.g., from a news story) and we want to read in each word or each line of the file as a separate element of a vector in order to perform some kind of text processing on it.
#' To do this kind of analysis we can use one of two functions. The `scan` function we used above to manually enter data at the console can also be used to read data in from a file, as can another function called `readLines`.
#' We can see how the two functions work by first writing some miscellaneous text to a file (using `cat`) and then reading in that content:
cat("TITLE", "A first line of text", "A second line of text", "The last line of text", file = "ex.data", sep = "\n")
#' We can use `scan` to read in the data as a vector of words:
scan("ex.data", what='character')
#' The `scan` function accepts additional arguments such `n` to specify the number of lines to read from the file and `sep` to specify how to divide the file into separate entries in the resulting vector:
scan("ex.data", what='character', sep='\n')
scan("ex.data", what='character', n=1, sep='\n')
#' We can do the same thing with `readLines`, which assumes that we want to read each line as a complete string rather than separating the file contents in some way:
readLines("ex.data")
#' It also accepts an `n` argument:
readLines("ex.data", n=2)
#' Let's delete the file we created just to cleanup:
unlink("ex.data") # tidy up
#'
#'
#' ## Reading .RData data ##
#' R has its own fill format called .RData that can be used to store data for use in R. It is fairly rare to encounter data in this format, but reading it into R is - as one might expect - very easy. You simply need to call `load('thefile.RData')` and the objects stored in the file will be loaded into memory in R.
#' One context in which you might use an .RData file is when saving your R workspace. When you quite R (using `q()`), R asks if you want to save your workspace. If you select "yes", R stores all of the objects currently in memory to a .RData file. This file can then be `load`ed in a subsequent R session to pick up quite literally exactly where you left off when you saved the file.
#'
#'
#' ## Loading "Foreign" data ##
#' Because many people use statistical packages like SAS, SPSS, and Stata for statistical analysis, much of the data available in the world is saved in proprietary file formats created and owned by the the companies that publish that software. This is bad because those data formats are deprecated (i.e., made irrelevant) quite often (e.g., when Stata upgraded to version 11, it introduced a new file format and its older file formats were no longer compatible with the newest version of the software). This creates problems for reproducibility because not everyone has access to Stata (or to SPSS or SAS) and storing data in these formats makes it harder to share data and ties data to specific software owned by specific companies.
#' Editorializing aside, R can import data from a variety of proprietary file formats. Doing so requires one of the recommended add-on packages called **foreign**. Let's load it here:
library(foreign)
#' The **foreign** package can be used to import data from a variety of proprietary formats, including Stata .dta formats (using the `read.dta` function), Octave or Matlab .mat formats (using `read.octave), SPSS .sav formats (using `read.spss`), SAS permanent .sas7bdat formats (using `read.ssd`) and SAS XPORT .stx or .xpt formats (using `read.xport`), Systat .syd formats (using `read.systat`), and Minitab .tmp formats (using `read.mtp`).
#' Note: The **foreign** package sometimes has trouble with SPSS formats, but these files can also be opened with the `spss.get` function from the **Hmisc** package or one of several functions from the **memisc** package (`spss.fixed.file`, `spss.portable.file`, and `spss.system.file`).
#'
#' If you ever encounter trouble importing foreign data formats into R, a good option is to use a piece of software called [StatTransfer](http://www.stattransfer.com/), which can convert between dozens of different file formats. Using StatTransfer to convert a file format into a CSV or R .RData format will essentially guarantee that it is readable by R.
#'
#'
#' ## Reading Excel files ##
#' Sometimes we need to read data in from Excel. In almost every situation, it is easiest to use Excel to convert this kind of file into a comma-separated CSV file first and then load it into R using `read.csv`. That said, there are several packages designed to read Excel foramts directly, but all have disadvantages.
#' * [**XLConnect**](http://cran.r-project.org/web/packages/XLConnect/index.html) can read a variety of Excel formats, but requires you to have Java installed on your computer.
#' * [**xlsx**](http://cran.r-project.org/web/packages/xlsx/index.html) also uses a Java library
#' * [**gdata**](http://cran.r-project.org/web/packages/gdata/index.html), in addition to many other things, includes a `read.xls` function that can read Excel .xls files, but requires having Perl installed on your machine
#' * [**RDCOMClient**](http://www.omegahat.org/RDCOMClient/) can also read Excel files and interact with them dynamically, but is also not available on CRAN.
#' * [**RExcelXML**](http://www.omegahat.org/RExcelXML/) can read post-2007 era Excel files, but is also not on CRAN.
#' * [**xlsReadWrite**](http://www.swissr.org/software/xlsreadwrite) requires propriety software to do the file conversion and therefore isn't available on CRAN
#' Thus, while there are many options for reading Excel files, none has become the recommended method for loading these files. **XLConnect** perhaps provides the preferred method, but - reiterating the above point - it is often just easier to convert an Excel file to CSV rather than trying to load the Excel file directly.
#'
#'
#' ## Notes on other data situations ##
#' Sometimes one encounters data in formats that are neither traditional, text-based tabular formats (like CSV or TSV) or proprietary statistical formats (like .dta, .sav, etc.). For example, you sometimes encounter data that is recorded in an XML markup format or that is saved in "fixed-width format", and so forth. So long as the data is human-readable (i.e., text), you will be able to find or write R code to deal with these files and convert them to an R dataframe. Depending on the file format, this may be time consuming, but everything is possible.
#'
#' XML files can easily be read using the **XML** package. Indeed, its functions `xmlToDataFrame` and `xmlToList` easily convert almost any well-formed XML document into a dataframe or list, respectively.
#'
#' Fixed-width file formats are some of the hardest file formats to deal with. These files, typically built during the 20th Century, are digitized versions of data that was originally stored on punch cards. For example, much of the pre-2000 public opinion data archived at the Roper Center for Public Opinion Research's iPoll databank is stored in fixed width format. These formats store data as rows of numbers without variable names, value delimiters (like the comma or tab), and require a detailed codebook to translate them into human- or computer-readable data.
#' For example, the following 14 lines represent the first two records of a public opinion data file from 1998:
#'
#' ```
#' 000003204042898                    248 14816722  1124 13122292122224442 2 522  1
#' 0000032222222444444444444444144444444424424                                    2
#' 000003          2     1    1    2    312922 3112422222121222          42115555 3
#' 00000355554115           553722211212221122222222352   42       4567   4567    4
#' 000003108 41 52 612211                    1                229                 5
#' 000003                                                                         6
#' 000003    20                                                01.900190 0198     7
#' 000012212042898                    248 14828523  1113 1312212111111411142 5213 1
#' 0000122112221111141244412414114224444444144                                    2
#' 000012          1     2    1    2    11212213123112232322113          31213335 3
#' 00001255333115           666722222222221122222226642   72       4567   4567    4
#' 000012101261 511112411                    1                212                 5
#' 000012                                                                         6
#' 000012    32                                                01.630163 0170     7
#' ```
#'
#' Clearly, these data are not easily interpretable despite the fact that there is some obvious pattern to the data. As long as we have a file indicating what each number means, we can use the `read.fwf` function (from base R) to translate this file into a dataframe. The code is tedious, so there isn't space to demonstrate it here, but know that it is possible.
#'