#' # R Objects and Environment #
#'
#' One of the most confusing aspects of R for users of other statistical software is the idea that one can have any number of objects available in the R environment. One need not be constrained to a single rectangular dataset.
#' This also means that it can be confusing to see what data is actually loaded into memory at any point in time.
#' Here we discuss some tools for understanding the R working environment.
#'
#' ## Listing objects ##
#' Let's start by clearing our workspace:
rm(list=ls(all=TRUE))
#' This option should be available in RGui under menu Miscellaneous > Remove all objects.
#' Then create some R objects:
set.seed(1)
x <- rbinom(50,1,.5)
y <- ifelse(x==1, rnorm(sum(x==1),1,1), rnorm(sum(!x==1),2,1))
mydf <- data.frame(x=x, y=y)
#' Once we have a number of objects stored in memory, we can look at all of them using `ls`:
ls()
#' This shows us all of the objects that are currently saved.
#' If we do another operation but do not save the result:
2 + 2
ls()
#' This result is not visible with `ls`. Esssentially it disappears into the ether.
#'
#' ## Viewing individual objects ##
#' Now we can look at any of these objects just by calling their name:
x
y
mydf
#' The first two objects (`x` and `y`) are vectors, so they simply print to the console.
#' The second object (`mydf`) is a dataframe, so its contents are printed as columns with row numbers.
#' If we call one of the columns from the dataframe, it will look just like a vector:
mydf$x
#' This looks the same as just calling the `x` object and indeed they are the same:
mydf$x == x
#' But if we change one of the objects, it only affects the object we changed:
x <- rbinom(50,1,.5)
mydf$x == x
#' So by storing something new into `x` we change it, but not `mydf$x` because that's a different object.
#'
#' ## Object `class` ##
#' We sometimes what to know what kind of object something is. We can see this with `class`:
class(x)
class(y)
class(mydf)
#' We can also use `class` on the columns of a dataframe:
class(mydf$x)
class(mydf$y)
#' This is helpful, but it doesn't tell us a lot about the objects (i.e., it's not a very good summary).
#' We can, however, see more detail using some other functions.
#'
#' ## str ##
#' One way to get very detailed information about an object is with `str` (i.e, structure):
str(x)
#' This output tells us that this is an object of class "integer", with length 50, and it shows the first few values.
str(y)
#' This output tells us that this is an object of class "numeric", with length 50, and it shows the first few values.
str(mydf)
#' This output tells us that this is an object of class "data.frame", with 50 observations on two variables. It then provides the same type of details for each variable that we would see by calling `str(mydf$x)`, etc. directly.
#' Using `str` on dataframes is therefore a very helpful and compact way to look at your data. More about this later.
#'
#' ## summary ##
#' To see more details we may want to use some other functions.
#' One particularly helpful function is `summary`, which provides some basic details about an object.
#' For the two vectors, this will give us summary statistics.
summary(x)
summary(y)
#' For the dataframe, it will give us summary statistics for everything in the dataframe:
summary(mydf)
#' Note how the printed information is the same but looks different.
#' This is because R prints slightly different things depending on the class of the input object.
#' If you want to look "under the hood", you will see that `summary` is actually a set of multiple functions. When you type `summary` you see that R is calling a "method" depending on the class of the object. For our examples, the methods called are `summary.default` and `summary.data.frame`, which differ in what they print to the console for vectors and dataframes, respectively.
#'
#' Conveniently, we can also save any output of a function as a new object. So here we can save the `summary` of `x` as a new object:
sx <- summary(x)
#' And do the same for `mydf`:
smydf <- summary(mydf)
#' We can then see that these new objects also have classes:
class(sx)
class(mydf)
#'
#' And, as you might be figuring out, an object's class determines how it is printed to the console.
#' Again, looking "under the hood", this is because there are separate `print` methods for each object class (see `print.data.frame` for how a dataframe is printed and `print.table` for how the summary of a dataframe is printed).
#' This can create some confusion, though, because it means that what is printed is a reflection of the underlying object but is not actually the object. A bit existential, right? Because calling objects shows a printed rendition of an object, we can sometimes get confused about what that object actually is.
#' This is where `str` can again be helpful:
str(sx)
str(smydf)
#' Here we see that the summary of `x` and summary of `mydf` are both tables. `summary(x)` is a one-dimensional table, whereas `summary(mydf)` is a two-dimensional table (because it shows multiple variables).
#' Because these objects are tables, it actually means we can index them like any other table:
sx[1]
sx[2:3]
smydf[,1]
smydf[1:3,]
#' This can be confusing because `sx` and `smydf` do not look like objects we can index, but that is because the way they are printed doesn't reflect the underlying structure of the objects.
#'
#' ## Structure of other objects ##
#' It can be helpful to look at another example to see how what is printed can be confusing.
#' Let's conduct a t-test on our data and see the result:
t.test(mydf$x, mydf$y)
#' The result is a bunch of details about the t.test. Like above, we can save this object:
myttest <- t.test(mydf$x, mydf$y)
#' Then we can call the object again whenever we want without repeating the calculation:
myttest
#' If we try to run `summary` on this, we get some weirdness:
summary(myttest)
#' Because there is no method for summarizing a t.test. Why is this?
#' It is because of the class and structure of our `myttest` object. Let's look:
class(myttest)
#' This says it is of class "htest". Not intuitive, but that's what it is.
str(myttest)
#' This is more interesting. The output tells us that `myttest` is a list of 9 objects. If we compare this to the output of `myttest`, we will see that when we call `myttest`, R is printing the underlying list in a pretty fashion for us.
#' But because `myttest` is a list, it means that we can access any of the values in the list simply by calling them.
#' So the list consists of `statistic`, `parameter`, `p.value`, etc. Let's look at some of them:
myttest$statistic
myttest$p.value
#' The ability to extract these values from the underlying object (in addition to see them printed to the console in pretty form), means that we can easily use objects again and again to, e.g., combine results of multiple tests into a simplified table or use values from one test elsewhere in our analysis.
#' As a simple example, let's compare the p-values of the same t.test under different hypotheses (two-sided, which is the default, and each of the one-sided alternatives):
myttest2 <- t.test(mydf$x, mydf$y, 'greater')
myttest3 <- t.test(mydf$x, mydf$y, 'less')
myttest$p.value
myttest2$p.value
myttest3$p.value
#' This is much easier than having to copy and paste the p-value from each of the outputs and because these objects are stored in memory, we can access them at any point later in this session.
#'