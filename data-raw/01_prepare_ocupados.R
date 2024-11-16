# Import functions -------------------------------------
source("data-raw/00_utils_data_raw.R")


# File list to process ---------------------------------
files <- list(

    # Ocupados por sexo, edad y comunidad autonoma
    list(
        file_ext = "", 
        name = "", 
        extra_transformations = list(

        )
    ), 
    # Ocupados por nivel de formacion, sexo y comunidad autonoma
    list(
        file_ext = "", 
        name = "", 
        extra_transformations = list(
            
        )
    ),
    # Ocupados por nacionaliadad, sexo y comunidad autonoma
    list(
        file_ext = "", 
        name = "", 
        extra_transformations = list(
            
        )
    ),
    # Ocupados porr sector economico, sexo y comunidad autonoma
    list(
        file_ext = "", 
        name = "", 
        extra_transformations = list(
            
        )
    ), 
    # Ocupados por rama de actividad, sexo y comunidad autonoma 
    list(
        file_ext = "", 
        name = "", 
        extra_transformations = list(
            
        )
    ), 
    #Ocupados por situacion profesional, sexo y comunidad autonoma
    list(
        file_ext = "", 
        name = "", 
        extra_transformations = list(
            
        )
    ), 
    #Ocupados por situacion profesional, sector economico, sexo y comunidad autonoma
    list(
        file_ext = "", 
        name = "", 
        extra_transformations = list(
            
        )
    ), 
    # Ocupados por tipo de jornada, sexo y comunidad autonoma
    list(
        file_ext = "", 
        name = "", 
        extra_transformations = list(
            
        )
    ), 
    # Ocupados por tipo de sector (pub vs priv), sexo y comunidad autonoma
    list(
        file_ext = "", 
        name = "", 
        extra_transformations = list(
            
        )
    ), 
    # Asalariados por edad, sexo y comunidad autonoma
    list(
        file_ext = "", 
        name = "", 
        extra_transformations = list(
            
        )
    ), 
    # Asalariados por sector economico, sexo y comunidad autonoma
    list(
        file_ext = "", 
        name = "", 
        extra_transformations = list(
            
        )
    ), 
    # Asalariados por tipo de sector (pub vs priv), sexo y comunidad autonoma
    list(
        file_ext = "", 
        name = "", 
        extra_transformations = list(
            
        )
    ), 
    # Asalariados por tipo de contrato, sexo y comunidad autonoma
    list(
        file_ext = "", 
        name = "", 
        extra_transformations = list(
            
        )
    ), 
    # Asalariados privados por tipo de contrato, sexo y comunidad autonoma
    list(
        file_ext = "", 
        name = "", 
        extra_transformations = list(
            
        )
    ), 
    # Asalariados publicos por tipo de contrato, sexo y comunidad autonoma
    list(
        file_ext = "", 
        name = "", 
        extra_transformations = list(
            
        )
    )
)


# Execute function ---------------------------------------
for (file in files) {
    proccess_file(
        file$file_ext, 
        file$name, 
        file$extra_transformations
    )
}


# Clean Global Environment --------------------------------
rm(list = ls())