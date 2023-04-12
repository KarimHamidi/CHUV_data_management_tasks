source(file = file.path("R_sources", "02_project_constants.R"))
################################################################################
# 
#
################################################################################
# load data
clinical_lab_data <- read_xlsx(.constants$file_paths$output_data_paths$merged_final_data)
dictionary <- read_xlsx(.constants$file_paths$output_data_paths$updated_data_dictionary)

# check cardinality
isTRUE(nrow(clinical_lab_data) == .constants$data_constants$labo_data$NROW)
# [1] TRUE
isTRUE(n_distinct(clinical_lab_data$PTID) == .constants$data_constants$labo_data$NPTID)
# [1] TRUE
# check duplicates
table(duplicated(clinical_lab_data))
# FALSE 
# 2400 
# one row was added to the dictionary (PT_AGE)
isTRUE(nrow(dictionary) == .constants$data_constants$data_dictionnary$NROW + 1)
# [1] TRUE
table(duplicated(dictionary))
# FALSE 
# 14
