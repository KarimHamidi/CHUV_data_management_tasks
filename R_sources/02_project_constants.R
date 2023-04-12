source(file = file.path("R_sources", "01_setup.R"))
################################################################################
## The current R source creates a list of lists containing constants related
## to the data management task. It allows to access these constants calling the 
## list and avoid hardcoding paths or information relative to data dimensions.
## calling .constants allows to access this list easily during any DM steps.
## Constants relative to dimensions can be used to check, test and ensure data
## integritiy
################################################################################


.constants <- list(
  
  file_paths = list(

    input_data_paths = list(
      access_number = file.path("input_data", "DM_access_number_FM.xlsx"),
      data_dictionary = file.path("input_data", "DM_data_dictionary.xlsx"),
      file_NR = file.path("input_data", "DM_file_NR.xlsx"),
      labo_data = file.path("input_data", "DM_labo_data_NR.xlsx")),
      
      output_data_paths = list(
        merged_final_data = file.path("output_data", "clinical_lab_data.xlsx"),
        updated_data_dictionary = file.path("output_data", "data_dictionary.xlsx"),
        access_number_final = file.path("output_data", "access_number_final.xlsx")
      )), 
    
    data_constants = list(
      data_dictionnary = list(
        NROW = 13L
      ),
      file_NR = list(
        NROW = 807L,
        NPTID = 800L,
        DUPLICATED_ROWS = 7L, 
        DUPLICATED_PTID = c("PT-232", "PT-431", "PT-775", "PT-649", "PT-314",
                            "PT-158", "PT-701")
      ),
      labo_data = list(
        NROW = 2400L,
        NPTID = 800L
      ),
      access_number = list(
        NROW = 10L,
        NPTID = 10L
        
      )
    )
    
)



