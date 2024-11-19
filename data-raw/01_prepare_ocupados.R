# Import functions -------------------------------------
source("data-raw/00_utils_data_raw.R")


# File list to process ---------------------------------
files <- list(

    # Ocupados por sexo, edad y comunidad autonoma
    list(
        file_ext = "65302", 
        name = "ocupados_edad_sexo", 
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
    # Ocupados por nivel de formacion, sexo y comunidad autonoma
    list(
        file_ext = "65307", 
        name = "ocupados_formacion_sexo", 
        extra_transformations = list(
            function(df) {
                df |>   
                    dplyr::group_by(codauto, trimestre, sexo) |> 
                    dplyr::mutate(pct_by_ccaa = value / value[nivel_formacion == "Total"]) |>                     
                    dplyr::mutate(pct_by_ccaa = round(pct_by_ccaa * 100, 2)) |> 
                    dplyr::ungroup()
            }
        )
    ),
    # Ocupados por nacionaliadad, sexo y comunidad autonoma
    list(
        file_ext = "65309", 
        name = "ocupados_nacionalidad_sexo", 
        extra_transformations = list(
            function(df) {
                df |>   
                    dplyr::group_by(codauto, trimestre, sexo) |> 
                    dplyr::mutate(pct_by_ccaa = value / value[nacionalidad == "Total"]) |>                     
                    dplyr::mutate(pct_by_ccaa = round(pct_by_ccaa * 100, 2)) |> 
                    dplyr::ungroup()
            }  
        )
    ),
    # Ocupados por sector economico, sexo y comunidad autonoma
    list(
        file_ext = "65311", 
        name = "ocupados_sector_sexo", 
        extra_transformations = list(
            function(df) {
                df |> 
                    dplyr::group_by(codauto, trimestre, sexo) |> 
                    dplyr::mutate(pct_by_ccaa = value / value[sector_economico = "Total"]) |> 
                    dplyr::mutate(pct_by_ccaa = round(pct_by_ccaa * 100, 2)) |> 
                    dplyr::ungroup()
            }
        )
    ), 
    # Ocupados por rama de actividad, sexo y comunidad autonoma 
    list(
        file_ext = "65313", 
        name = "ocupados_rama_sexo", 
        extra_transformations = list(
            function(df) {
                df |> 
                    dplyr::group_by(codauto, trimestre, sexo) |> 
                    dplyr::mutate(pct_by_ccaa = value / value[rama_actividad = "Total"]) |> 
                    dplyr::mutate(pct_by_ccaa = round(pct_by_ccaa * 100, 2)) |> 
                    dplyr::ungroup()
            }
        )
    ), 
    # Ocupados por ocupacion, sexo y comunidad autonoma 
    list(
        file_ext = "65314",
        name = "ocupados_ocupacion_sexo", 
        extra_transformations = list(
            function(df) {
                df |> 
                    tidyr::separate(ocupacion, into = c("cod_ocupacion", "ocupacion"), sep = " ", extra = "merge") |> 
                    dplyr::mutate(ocupacion = ifelse(is.na(ocupacion), cod_ocupacion, ocupacion)) |> 
                    dplyr::mutate(cod_ocupacion = ifelse(cod_ocupacion == ocupacion, "0", cod_ocupacion)) |> 
                    dplyr::group_by(codauto, trimestre, sexo) |> 
                    dplyr::mutate(pct_by_ccaa = value / value[ocupacion == "Total"]) |> 
                    dplyr::mutate(pct_by_ccaa = round(value * 100, 2)) |> 
                    dplyr::ungroup()
            }
        )
    ),
    # Ocupados por situacion profesional, sexo y comunidad autonoma
    list(
        file_ext = "65316", 
        name = "ocupados_situacion_sexo", 
        extra_transformations = list(
            function(df) {
                df |> 
                    dplyr::group_by(codauto, trimestre, sexo) |> 
                    dplyr::mutate(pct_by_ccaa = value / value[situacion_profesional == "Total"]) |> 
                    dplyr::mutate(pct_by_ccaa = round(value * 100, 2)) |> 
                    dplyr::ungroup()
            }
        )
    ), 
    #Ocupados por situacion profesional, sector economico, sexo y comunidad autonoma
    list(
        file_ext = "65318", 
        name = "ocupados_situacion_sector_sexo", 
        extra_transformations = list(
            
        )
    ), 
    # Ocupados por tipo de jornada, sexo y comunidad autonoma
    list(
        file_ext = "65319", 
        name = "ocupados_jornada_sexo", 
        extra_transformations = list(
            function(df) {
                df |> 
                    tidyr::pivot_wider(names_from = Unidad, values_from = value) |> 
                    dplyr::rename(value = `Valor absoluto`, pct_by_ccaa = Porcentaje)
            }
        )
    ), 
    # Ocupados por tipo de sector (pub vs priv), sexo y comunidad autonoma
    list(
        file_ext = "65321", 
        name = "ocupados_tipo_sexo", 
        extra_transformations = list(
            function(df) {
                df |> 
                dplyr::group_by(codauto, trimestre, sexo) |> 
                dplyr::mutate(pct_by_ccaa = value / value[propiedad_sector == "Total"]) |> 
                dplyr::mutate(pct_by_ccaa = round(value * 100, 2)) |> 
                dplyr::ungroup()
            }
        )
    ), 
    # Asalariados por edad, sexo y comunidad autonoma
    list(
        file_ext = "65323", 
        name = "Asalariados_edad_sexo", 
        extra_transformations = list(
            
        )
    ), 
    # Asalariados por sector economico, sexo y comunidad autonoma
    list(
        file_ext = "65325", 
        name = "asalariados_sector_sexo", 
        extra_transformations = list(
            
        )
    ), 
    # Asalariados por tipo de sector (pub vs priv), sexo y comunidad autonoma
    list(
        file_ext = "65327", 
        name = "asalariados_tipo_sexo", 
        extra_transformations = list(
            
        )
    ), 
    # Asalariados por tipo de contrato, sexo y comunidad autonoma
    list(
        file_ext = "65328", 
        name = "asalariados_contrato_sexo", 
        extra_transformations = list(
            
        )
    ), 
    # Asalariados privados por tipo de contrato, sexo y comunidad autonoma
    list(
        file_ext = "65329", 
        name = "asalariados_priv_contrato_sexo", 
        extra_transformations = list(
            
        )
    ), 
    # Asalariados publicos por tipo de contrato, sexo y comunidad autonoma
    list(
        file_ext = "65330", 
        name = "asalariados_pub_contrato_sexo", 
        extra_transformations = list(
            
        )
    )
)


# Execute function ---------------------------------------
for (file in files) {
    process_file(
        file$file_ext, 
        file$name, 
        file$extra_transformations
    )
}


# Clean Global Environment --------------------------------
rm(list = ls())

load("data/ocupados_tipo_sexo.rda")
