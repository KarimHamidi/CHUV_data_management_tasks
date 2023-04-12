################################################################################
## User defined functions use to treat or transform the data
#  These functions are tested in 06_tests.R source.
################################################################################

# Function to format raw date format to Date class variable.
# the chosen output date format is "%Y%d%m"
format_access_number_dates <- function(raw_date){
  raw_date = substr(raw_date, 1,7)
  raw_date = gsub('_', '', raw_date)
  raw_date = ifelse(is.na(raw_date), raw_date, paste0("20", raw_date))

    as.Date(raw_date,"%Y%d%m") 
}

# Function that compute the age of the patient. The age is determined by
# subtracting the year of patient birth-date to the current year. Allow the derivation
# of PT_AGE variable
get_PT_age <- function(birth_date){
  current_year <- as.Date(now(tzone = ""))
  year(current_year) - year(birth_date)
  
}  

# Function which compute the percentage of NA for each columns of a data frame
# First the percentage is computed for each column and store in a numeric class object
# The results are then format as a dataframe. 
get_NA_percent_per_column <- function(dataframe) {

  NA_percent <- apply(dataframe, 2, function(col)sum(is.na(col))*100/length(col))

  result_table <- data.frame("VARIABLE" = names(NA_percent), "NA_percentage" = unlist(NA_percent))
  row.names(result_table) <- NULL
  
  result_table
  }