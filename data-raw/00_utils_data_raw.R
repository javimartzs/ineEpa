
# Install packages if they are not installed -----------
pks <- c("glue", "dplyr", "tidyr", "stringr")
for (pk in pks) {
    if (!requireNamespace(pk, quietly = TRUE)) {
        install.packages(pk, character.only = TRUE)
    }
}

# Fetch data function ----------------------------------
fetch_data <- function(file_ext, name) {

    # Build url to download file 
    url <- glue::glue("https://www.ine.es/jaxiT3/files/t/es/px/{file_ext}.px")

    # Download file 
    data <- suppressWarnings(pxR::read.px(url))
    data <- as.data.frame(data)

    # Info 
    message(glue::glue("{name} file has been downloaded"))
    return(data)
}


# Clean data function -----------------------------------
clean_data <- function(data, name, extra_transformations = list()) {

    # Combine common and extra transformations 
    transformations <- c(common_transformations, extra_transformations)

    # Apply transformations
    cleaned_data <- data
    for (transformation in transformations) {
        cleaned_data <- transformation(cleaned_data)
    } 

    # Information
    message(glue::glue("{name} has been cleanned"))
    return(cleaned_data)
}

# Save data function -------------------------------------
save_data <- function(cleaned_data, name) {

    # Create dir if not exists
    if (!dir.exists("data")) {
        dir.create("data", recursive = TRUE, showWarnings = FALSE)
    }

    # Build data directory
    file_path <- file.path("data", glue::glue("{name}.rda"))

    # Save the object
    assign(name, cleaned_data)
    save(list = name, file = file_path, compress = "xz")

    # Information
    message(glue::glue("{name} has been saved"))

}



common_transformations <- list(

    function(df) dplyr::filter(df, !is.na(Periodo)),
    function(df) dplyr::mutate(df, 
        Periodo = stringr::str_replace_all(Periodo, c("T4" = "-10", "T3" = "-7", "T2" = "-4", "T1" = "-1"))),
    function(df) dplyr::mutate(df, trimestre = lubridate::ym(Periodo)),
    function(df) dplyr::select(df, -Periodo),
    function(df) tidyr::separate(df, Comunidades.y.Ciudades.Autónomas, into = c("codauto", "ccaa"), sep = 3),
    function(df) dplyr::mutate(df, codauto = ifelse(stringr::str_detect(codauto, "Tot"), "00", codauto)), 
    function(df) dplyr::mutate(df, ccaa = ifelse(codauto == "00", "Total Nacional", ccaa)), 
    function(df) dplyr::mutate(df, codauto = stringr::str_trim(codauto)),

    # Rename variables 
    function(df) {
        renames <- list(
            Edad = "edad", 
            Sexo = "sexo", 
            Nacionalidad = "nacionalidad", 
            `Nivel.de.formación.alcanzado` = "nivel_formacion", 
            `Sector.económico` = "sector_economico", 
            `Rama.de.actividad.CNAE.2009` = "rama_actividad", 
            `Ocupación.CNO.11` = "ocupacion", 
            `Situación.profesional` = "situacion_profesional", 
            `Tipo.de.jornada` = "jornada", 
            `Tipo.de.sector` = "propiedad_sector"
        )
        for (col in names(renames)) {
            if (col %in% names(df)) {
                df <- dplyr::rename(df, !!renames[[col]] := !!col)
            }
        }
        return(df)
    }
)

# Function to process files ------------------------------
process_file <- function(file_ext, name, extra_transformations) {
    # Download data 
    data <- fetch_data(
        file_ext = file_ext, 
        name = name)

    # Clean data 
    cleaned_data <- clean_data(
        data, 
        name = name, 
        extra_transformations = extra_transformations)

    # Save data 
    save_data(
        cleaned_data, 
        name = name)
}


# Remove pk objects ---------------------------------------
rm(pks, pk)
