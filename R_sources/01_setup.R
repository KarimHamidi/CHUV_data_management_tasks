################################################################################
## All the packages needed to execute the R sources are referenced here.
## The directories that will be used to store input and output data are also 
## created in this R source.
## Please uncomment and run the install.packages lines to install them
################################################################################
## Packages installation and libraries calls
# install.packages("writexl")
library("writexl")
install.packages("readxl")
library("readxl")
# install.packages("dplyr")
library("dplyr")
# install.packages("rmarkdown")
library("rmarkdown")
# install.packages("lubridate")
library("lubridate")
start = as.Date("1900-01-01")

##creation of needed directories 
dir.create("input_data")
dir.create("output_data")