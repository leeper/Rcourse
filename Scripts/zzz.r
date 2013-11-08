#' # Build Index of Scripts #
#getwd()
cat('# Index of R Course Scripts #\n\n', file='index.md')
htmls <- dir(pattern='.r$')
htmls <- gsub('.r','.html',htmls, fixed=TRUE)
z <- grep('zzz.html',htmls)
if(length(z))
    htmls <- htmls[-z] # remove this script
#htmls
mds <- gsub('.html','.md',htmls)
titles <- sapply(mds, function(x) readLines(x,n=1))
titles <- gsub("[#']",'',titles)
tmp <- data.frame(html=htmls,title=titles)
tmp <- tmp[order(tmp$title),]
#tmp
cat(paste('* [',tmp$title,'](',tmp$html,')',sep=''),sep='\n',file='index.md',append=TRUE)
library(markdown)
markdownToHTML('index.md',output='index.html')

unlink('*.md') # delete-all md
unlink('*.Rmd') # delete-all Rmd

if('HTML' %in% dir())
    unlink('./HTML',recursive=TRUE)
dir.create('./HTML')
infiles <- dir(pattern='.html')
outfiles <- file.path(file.path(getwd(),'HTML'),infiles)
file.rename(infiles,outfiles)
file.rename('figure','./HTML/figure')

browseURL(file.path(getwd(),'HTML/index.html'))
