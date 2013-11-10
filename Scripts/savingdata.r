#' # Saving R Data #
#'
#' We frequently need to save our data after we have worked on it for some time (e.g., because we've created scaled or deleted variables, created a subset of our original data, modified the data in a time- or processor-intensive way, or simply need to share a subset of the data). In most statistical packages, this is done automatically: those packages open a file and "destructively" make changes to the original file. This can be convenient, but it is also problematic. If I change a file and don't save the original, my work is no longer reproducible from the original file. It essentially builds a step into the scientific workflow that is not explicitly recorded.
#' R does things differently. When opening a data file in R, the data are read into memory and the link between those data in memory and the original file is severed. Changes made to the data are kept only in R and they are lost if R is closed without the data being saved. This is usually fine because good workflow involves writing scripts that work from the original data, make any necessary changes, and then produce output. But, for the reasons stated above, we might want to save our working data for use later on. R provides at least four ways to do this.
#' Note: All of the methods overwrite the system file by default. This means that writing a file over an existing file is "destructive," so it's a good idea to make sure that you're not overwriting a file by checking to make sure your filename isn't already in use using `list.files()`. By default, the file is written to your working directory (`getwd()`) but can be written elsewhere if you supply a file path rather than name. 
#'
#' All of these methods work with an R dataframe, so we'll create a simple one just for the sake of demonstration:
set.seed(1)
mydf <- data.frame(x=rnorm(100), y=rnorm(100), z=rnorm(100))
#'
#' "" save ##
#' The most flexible way to save data objects from R uses the `save` function. By default, `save` writes an R object (or multiple R objects) to an R-readable binary file that can be opened using `load`. Because `save` can store multiple objects (including one's entire current workspace), it provides a very flexible way to "pick up where you left off." For example, using `save.image('myworkspace.RData')`, you could save everything about your current R workspace, and then `load('myworkspace.RData')` later and be exactly where you were before.
#' But it is also a convenient way to write data to a file that you plan to use again in R. Because it saves R objects "as-is," there's no need to worry about problems reading in the data or needing to change structure or variable names because the file is saved (and will load) exactly as it looks in R. The dataframe will even have the same name (i.e., in our example, the loaded object will be caleld `mydf`). The .RData file format is also very space-saving, thus taking up less room than a comparable comma-separated variable file containing the same data.
#' To write our dataframe using `save`, we simply supply the name of the dataframe and the destination file:
save(mydf,file='saveddf.RData')
#' Note that the file name is not important (so long as it does not overwrite another file in your working directory). If you load the file using `load`, the R object `mydf` will appear in your workspace.
#' Let's remove the file just to not leave a mess:
unlink('saveddf.RData')
#'
#' ## dput (and dget) ##
#' Sometimes we want to be able to write our data in a way that makes it exactly reproducible (like `save`), but we also want to be able to read the file. Because `save` creates a binary file, we can only open the file in R (or another piece of software that reads .RData files). If we want, for example, to be able to look at or change the file in a text editor, we need it in another format. One R-specific solution for this is `dput`.
#' The `dput` function saves data as an R expression. This means that the resulting file can actually be copied and pasted into the R console. This is especially helpful if you want to share (part of) your data with someone else. Indeed, it is rquired that when you ask data-related questions on [StackOverflow](http://stackoverflow.com/questions/5963269/how-to-make-a-great-r-reproducible-example), that you supply your data using `dput` to make it easy for people to help you.
#' We can also simply write the output of `dput` to the console to see what it looks like. Let's try that before writing it to a file:
dput(mydf)
#' As you can see, output is a complicated R expression (using the `structure` function), which includes all of the data values, the variable names, row names, and the class of the object. If you were to copy and paste this output into a new R session, you would have the exact same dataframe as the one we created here.
#' We can write this to a file (with any extension) by specifying a `file` argument:
dput(mydf, 'saveddf.txt')
#' I would tend to use the .txt (text file) extension, so that it will be easily openable in any text editor, but you can use any extension.
#' Note: Unlike `save` and `load`, which store an R object and then restore it using the save name, `dput` does not store the name of the R object. So, if we want to load the dataframe again (using `dget`), we need to store the dataframe as a variable:
mydf2 <- dget('saveddf.txt')
#' Additionally, and again unlike `save`, dput only stores values up to a finite level of precision. So while our original `mydf` and the read-back-in dataframe `mydf2` look very similar, they differ due the rules of floating point values (a basic element of computer programming that is unimportant to really understand):
head(mydf)
head(mydf2)
mydf==mydf2
#' Thus, a dataframe saved using `save` is exactly the same when reloaded into R whereas the one saved using `dput` is the same up to a lesser degree of precision.
#' 
#' Let's clean up that file so not to leave a mess:
unlink('saveddf.text')
#' 
#' ## dump (and source) ##
#' Similar to `dput`, the `dump` function writes the `dput` output to a file. Indeed, it write the exact same representation we saw above on the console. But, instead of writing an R expression that we have to save to a variable name later, `dump` preserves the name of our dataframe. Thus it is a blend between `dput` and `save` (but mostly it is like `dput`).
#' `dump` also uses a default filename: `"dumpdata.R"`, making it a shorter command to write and one that is less likely to be destructive (except to previous data dumps). Let's see how it works:
dump("mydf")
#' Note: We specify the dataframe name as a character string because this is written to the file so that when we load the `"dumpdata.R"` file, the dataframe has the same name as it does right now.
#' We can load this dataframe into memory from the file using `source`:
source("dumpdata.R", echo=TRUE)
#' As you'll see in the (truncated) output of `source`, the file looks just like `dput` but includes `mydf <-` at the beginning, meaning it s storing the `dput`-like output into the `mydf` object in R memory.
#' Note: `dump` can also take arbitrary file names to its `file` argument (like the `save` and `dput`).
#' 
#' Let's clean up that file so not to leave a mess:
unlink("dumpdata.R")
#'
#' ## write.csv and write.table ##
#' One of the easiest ways to save an R dataframe is to write it to a comma-separated value (CSV) file. CSV files are human-readable (e.g., in a text editor) and can be opened by essentially any statistical software (Excel, Stata, SPSS, SAS, etc.) making them one of the best formats for data sharing.
#' To save a dataframe as CSV is easy. You simply need to use the `write.csv` function with the name of the dataframe and the name of the file you want to write to. Let's see how it works:
write.csv(mydf, file='saveddf.csv')
#' That's all there is to it.
#' R also allows you to save files in other CSV-like formats. For example, sometimes we want to save data using a different separator such as a tab (i.e., to create a tab-separated value file or TSV). The TSV is, for example, the default file format used by The Dataverse Network online data repository. To write to a TSV we use a related function `write.table` and specify the `sep` argument:
write.table(mydf, file='saveddf.tsv', sep='\t')
#' Note: We use the `\t` symbol to represent a tab (a standard common to many programming languages).
#' We could also specify any character as a separator, such as `|` or `;` or `.` but commas and tabs are the most common.
#' Note: Just like `dput`, writing to a CSV or another delimited-format file necessarily includes some loss of precision, which may or may not be problematic for your particular use case.
#'
#' Let's clean up our files just so we don't leave a mess:
unlink('savedf.csv')
unlink('savedf.tsv')
#'
#' ## Writing to "foreign" file formats ##
#' The **foreign** package, which we can use to load "foreign" file formats also includes a `write.foreign` function that can be used to write an R dataframe to a foreign, proprietary data format. Supported formats include SPSS, Stata, and SAS.
#'