#!/usr/bin/env Rscript
# I am using this https://www.r-bloggers.com/2015/09/passing-arguments-to-an-r-script-from-command-lines/ to follow instructions

#!/usr/bin/env Rscript
library("optparse")

option_list = list(
  make_option(c("-f", "--file"), type="character", default=NULL, 
              help="input file name", metavar="character"),
  make_option(c("-o", "--out"), type="character", default="out.txt", 
              help="output file name [default= %default]", metavar="character")
); 

opt_parser = OptionParser(option_list=option_list);
opt = parse_args(opt_parser);

#check input
if (is.null(opt$file)){
  print_help(opt_parser)
  stop("At least one argument must be supplied (input file).n", call.=FALSE)
}


#now the function
## program...

#librriesScr
library(tidyverse)
library("readxl")

#read file 
my_data <- read_excel(opt$file)
#extract directory
out_dir<-dirname(opt$file)

#trimm data
my_data <-my_data[grep("> > >|> > > >",my_data$Depth),1:3]

if(nrow(my_data)%%3!=0){
  stop("Error, you have some missing value, fix the table before inputting", call.=FALSE)
}

#extract sample name
my_data$Sample=rep(sapply(strsplit(my_data$Name[my_data$Depth %in% c("> > >")],"_"),"[[",3),each=3)
#create sol names
my_data$Cond=rep(c("Live_Cells","APC_A","PE_A"),nrow(my_data)/3)
#remove unused names
my_data <-my_data[,-c(1:2)]
#spread the dataset
my_data <-my_data %>% pivot_wider( names_from = "Cond", values_from = "Statistic")
#write file 
write.table(my_data, file=paste0(gsub("xls","",opt$file),"_NEW.xls"), row.names=FALSE,sep = "\t")