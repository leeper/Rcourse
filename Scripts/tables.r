#' # Tables #
#'
#' We often want to tabulate data (e.g., categorical data).
#' R supplies tabulation functionality with the `table` function:
set.seed(1)
a <- sample(1:5,25,TRUE)
a
table(a)
#' The result is a table, showing the names of each possible value and a frequency count of for each value.
#' This looks similarly regardless of the class of the vector.
#' Note: If the vector contains continuous data, the result may be unexpected:
table(rnorm(100))

#' We also often want to obtain percentages (i.e., the proportion of observations falling into each category).
#' We can obtain this information by wrapping our `table` function in a `prop.table` function:
prop.table(table(a))
#' The result is a "proportion" table, showing the proportion of observations in each category.
#' If we want percentages, we can simply multiply the resulting table by 100:
prop.table(table(a))*100
#' To get frequencies and proportions (or percentages) together, we can bind the two tables:
cbind(table(a),prop.table(table(a)))
rbind(table(a),prop.table(table(a)))


#' In addition to these basic (univariate) tabulation functions, we can also tabulate in two or more dimensions.
#' To obtain simple crosstabulations, we can still use `table`:
b <- rep(c(1,2),length=25)
table(a,b)
#' The result is a crosstable with the first requested variable `a` as rows and the second as `columns`.
#' With more than two variables, the table is harder to read:
c <- rep(c(3,4,5),length=25)
table(a,b,c)

#' R supplies two additional functions that make reading these kinds of tables easier.
#' The `ftable` function attempts to collapse the previous result into a more readable format:
ftable(a,b,c)

#' The `xtabs` function provides an alternative way of requesting tabulations.
#' This uses R's formula data structure (see 'formulas.r').
#' A righthand-only formula produces the same result as `table`:
xtabs(~a+b)
xtabs(~a+b+c)


#' ## Table margins ##
#'
#' With a crosstable, we can also add table margins using `addmargins`:
x <- table(a,b)
addmargins(x)


#' ## Proportions in crosstables ##
#'
#' As with a one-dimensional table, we can calculate proportions from an k-dimensional table:
prop.table(table(a,b))
#' The default result is a table with proportions of the entire table.
#' We can calculate row percentages with the `margin` parameter set to 1:
prop.table(table(a,b),1)
#' We can calculate column percentages with the `margin` parameter set to 2:
prop.table(table(a,b),2)

