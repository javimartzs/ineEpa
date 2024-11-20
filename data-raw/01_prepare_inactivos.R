# Import functions -------------------------------------
source("data-raw/00_utils_data_raw.R")


# File list to proccess --------------------------------
files <- list(
    # Inactivos por edad, sexo y comunidad autonoma 
    list(
        file_ext = "65341", 
        name = "inactivos_edad", 
        extra_transformations = list(
            function(df) {
                df |> 
                    dplyr::group_by(codauto, trimestre, sexo) |> 
                    dplyr::mutate(pct_by_ccaa = value / value[edad == 'Total']) |> 
                    dplyr::mutate(pct_by_ccaa = round(pct_by_ccaa * 100, 2)) |> 
                    dplyr::ungroup()
            }
        )
    ), 
    # Inactivos por clase de inactividad, sexo y comunidad autonoma
    list(
        file_ext = "65343", 
        name = "inactivos_clase", 
        extra_transformations = list(
            function(df) {
                df |> 
                    dplyr::group_by(codauto, trimestre, sexo) |> 
                    dplyr::mutate(pct_by_ccaa = value / value[clase_inactividad == 'Total']) |> 
                    dplyr::mutate(pct_by_ccaa = round(pct_by_ccaa * 100, 2)) |> 
                    dplyr::ungroup()
            }
        )
    )
)


# Execute function ---------------------------------------
for (file in files) {
    process_file(
        file$file_ext, 
        file$name, 
        file$extra_transformations)
}

# Remove all objects from Global Environment -------------
rm(list = ls())
