#' # Dataframe Structure #
#' 
#' Dataframes are integrally important to using R for any kind of data analysis.
#' One of the most frustrating aspects of R for new users is that, unlike Excel, or even SPSS or Stata, it is not terribly easy to look at and modify data in a spreadsheet like format.
#' In the tutorial on dataframes as a class, you should have learned a bit about what dataframes are and how to index and modify them.
#' Here we are going to discuss how to look at dataframes in a variety of ways.
#'
#' ## print, summary, and str ##
#' Looking at dataframes in R is actually pretty easy. Because a dataframe is an R object, we can simply print it to the console by calling its name. Let's create a dataframe and try this:
mydf <- data.frame(a=rbinom(100,1,.5), b=rnorm(100), c=rnorm(100), d=rnorm(100), e=sample(LETTERS,100,TRUE))
mydf
#' This output is fine but kind of inconvenient. It doesn't fit on one screen, we can't modify anything, and - if we had more variables and/or more observations - it would be pretty difficult to anything in this way.
#' Note: Calling the dataframe by name is the same as `print`-ing it. So `mydf` is the same as `print(mydf)`.
#' As we already know, we can use `summary` to see a more compact version of the dataframe:
summary(mydf)
#' Now, instead of all the data, we see a five-number summary of the data for numeric or integer variables and a tabulation of `mydf$e`, which is a factor variable (you can confirm this with `class(mydf$e)`).
#' We can also use `str` to see a different kind of compact summary:
str(mydf)
#' This output has the advantage of additionally showing variable classes and the first few values of each variable, but doesn't provide a numeric summary of the data. Thus `summary` and `str` complement each other rather than provide duplicate information.
#' Remember, too, that dataframes also carry a "names" attribute, so we can see just the names of our variables using:
names(mydf)
#' This is very important for when a dataframe is very wide (i.e., has large numbers of variables) because even the compact output of `summary` and `str` can become unwieldy with more than 20 or so variables.
#'
#' ## head and tail ##
#' Two frequently neglected functions in R are `head` and `tail`. These offer exactly what their names suggest, the top and bottom few values of an object:
head(mydf)
#' Note the similarly between these values and those reported in `str(mydf)`.
tail(mydf)
#' Both `head` and `tail` accept an additional argument referring to how many values to display:
head(mydf, 2)
head(mydf, 15)
#' These functions are therefore very helpful for looking quickly at a dataframe.
#' They can also be applied to individual variables inside of a dataframe:
head(mydf$a)
tail(mydf$e)
#'
#' ## edit and fix ##
#' R provides two ways to edit an R dataframe (or matrix) in a spreadsheet like fashion. They look the same, but are different! Both can be used to look at data in a spreadsheet-like way, but editing with them produces drastically different results.
#' Note: One point of confusion is that calling `edit` or `fix` on a non-dataframe object opens a completely different text editing window that can be used to modify vectors, functions, etc. If you try to `edit` or `fix` something and don't see a spreadsheet, the object you're trying to edit is not rectangular (i.e., not a dataframe or matrix).
#'
#' ### edit ###
#' The first of these is `edit`, which opens an R dataframe as a spreadsheet. The data can then be directly edited.
#' When the spreadsheet window is closed, the resulting dataframe is returned to the user (and printed to the console).
#' This is a reminder that it didn't actually change the `mydf` object. In other words, when we `edit` a dataframe, we are actually copying the dataframe, changing its values, and then returning it to the console. The original `mydf` is unchanged. If we want to use this modified dataframe, we need to save it as a new R object.
#' 
#' ### fix ###
#' The second data editing function is `fix`. This is probably the more intuitive function.
#' Like `edit`, `fix` opens the spreadsheet editor. But, when the window is closed, the result is used to replace the dataframe. Thus `fix(mydf)` replaces `mydf` with the edited data.
#'
#' `edit` and `fix` can seem like a good idea. And if they are used simply to look at data, they're a great additional tool (along with `summary`, `str`, `head`, `tail`, and indexing).
#' But (!!!!) using `edit` and `fix` are non-reproducible ways of conducting data analysis. If we want to replace values in a dataframe, it is better (from the perspective of reproducible science) to write out the code to perform those replacements so that you or someone else can use them in the future to achieve the same results. So, in short, use `edit` and `fix`, but don't abuse them.
#'