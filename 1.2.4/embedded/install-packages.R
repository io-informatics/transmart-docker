
# ipak function: install and load multiple R packages.
# check to see if packages are installed. Install them if they are not, then load them into the R session.

ipak <- function(pkg){
  new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
  if (length(new.pkg)) 
    install.packages(new.pkg, dependencies = TRUE)
  sapply(pkg, require, character.only = TRUE)
}


packages <- c("Rserve", "Cairo", "MASS", "stringr", "ggplot2", "plyr", "reshape2", "gplots", "data.table")
ipak(packages)

source("/tmp/biocLite.R")
biocLite("impute")
install.packages("WGCNA")
biocLite("multtest")
biocLite("limma")
library(Rserve)
Rserve()
