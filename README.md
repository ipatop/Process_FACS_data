# Process_FACS_data

These are a set of scripts designed to process FACS data into tidy datasets.

## Requirements

readxl, tidyverse

´´´
install.packages(c("readxl","tidyverse"))
´´´

## Input and output

Input should be in excel xls format and should not have missing measurements. An example is in Plate_1.xls

The output will have 4 columns ´Sample	Live_Cells	APC_A	PE_A´ . An example is in Plate_1._New.xls

## Run

There are two options to run it.

1. Open the script called **ScriptBase.R** and run one line at the time in R/RStudio. This will allow you to have the data preloaded into R to do plots.

2. Open the terminal or command line (linux or Mac OS prefered) and run **DirectScript.R** as follows

Instructions:
Rscript DirectScript2.R --file <your file location and name.xls> --out <the name you want for your file.xls> 

