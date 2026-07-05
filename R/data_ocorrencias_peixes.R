#' Ocorrências de Peixes na Costa do Pará (exemplo, muitos pontos)
#'
#' @description
#' Conjunto de **exemplo** com muitos registros de ocorrência de peixes na costa
#' norte do Pará, em dois agrupamentos espaciais (um no estuário, outro na
#' plataforma). As coordenadas são **sintéticas**, criadas para ilustrar o módulo
#' de **mapa de densidade/heatmap** do ecossistema EAPA — onde os registros se
#' concentram. Serve para discutir concentração espacial e, sobretudo, o **viés de
#' esforço amostral** (mais registros podem significar mais coleta, não mais peixe).
#'
#' @format A data frame with 125 observations and 5 variables:
#' \describe{
#'   \item{id}{Identificador do registro (integer).}
#'   \item{longitude}{Longitude em graus decimais (numeric; negativa a Oeste).}
#'   \item{latitude}{Latitude em graus decimais (numeric; negativa no Hemisfério Sul).}
#'   \item{especie}{Espécie registrada (factor; *Pescada-amarela*, *Camarao-rosa*).}
#'   \item{ano}{Ano do registro (integer; 2023, 2024).}
#' }
#'
#' @source Conjunto didático de exemplo (EAPA). Coordenadas sintéticas plausíveis
#'   para o litoral do Pará.
#' @docType data
#' @keywords datasets
#' @name ocorrencias_peixes
#' @usage data(ocorrencias_peixes)
#'
#' @examples
#' data(ocorrencias_peixes)
#' summary(ocorrencias_peixes)
#'
#' # Heatmap de densidade (requer ggplot2)
#' if (requireNamespace("ggplot2", quietly = TRUE)) {
#'   ggplot2::ggplot(ocorrencias_peixes,
#'                   ggplot2::aes(x = longitude, y = latitude)) +
#'     ggplot2::geom_bin2d(bins = 25) +
#'     ggplot2::scale_fill_viridis_c(name = "Nº de registros") +
#'     ggplot2::coord_fixed() +
#'     ggplot2::labs(title = "Concentração de ocorrências (exemplo)",
#'                   x = "Longitude", y = "Latitude")
#' }
#'
NULL
