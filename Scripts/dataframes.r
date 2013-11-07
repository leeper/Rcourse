#' ## Dataframes ##
#'
#' When it comes to performing statistical analysis in R, the most important object type is a dataframe.
#' When we load data into R or use R to conduct statistical tests or build models, we want to have our data as a dataframe.
#' A dataframe is actually a special type of list that has some properties that facilitate using it for data analysis.
#'
#' To create a dataframe, we use the `data.frame` function:
a <- data.frame(1:3)
a
#' This example is a single vector coerced into being a dataframe.
#' Our input vector `1:3` is printed as a column and the dataframe has row names:
rownames(a)
#' And the vector has been automatically given a column name:
colnames(a)
#' Note: We can also see the column names of a dataframe using `names`:
names(a)
#'
#' Like a matrix, we can see that this dataframe has dimensions:
dim(a)
#' Which we can observe as row and column dimensions:
nrow(a)
ncol(a)
#'
#' But having a dataframe consisting of one column vector isn't very helpful.
#' In general we want to have multiple columns, where each column is a variable and each row is an observation.
b <- data.frame(1:3,4:6)
b
#' You can see the similarity to building a list and indeed if we check whether our dataframe is a list, it is:
is.data.frame(b)
is.list(b)
#' Our new dataframe `b` now has two column variables and the same number of rows.
#' The names of the dataframe are assigned automatically, but we can change them:
names(b)
names(b) <- c("var1","var2")
names(b)
#' We can also assign names when we create a dataframe, just as we did with a list:
d <- data.frame(var1=1:3,var2=4:6)
names(d)
d
#'
#'
#' ## Dataframe indexing ##
#'
#' Indexing dataframes works similarly to both lists and matrices.
#' Even though our dataframe isn't a matrix:
is.matrix(d)
#' We can still index it in two dimensions like a matrix to extract rows, columns, or elements:
d[1,]   #' row
d[,2]   #' column
d[3,2]  #' element
#' Because dataframes are actually lists, we can index them just like we would a list:
#' For example, to get a dataframe containing only our first column variable, we can use single brackets:
d[1]
#' The same result is possible with named indexing:
d['var1']
#' To get that column variable as a vector instead of a one-column dataframe, we can use double brackets:
d[[1]]
#' And we can also use named indexing as we would in a list:
d[['var1']]
d$var1
#' And, we can combine indexing like we did with a list to get the elements of a column vector:
d[['var2']][3]
d$var2[3]
#' We can also use `-` indexing to exclude columns:
d[,-1]
#' or rows:
d[-2,]
#' Thus, it is very easy to extract different parts of a dataframe in different ways, depending on what we want to do.
#'
#'
#' ## Modifying dataframes ##
#'
#' With those indexing rules, it is also very easy to change dataframe elements.
#' For example, to add a column variable, we just need to add a vector with a name:
d$var3 <- 7:9
d
#' If we try to add a vector that is shorter than the number of dataframe rows, recycling is invoked:
d$var4 <- 1
d
#' If we try to add a vector that is longer than the number of dataframe rows, we get a error:
d$var4 <- 1:4
#' So even though a dataframe is like a list, it has the restriction that all columns must have the same length.
#'
#' We can also remove dataframe columns by setting them equal to NULL:
d
d$var4 <- NULL
d
#' This permanently removes the column variable from the dataframe and reduces its dimensions.
#' To remove rows, you simply using positional indexing as described above and assign the result as itself:
d
d[-2,]
d <- d[-2,]
d
#' This highlights an important point. Unless we assign using `<-`, we are not modifying the dataframe, only changing what is displayed.
#' If we want to preserve a dataframe and a modified version of it, we can simply assign the modified version a new name:
d
d2 <- d[,-1]
#' This leaves our original dataframe unchanged:
d
#' And gives us a new object reflecting the modified dataframe:
d2
#'
#'
#' ## Combining dataframes ##
#' Another similarly between dataframes and matrices is that we can bind them columnwise:
e1 <- data.frame(1:3,4:6)
e2 <- data.frame(7:9,10:12)
cbind(e1,e2)
#' To bind them rowwise, however, the two dataframes need to have matching `names`:
names(e1) <- names(e2) <- c("Var1","Var2")
rbind(e1,e2)
#'
#' Dataframes can also be combined using the `merge` function.
#' `merge` is powerful, but can also be confusing.
#' Let's imagine that our two dataframes contain observations for the same three individuals, but in different orders:
e1$id <- 1:3
e2$id <- c(2,1,3)
#' We should also rename the variables in `e2` to show that these are unique variables:
names(e2)[1:2] <- c("Var3","Var4")
#' If we use `cbind` to combine the data, variables from observations in the two dataframes will be mismatched:
cbind(e1,e2)
#' This is where merge comes in handy because we can specify a `by` parameter:
e3 <- merge(e1,e2,by='id')
#' The result is a single dataframe, with a single `id` variable and observations from the two dataframes are matched appropriately.
#'
#' That was a simple example, but what if our dataframes have different (but overlapping) sets of observations.
e4 <- data.frame(Var5=10:1,Var6=c(5:1,1:5),id=c(1:2,4:11))
e4
#' This new dataframe `e4` has two observations common to the previous dataframes (1 and 2) but no observation for 3.
#'
#' If we merge `e3` and `e4`, what do we get?
merge(e3,e4,by='id')
#' The result is all variables (columns) for the two common observations (1 and 2).
#' If we want to include observation 3, we can use:
merge(e3,e4,by='id',all.x=TRUE)
#' Note: The `all.x` argument refers to which observations from the first dataframe (`e3`) we want to preserve.
#'
#' If we want to include observations 4 to 11, we can use:
merge(e3,e4,by='id',all.y=TRUE)
#' Note: The `all.y` argument refers to which observations from the second dataframe (`e4`) we want to preserve.
#'
#' Of course, we can preserve both with either:
merge(e3,e4,by='id',all.x=TRUE,all.y=TRUE)
merge(e3,e4,by='id',all=TRUE)
#' These two R statements are equivalent.
#'
#' Note: If we set `by=NULL`, we get a potentially unexpected result:
merge(e3,e4,by=NULL)
#' If we leave by blank, the default is to merge based on the common variable names in both dataframes.
#' We can also separately specify `by` for each dataframe:
merge(e3,e4,by.x='id',by.y='id')
#' This would be helpful if the identifier variable had a different name in each dataframe.
#'
#' Note: `merge` only works with two dataframes. So, if multiple dataframes need to be merged, it must be done sequentially:
merge(merge(e1,e2),e4)
#'