#' # Model Formulae #
#'
#' One of the most important object classes for statistics in R is the "formula" class. Formula objects, while unimportant for R in general, are critical to many of statistical tests and statistical plots in R (as well as many add-on packages). Formulae convey a relationship among a set of variables in a simple, intuitive way. They are also data-independent, meaning that a formula can be constructed and then used with application to different dataframes or subsets of a dataframe. This means we can define formulae without having any data loaded.
#' Note: We did not discuss formulas in the tutorials on object classes, because they are not one of the fundamental classes needed throughout R. They are only needed for statistical procedures, which we happen to need a lot in academic research but aren't as critical in other uses of R.
#'
#' ## Formula basics ##
#' The basic structure of a formula is the tilde symbol (`~`) and at least one independent (righthand) variable. In most (but not all) situations, a single dependent (lefthand) variable is also needed.
#' Thus we can construct a formula quite simply by just typing:
~ x
#' Note: Spaces in formulae are not important.
#' And, like any other object, we can store this as an R variable and see that it is, in fact, a formula:
myformula <- ~x
class(myformula)
#' More commonly, we want to express a formula as a relationship between an outcome (lefthand) variable and one or more independent/predictor/covariate (righthand) variables:
myformula <- y~x
#' We can use multiple independent variables by simply separating them with the plus (`+`) symbol:
y ~ x1 + x2
#' If we use a minus (`-`) symbol, objects in the formula are ignored in an analysis:
y ~ x1 - x2
#'
#' One particularly helpful feature when modelling with lots of variables is the `.` operator. When used in a formula, `.` refers to all other variables in the matrix not yet included in the model. So, if we plan to run a regression on a matrix (or dataframe) containing the variables `y`, `x1`, `z3`, and `areallylongvariablename`, we can simply use the formula:
y ~ .
#' and avoid having to type all of the variables.
#'
#' ## Interaction terms ##
#' In a regression modeling context, we often need to specify interaction terms. There are two ways to do this.
#' If we want to include two variables and their interaction, we use the star/asterisk (`*`) symbol:
y ~ x1*x2
#' If we only want their interaction, but not the variables themselves, we use the colon (`:`) symbol:
y ~ x1:x2
#' Note: We probably don't want to do this.
#' This means that some formulae that look different are actually equivalent. The following formulae will produce the same regression:
y ~ x1*x2
y ~ x1 + x2 + x1:x2
#'
#' ## Regression formulae ##
#' In regression models, we may also want to know a few other tricks.
#' One trick is to drop the intercept, by either including a zero (`0`) or a minus-one (`-1`) in the formula:
y ~ -1 + x1*x2
y ~ 0 + x1*x2
#' We can also offset the intercept of a model using the `offset` function. The use is kind of strange and not that common, but we can increase the intercept by, e.g., 2 using:
y ~ x1 + offset(rep(-2,n))
#' or reduce the intercept by, e.g., 3 using:
y ~ x1 + offset(rep(3,n))
#' Note: The `n` here would have to be tailed to the length of the actual. It's unclear in what context this functionality is really helpful, but it does mean that models can be adjusted in fairly sophisticated ways.
#'
#' ## Factor variables ##
#' An important consideration in regression formulae is the handling of factor-class variables. When a factor is included in a regression model, it is automatically converted into a series of indicator ("dummy") variables, with the factor's first level treated as a baseline. This also means that we can convert non-factor variables into a series of dummies, simply by wrapping them in `factor`:
y ~ x
# to:
y ~ factor(x)
#'
#' ## As-is variables ##
#' One trick to formulas is that they don't evaluate their contents. So, for example, if we wanted to include `x` and `x^2` in our model, we might intuit that we should type:
y ~ x + x^2
#' If we attempted to estimate a regression model using this formula, R would drop the `x^2` term because it thinks it is a duplicate of `x`. We therefore have to either calculate and store all of the variables we want to include in the model in advance, or we need to use the `I()` "as-is" operator.
#' To obtain our desired two-term formula, we could use `I()` as follows:
y ~ x + I(x^2)
#' This tells R to calculate the values of `x^2` before attempting to use the formula.
#' Aside from calculating powers, `I()` can also be helpful when we want to rescale a variable for a model (e.g., to make two coefficients more comparable by using a common scale). Again, we simply wrap the relevant variable name in `I()`:
y ~ I(2*x)
#' This formula would, in a linear regression, produce a coefficient half as large as the model for `y~x`.
#'
#' ## Formulae as character strings ##
#' One might be tempted to compare a formula to a character string. They look similar, but they are different. Their similar means, however, that a character string containing a formula can often be used where a formula-class object is required. Indeed the following is true:
("y ~ x") == (y ~ x)
#' And we can easily convert between formula and character class:
as.formula("y~x")
as.character(y~x)
#' Note: The result of the latter is probably not what you expected. But relates to how formulae are indexed:
(y~x)[1]
(y~x)[2]
(y~x)[3]
#' The ability to easily transform between formula and character class means that we can also build formulae on the fly using `paste`. For example, if we want to add righthand variables to a formula, we can simply paste them:
paste('y~x','x2','x3',sep='+')
#'
#' ## Advanced formula manipulation ##
#' One of the really nice features of formulae is that they have many methods. For example, we can use the `terms` function to examine and compare different formulae:
terms(y ~ x1 + x2)
terms(y ~ 0 + x1)
terms(~ x1 + x2)
#' The output above shows the formula itself, a list of its constitutive variables, the presence of intercept, the presence of an outcome, and so forth.
#' If we just want to know the names of the variables in the model, we can use `all.vars`:
all.vars(y~x1+x2)
#'
#' We can also modify formulae without converting them to character (as we did above), using the `update` function. This potentially saves a lot of typing:
update(y ~ x, ~ . + x2)
update(y ~ x, z ~ .)
#' This could be used, e.g., to run a model on a "small" model and then a larger version:
myformula <- y ~ a + b + c
update(myformula, '~.+d+e+f')
#' Or the same righthand variables to predict two different outcomes:
update(myformula, 'z~.')
#' We can also drop terms using `update`:
update(myformula,'~.-a')
#'