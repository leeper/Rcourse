#' # Build Index of Scripts #
cat('# Index of R Course Scripts #\n\n', file='index.md')
htmls <- dir(pattern='.html')
htmls <- htmls[-grep('zzz.html',htmls)] # remove this script
htmls <- htmls[-grep('index.html',htmls)] # remove the index
mds <- gsub('.html','.md',htmls)
titles <- sapply(mds, function(x) readLines(x,n=1))
titles <- gsub('#','',titles)
tmp <- data.frame(html=htmls,title=titles)
tmp <- tmp[order(tmp$title),]
cat(paste('* [',tmp$title,'](',tmp$html,')',sep=''),sep='\n',file='index.md',append=TRUE)
library(markdown)
markdownToHTML('index.md',output='index.html')
unlink('zzz.html') # delete this html
unlink('zzz.md') # delete this md
unlink('zzz.Rmd') # delete this Rmd
unlink('*.md') # delete-all md
unlink('*.Rmd') # delete-all Rmd
browseURL('index.html')
