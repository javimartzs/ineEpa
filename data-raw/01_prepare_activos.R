# Import functions -------------------------------------
source("data-raw/00_utils_data_raw.R")


# File list to proccess --------------------------------
files <- list(
    # Población por edad, sexo y comunidad autonoma
    list(
        file_ext = "65285", 
        name = "poblacion_edad_sexo", 
        extra_transformations = list(

            # Calculate percentage by ccaa
            function(df) {
                df |> 
                dplyr::group_by(codauto, sexo, trimestre) |> 
                dplyr::mutate(pct_by_ccaa = value / value[edad=="Total"]) |> 
                dplyr::ungroup()
            }
        )
    ), 
    # Poblacion por nacionalidad, sexo y comunidad autonoma 
    list(
        file_ext = "65287", 
        name = "poblacion_nacionalidad_sexo", 
        extra_transformations = list(

            # Calculate percentage by ccaa
            function(df) {
                df |> 
                    dplyr::group_by(codauto, trimestre, sexo) |> 
                    dplyr::mutate(pct_by_ccaa = value / value[nacionalidad == "Total"]) |> 
                    dplyr::ungroup()
            }
        )
    ), 
    # Poblacion mayor de 16 por formacion, sexo y comunidad autonoma
    list(
        file_ext = "65288", 
        name = "poblacion_adultos_formacion_sexo", 
        extra_transformations = list(

            # Calculate percentage by ccaa
            function(df) {
                df |> 
                    dplyr::group_by(codauto, trimestre, sexo) |> 
                    dplyr::mutate(pct_by_ccaa = value / value[nivel_formacion == "Total"]) |> 
                    dplyr::ungroup()
            }
        )
    ), 
    # Activos por sexo, edad y comunidad autonoma 
    list(
        file_ext = "65293", 
        name = "activos_edad_sexo", 
        extra_transformations = list(

            # Calculate percentage by ccaa
            function(df) {
                df |> 
                    dplyr::group_by(codauto, trimestre, sexo) |> 
                    dplyr::mutate(pct_by_ccaa = value / value[edad == "Total"]) |> 
                    dplyr::ungroup()
            }
        )
    ), 
    # Activos por formacion, sexo y comunidad autonoma 
    list(
        file_ext = "65297", 
        name = "activos_formacion_sexo", 
        extra_transformations = list(

            # Calculate percentage by ccaa
            function(df) {
                df |> 
                    dplyr::group_by(codauto, trimestre, sexo) |> 
                    dplyr::mutate(pct_by_ccaa = value / value[nivel_formacion == "Total"]) |> 
                    dplyr::ungroup()
            }
        )
    ), 
    # Activos por nacionalidad, sexo y comunidad autonoma
    list(
        file_ext = "65299", 
        name = "activos_nacionalidad_sexo", 
        extra_transformations = list(

            # Calculate percentage by ccaa
            function(df) {
                df |> 
                    dplyr::group_by(codauto, trimestre, sexo) |> 
                    dplyr::mutate(pct_by_ccaa = value / value[nacionalidad == "Total"]) |> 
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
