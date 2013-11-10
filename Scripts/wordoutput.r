#' # Exporting results to Word #
#'
#' This tutorial walks through some basics for how to export results to Word format files or similar.
#'
install.packages(c('rtf'),repos='http://cran.r-project.org')
#'
#' As a running example, let's build a regression model, whose coefficients we want to output:
set.seed(1)
x1 <- runif(100,0,1)
x2 <- rbinom(100,1,.5)
y <- x1 + x2 + rnorm(100)
s1 <- summary(lm(y~ x1))
s2 <- summary(lm(y~ x1 + x2))
#'
#'
#' ## Base R functions ##
#' One of the easiest ways to move results from R to Word is simply to copy and paste them. R results are printed in ASCII, though, so the results don't necessarily copy well (e.g., tables tend to lose their formatting unless they're pasted into the Word document using a fixed-width font like Courier).
#' For example, we could just copy print `coef(s)` to the console and manually copy and paste the results:
round(coef(s2),2)
#' Another, perhaps easier alternative, is to write the results to the console as a comma-separated value (CSV) format:
write.csv(round(coef(s2),2))
#' The output doesn't look very pretty in R and it won't look very pretty in Word, either, at least not right away. If you copy the CSV format and paste it into a Word document, it will look like a mess. But, if you select the pasted text, click the "Insert" menu, and press "Table", a menu will open, one option of which is "Convert text to table..." Clicking this option, and selecting to "Separate text at" commmas, then pressing OK will produce a nicely formatted table, resembling the original R output.
#'
#' As long as you can convert an R object (or set of R objects) to a table-like structure, you can use `write.csv` and follow the instructions above to easily move that object into Word.
#' Thus the biggest challenge for writing output to Word format is not the actual output, but the work of building a table-like structure that can easily be output. For example, let's build a nicer-looking results table that includes summary statistics and both of our regression models. First, we'll get all of our relevant statistics and then bind them together into a table:
r1 <- round(coef(s1),2)
r2 <- round(coef(s2),2)
# coefficients
c1 <- paste(r1[,1],' (',r1[,2],')',sep='')
c2 <- paste(r2[,1],' (',r2[,2],')',sep='')
# summary statistics
sigma <- round(c(s1$sigma,s2$sigma),2)
rsq <- round(c(s1$adj.r.squared,s2$adj.r.squared),2)
# sample sizes
n <- c(length(s1$residuals),length(s1$residuals))
#' Now let's bind this all together into a table and look at the resulting table:
outtab <- rbind(cbind(c(c1,''),c2), sigma, rsq, n)
colnames(outtab) <- c('Model 1', 'Model 2')
rownames(outtab) <- c('Intercept','x1','x2','sigma','Adj. R-Squared','n')
outtab
#' Then we can just write it to the console and follow the directions above to copy it to a nice table in Word:
write.csv(outtab)
#'
#'
#' ## The rtf Package ##
#' Another way to output results directly from R to Word is to use the **rtf** package. This package is designed to write Rich-Text Format (RTF) files, but can also be used to write Word files. It's actually very simple to use. You simply need to have the package create a Word (.doc) or RTF file to write to, then you can add plain text paragraphs or anything that can be structured as a dataframe directly to the file. You can then open the file directly with Word, finding the resulting text, tables, etc. neatly embedded. A basic example pasting our regression coefficient table and the nicer looking table is shown below:
library(rtf)
rtffile <- RTF('rtf.doc') # this can be an .rtf or a .doc
addParagraph(rtffile,"This is the output of a regression coefficients:\n")
addTable(rtffile, as.data.frame(round(coef(s2),2)))
addParagraph(rtffile,"\n\nThis is the nicer looking table we made above:\n")
addTable(rtffile, cbind(rownames(outtab),outtab))
done(rtffile)
#' You can then find the `rtf.doc` file in your working directory. Open it to take a look at the results.
#' The **rtf** package also allows you to specify additional options about fonts and the like, making it possible to write a considerable amount of your results directly from R. See `? rtf` for full details.
#'