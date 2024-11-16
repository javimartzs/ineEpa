# Import functions -------------------------------------
source("data-raw/00_utils_data_raw.R")


# File list to proccess --------------------------------
files <- list(
    # Población por edad, sexo y comunidad autonoma
    list(
        file_ext = "65285", 
        name = "poblacion_edad_sexo", 
        extra_transformations = list(

            # Rename variables
            function(df) dplyr::rename(df, 
                edad = Edad, 
                sexo = Sexo
            ),

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

            # Rename variable
            function(df) dplyr::rename(df, 
                nacionalidad = Nacionalidad, 
                sexo = Sexo
            ), 

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

            # Rename variables
            function(df) dplyr::rename(df, 
                nivel_formativo = Nivel.de.formación.alcanzado, 
                sexo = Sexo
            ), 

            # Calculate percentage by ccaa
            function(df) {
                df |> 
                    dplyr::group_by(codauto, trimestre, sexo) |> 
                    dplyr::mutate(pct_by_ccaa = value / value[nivel_formativp == "Total"])
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
