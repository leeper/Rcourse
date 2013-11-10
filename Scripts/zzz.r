#' # Build Index of Scripts #
cat('# Index of R Tutorials #\n\n', file='index.md')
htmls <- dir(pattern='.r$')
htmls <- gsub('.r','.html',htmls, fixed=TRUE)
z <- grep('zzz.html',htmls)
if(length(z))
    htmls <- htmls[-z] # remove this script
mds <- gsub('.html','.md',htmls)
titles <- sapply(mds, function(x) readLines(x,n=1))
titles <- gsub("[#']",'',titles)
tmp <- data.frame(html=htmls,title=titles)
tmp <- tmp[order(tmp$title),]
cat(paste('* [',tmp$title,'](',tmp$html,')',sep=''),sep='\n',file='index.md',append=TRUE)
library(markdown)
markdownToHTML('index.md',output='index.html')

unlink('*.md') # delete-all md
unlink('*.Rmd') # delete-all Rmd

if('Tutorials' %in% dir('../'))
    unlink('../Tutorials',recursive=TRUE)
dir.create('../Tutorials')
infiles <- dir(pattern='.html')
outfiles <- file.path('../Tutorials',infiles)
file.rename(infiles,outfiles)
file.rename('figure','../Tutorials/figure')

browseURL(file.path(getwd(),'../Tutorials/index.html'))
