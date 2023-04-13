source(file = file.path("R_sources", "03_functions.R"))
################################################################################
##From the saved RDS containing the data, derivations such as homogenization of
# dates format, addition of the age of patient variable (PT_age), the removal
# of duplicated rows and the computation of NA% for each variable.
################################################################################


## file_NR

# All the variable containing data are transformed into dates class with the format:
# YYYY.DD.MM.
# The age of the patient is computed by making the difference between the current
# year (2023) and the PT_DOB variable (patient date of birth).
# The distinct() function use allows to get rid of the duplicates identified sooner.
file_NR <- readRDS("0_parsed_data.RDS")[["file_NR"]] %>%
  mutate_at(vars(PT_enrollment_dt, PT_DOB, treat_dt_1, treat_dt_2, treat_dt_3,
                 PT_EOS_dt), as.Date) %>%
  mutate(PT_AGE = get_PT_age(PT_DOB)) %>%
  dplyr:::distinct()


## labo_data

# variable analysis_dt is transformed from chr class to data class
labo_data <- readRDS("0_parsed_data.RDS")[["labo_data"]] %>%
  mutate(analysis_dt = as.Date(analysis_dt))

## access_number 

# Variable date_1, date_2, date_3 are derived from their respective corresponding
# access_number_n variable. It allows to keep the initial variable and to obtain
# the wished dates. 
access_number <- readRDS("0_parsed_data.RDS")[["access_number"]] %>%
  mutate(
    date_1 = format_access_number_dates(access_number_1),
    date_2 = format_access_number_dates(access_number_2),
    date_3 = format_access_number_dates(access_number_3))
write_xlsx(access_number, path = .constants$file_paths$output_data_paths$access_number_final, col_names = TRUE)


# Addition to the dictionnary of the age of patient variable computed before.
# for conveniance and to ease the data merging lated. The colmn name "column name"
# is renamed VARIABLE.
data_dictionary <- readRDS("0_parsed_data.RDS")[["data_dictionary"]] %>%
  add_row('Column Name' = "PT_AGE", Format = "numeric", Values = "Number of years",
          Definition = "Age of the patient computed from PT_DOB") %>%
  rename(VARIABLE = `Column Name`)

# merge of clinical and lab data : 
full_data <- left_join(file_NR, labo_data, by = "PTID")
  write_xlsx(full_data, path = .constants$file_paths$output_data_paths$merged_final_data, col_names = TRUE)

# get the NA percentageand add it (store the results) into data_dictionnary
# the % of NA value by variable is stored in the column named NA_percentage 
data_dictionary_final <- get_NA_percent_per_column(full_data) %>% 
  right_join(data_dictionary) 
  write_xlsx(data_dictionary_final, path = .constants$file_paths$output_data_paths$updated_data_dictionary, col_names = TRUE)


 