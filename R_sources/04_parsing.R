source(file = file.path("R_sources", "02_project_constants.R"))
source(file = file.path("R_sources", "03_functions.R"))
################################################################################
# The main goal of this R source is to read the input file, ensuring their integrity
# and store them into RDs file for the next steps of the DM tasks.
# data cardinality, the uniqueness of identifiers and the presence of duplicated
# values are check below.
################################################################################

## Dictionary file

# The dictionary file contains information about the other files variables.
data_dictionary <- readxl::read_excel(.constants$file_paths$input_data_paths$data_dictionary) 

# 13 variables are originally listed in the data dictionary
dim(data_dictionary) 
# > dim(data_dictionary)
# [1] 13  4
colnames(data_dictionary)
# [1] "Column Name" "Format"      "Values"      "Definition" 
# no row appear to be duplicated
table(duplicated(data_dictionary))
# FALSE 
# 13 

## file NR
# The first column of the file_NR (named "...1") file is removed. This column
# contained row number and made each row unique even if some values are duplicated
# It is the reason I removed it here. 
file_NR <- readxl::read_excel(.constants$file_paths$input_data_paths$file_NR) %>%
  select(!...1)

dim(file_NR)
# [1] 807  14
colnames(file_NR)
# [1] "PTID"             "PT_enrollment_dt" "icf_signed"       "PT_DOB"           "Sex"             
# [6] "PT_EOS_reason"    "PT_EOS_dt"        "treat_1"          "treat_2"          "treat_3"         
# [11] "treat_dt_1"       "treat_dt_2"       "treat_dt_3"   

# Once the first file column removed, it appears that 7 rows are duplicated.

table(duplicated(file_NR))
# FALSE  TRUE 
# 800     7 

# getting the PTID that have duplicated values
file_NR[duplicated(file_NR$PTID),"PTID"]
# PTID  
# <chr> 
#   1 PT-232
# 2 PT-431
# 3 PT-775
# 4 PT-649
# 5 PT-314
# 6 PT-158
# 7 PT-701

# This in confirmed in the fact that only 800 PTID / 807entry PTID are unique.
# 7 PTIDs have duplicated row.
n_distinct(file_NR$PTID)
# > n_distinct(file_NR$PTID)
# [1] 800

## labo_data
labo_data <- readxl::read_excel(.constants$file_paths$input_data_paths$labo_data)
# get the dimensions 
dim(labo_data)
# [1] 2400    5

# check for duplicates
table(duplicated(labo_data))
# FALSE 
# 2400 
n_distinct(file_NR$PTID)
# [1] 800

# Check the occurrence by patient
# for each PTID, there is 3 observations. 
# What makes sens 800 PTID * 3 = 2400 observations
count(labo_data, PTID) %>% filter(n != 3)
# A tibble: 0 × 2
# ℹ 2 variables: PTID <chr>, n <int>

## access_number
access_number <- readxl::read_excel(.constants$file_paths$input_data_paths$access_number)
dim(access_number)
# [1] 10  4
colnames(access_number)
# "PTID"            "access_number_1" "access_number_2" "access_number_3"
table(duplicated(access_number))
# FALSE 
# 10 
n_distinct(access_number$PTID)
# [1] 10

# Save the data within a RDS file. All table are stored in a list in order to 
# minimize the number of RDS file.
saveRDS(list("data_dictionary" = data_dictionary,
             "file_NR" = file_NR,
             "labo_data" = labo_data,
             "access_number" = access_number
             ), file = "0_parsed_data.RDS")