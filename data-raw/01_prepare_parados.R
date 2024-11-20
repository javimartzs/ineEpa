# Import functions -------------------------------------
source("data-raw/00_utils_data_raw.R")


# File list to proccess --------------------------------
files <- list(
    # Parados por sector econmomico y comunidad autonoma 
    list(
        file_ext = "65331", 
        name = "paro_sector", 
        extra_transformations = list(
            function(df) {
                df |> 
                    dplyr::group_by(codauto, trimestre) |> 
                    dplyr::mutate(pct_by_ccaa = value / value[sector_economico == "Total"]) |> 
                    dplyr::mutate(pct_by_ccaa = round(value * 100, 2)) |> 
                    dplyr::ungroup()
            }
        )
    ), 
    # Parados por edad, sexo y comunidad autonoma
    list(
        file_ext = "65332", 
        name = "paro_edad", 
        extra_transformations = list(
            function(df) {
                df |> 
                    dplyr::group_by(codauto, trimestre, sexo) |> 
                    dplyr::mutate(pct_by_ccaa = value / value[edad == "Total"]) |> 
                    dplyr::mutate(pct_by_ccaa = round(value * 100, 2)) |> 
                    dplyr::ungroup()
            }
        )
    ), 
    # Tasa de paro por edad, sexo y comunidad autonoma
    list(
        file_ext = "65334", 
        name = "tasaparo_edad", 
        extra_transformations = list(

        )
    ), 
    # Tasa de paro por nacionalidad, sexo y comunidad autonoma
    list(
        file_ext = "65336", 
        name = "tasaparo_nacionalidad", 
        extra_transformations = list(

        )
    ), 
    # Parados por nivel de formacion, sexo y comunidad autonoma, 
    list(
        file_ext = "65337", 
        name = "paro_formacion", 
        extra_transformations = list(
            function(df) {
                df |> 
                    dplyr::group_by(codauto, trimestre, sexo) |> 
                    dplyr::mutate(pct_by_ccaa = value / value[nivel_formacion == "Total"]) |> 
                    dplyr::mutate(pct_by_ccaa = round(value * 100, 2)) |> 
                    dplyr::ungroup()
            }
        )
    ), 
    # Parados por tiempo de busqueda, sexo y comunidad autonoma 
    list(
        file_ext = "65339", 
        name = "paro_busqueda", 
        extra_transformations = list(
            function(df) {
                df |> 
                    dplyr::group_by(codauto, trimestre, sexo) |> 
                    dplyr::mutate(pct_by_ccaa = value / value[tiempo_busqueda == "Total"]) |> 
                    dplyr::mutate(pct_by_ccaa = round(value * 100, 2)) |> 
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

load("data/paro_busqueda.rda")