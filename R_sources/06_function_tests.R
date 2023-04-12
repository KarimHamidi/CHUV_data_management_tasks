source(file = file.path("R_sources", "03_functions.R"))
################################################################################
## test of user designed functions. The testing principle is to compare expected
## function results and results obtained.It must have No difference between the 
## expected output and the actual one (numeric(0)).
################################################################################


# format_access_number_dates testing
dates_test <- c("21_3010_6790", "19_2612_546", "19_1911_7397", NA)
expected_result <- ydm(c("2021-30-10", "2019-26-12","2019-19-11", NA))
results <- format_access_number_dates(dates_test)
setdiff(expected_result, results)
# numeric(0)
setdiff(results, expected_result)
# numeric(0)

# get_PT_age
expected_results <- c(55, 37, 39, NA)
input <- as.Date(c("1968-09-25", "1986-05-22", "1984-03-03", NA))
results <- get_PT_age(input)
setdiff(results, expected_results)
# numeric(0)
setdiff(results, expected_results)
# numeric(0)


# get_NA_percent_per_column
crash_df <- tribble(
  ~x, ~y,  ~z,
  "a", NA,  NA,
  "b", 1,  NA,
  "c", 5, 9.5)
expected_result <- c(0, (1/3)*100, (2/3)*100)
result <- get_NA_percent_per_column(crash_df)
# > result$NA_percentage 
# [1]  0.00000 33.33333 66.66667
# > expected_result
# [1]  0.00000 33.33333 66.66667