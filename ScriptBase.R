#!/usr/bin/env Rscript
#Usage:

#install.packages("readxl")
#install.packages("tidyverse")

#Libraries
library(tidyverse)
library("readxl")

setwd("~/Documents/Process_FACS_data/")

#read file 
excel_doc<-file.choose()
my_data <- read_excel(excel_doc)
#extract directory
out_dir<-dirname(excel_doc)

#trimm data
my_data <-my_data[grep("> > >|> > > >",my_data$Depth),1:3]

if(nrow(my_data)%%3!=0){
  print("Error, you have some missing value, fix the table before inputting")
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
write.table(my_data, file=paste0(gsub("xls","",excel_doc),"_NEW.xls"), row.names=FALSE,sep = "\t")

