#' # Dataframe rearrangement #
#'
#' In addition to knowing how to index and view dataframes, as is discussed in other tutorials, it is also helpful to be able to adjust the arrangement of dataframes. By this I mean that it is sometimes helpful to split, sample, reorder, reshape, or otherwise change the organization of a dataframe. This tutorial explains a couple of functions that can help with these kinds of tasks.
#' Note: One of the most important things to remember about R dataframes is that it rarely, if ever, matters what order observations or variables are have in a dataframe. Whereas in SPSS and SAS observations have to be sorted before performing operations, R does not require such sorting.
#'
#' ## Column order ##
#' Sometimes we want to get dataframe columns in a different order from how they're read into the data. In most cases, though, we can just index the dataframe to see relevant columns rather reordering, but we can do the reordering if we want.
#' Say we have the following 5-column dataframe:
set.seed(50)
mydf <- data.frame(a=rep(1:2,times=10),
                   b=rep(1:4,each=5),
                   c=rnorm(20),
                   d=rnorm(20),
                   e=sample(1:20,20,FALSE))
head(mydf)
#' To view the columns in a different order, we can simply index the dataframe differently either by name or column position:
head(mydf[,c(3,4,5,1,2)])
head(mydf[,c('c','d','e','a','b')])
#' We can save the adjusted column order if we want:
mydf <- mydf[,c(3,4,5,1,2)]
head(mydf)
#'
#' ## Row order ##
#' Changing row order works the same way as changing column order. We can simply index the dataframe in a different way. For example, let's say we want to reverse the order of the dataframe, we can simply write:
mydf[nrow(mydf):1,]
#' And then we can save this new order if we want:
mydf <- mydf[nrow(mydf):1,]
#'
#' Rarely, however, do we want to just reorder by hand. Instead we might want to reorder according to the values of a column. One's intuition might be to use the `sort` function because it is used to sort a vector:
mydf$e
sort(mydf$e)
#' But trying to run `sort(mydf)` will produce an error.
#' Instead, we need to use the `order` function, which returns the indexes of a sorted vector. Confusing? let's see how it works:
order(mydf$e)
#' That doesn't look like a sorted vector, but this is because the values being shown are the indices of the vector, not the values themselves. If we index the `mydf$e` vector by the output of `order(mydf$e)`, it will be in the order we're expecting:
mydf$e[order(mydf$e)]
#' We can apply this same logic to sorting a dataframe. We simply pick which column we want to order by and then use the output of `order` as a row index. Let's compare the reordered dataframe to the original:
head(mydf[order(mydf$e),])
head(mydf) # original
#' Of course, we could save the reordered dataframe just as above:
mydf <- mydf[order(mydf$e),]
#'
#' ## Subset of rows ##
#' Another common operation is to look at a subset of dataframe rows. For example, we might want to look at just the rows where `mydf$a==1`. Remembering the rules for indexing a dataframe, we can simply index according to a logical rule:
mydf[mydf$a==1,]
#' And to get the rows where `mydf$a==2`, we can do quite the same operation:
mydf[mydf$a==2,]
#' We can also combine logical rules to get a further subset of values:
mydf[mydf$a==1 & mydf$b==4,]
#' And we need to restrict ourselves to equivalency logicals:
mydf[mydf$a==1 & mydf$b>2,]
#'
#' R also supplies a `subset` function, which can be used to select subsets of rows, subsets of columns, or both. It works like so:
# subset of rows:
subset(mydf, a==1)
subset(mydf, a==1 & b>2)
# subset of columns:
subset(mydf, select=c('a','b'))
# subset of rows and columns:
subset(mydf, a==1 & b>2, select=c('c','d'))
#' Using indices and `subset` are equivalent, but the indexing syntax is more general.
#'
#' ## Splitting a dataframe ##
#' In one of the above examples, we extracted two separate dataframes: one for `mydf$a==1` and one for `mydf$a==2`. We can actually achieve that result using a single line of code involving the `split` function, which returns a list of dataframes, separated out by a grouping factor:
split(mydf, mydf$a)
#' We can also split by multiple factors, e.g., a dataframe for every unique combination of `mydf$a` and `mydf$b`:
split(mydf, list(mydf$a, mydf$b))
#' Having our dataframes stored inside another object might seem inconvenient, but it actually is vary useful because we can use functions like `lapply` to perform an operation on every dataframe in the list. For example, we could get the summary of every variable in each of two subsets of the dataframe in a single line of code:
lapply(split(mydf, mydf$a), summary)
#'
#' ## Sampling and permutations ##
#' Another common task is random sampling or permutation of rows in a dataframe. For example, we might want to build a regression model on a random subset of cases (a "training set") and then test the model on the remaining case (a "test set"). Or, we might want to look at a random sample of the observations (e.g., perhaps to speed up a very time-consuming analysis).
#' Let's consider the case of sampling for "training" and "test" sets. To obtain a random sample, we have two choices. We can either sample a specified number of rows or we can use a logical index to sample rows based on a specified probability. Both use the `sample` function.
#' To look at, e.g., exactly five randomly selected rows from our data frame as the training set, we can do the following:
s <- sample(1:nrow(mydf),5,FALSE)
s
#' Note: The third argument (`FALSE`) refers to whether sampling should be done with replacement.
#' We can then use that directly as a row index:
mydf[s,]
#' To see the test set, we simply drop all rows not in `s`:
mydf[-s,]
#' An alternative is to get a random 20% of the rows but not require that to be exactly five observations. To do that, we make 20 random draws (i.e., a number of draws equal to the number of rows in our dataframe) from a binomial distribution with probability .2:
s2 <- rbinom(nrow(mydf),1,.2)
s2
#' We can then use that directly as a row index:
mydf[s2,]
#' And again see the test set as those observations not in `s2`.
mydf[!s2,]
#' Note: Here we use `!s2` because `s2` is a logical index, whereas above we used `-s` because `s` was a positional index.
#'