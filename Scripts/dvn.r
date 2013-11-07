#' # Data Archiving #
#'
#' As part of reproducible research, it is critical to make data and replication files publicly available.
#' Within political science, The Dataverse Network is increasingly seen as the disciplinary standard for where and how to permanently archive data and replication files. This tutorial works through how to archive study data, files, and metadata at The Dataverse Network directly through R.
#'
#' ## The Dataverse Network ##
#' The Dataverse Network, created by the Institute for Quantitative Social Science at Harvard University, is software and an associated network of websites that permanently archive social data for postereity. The service is free to use, relatively simple, and strengthened by a recently added Application Programming Interface (API) that allows researchers to deposit into the Dataverse directly from R through the **dvn** package.
#'
#' ## The dvn package ##
#' To deposit data in the Dataverse, you need to have an account. You can pick [which dataverse website you want to use](http://thedata.org/book/dataverse-networks-around-world), but I recommend using the [Harvard Dataverse](http://thedata.harvard.edu/dvn/), where much political science data is stored. Once you create an account and configure a personal dataverse, you can do almost everything else directly in R.
#' To get started, install and load the **dvn** package:
install.packages('dvn',repos='http://cran.r-project.org')
library(dvn)
#' Once installed, you'll need to setup your username and password using:
options('dvn.user'='username', 'dvn.pwd'='password')
#' Remember not to share your username and password with others. Since the remainder of this tutorial only works with a proper username and password, the following code is commented out, but should run on your machine:
#' You can check to make sure your login credentials work by retrieving your Service Document:
# dvServiceDoc()
#' If that succeeds, then you can easily create a study by setting up some metadata (e.g., the title, author, etc. for your study) and then using `dvCreateStudy` to create that the study listing.
# writeLines(dvBuildMetadata(title="My Study"),"mystudy.xml")
# created <- dvCreateStudy("mydataverse","mystudy.xml")
#' Then, you need to add files. dvn is versatile with regard to how to do this, allowing you to submit either filenames as character strings:
# dvAddFile(created$objectId,filename=c("file1.csv","file2.txt"))
#' dataframes currently loaded in memory:
# dvAddFile(created$objectId,dataframe=mydf)
#' or a .zip file containing multiple files:
# dvAddFile(created$objectId,filename="files.zip")
#' You can then confirm that everything has been uploaded successfully by examining the Study Statement:
# dvStudyStatement(created$objectId)
#' If everything looks good, you can then release the study publicly:
# dvReleaseStudy(created$objectid)
#' The dvn package also allows you to modify the metadata and delete files, but the above constitutes a complete workflow to making your data publicly available. See the package documentation for more details.
#'
#' ## Searching for data using dvn ##
#' dvn additionally allows you to search for study data directly from R. For example, you can find all of my publicly available data using:
search <- dvSearch(list(authorName="leeper"))
#' Thus archiving your data on The Dataverse Network makes it readily accessible to R users everywhere, forever.
#'