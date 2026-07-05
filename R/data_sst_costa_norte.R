#' Grade Ambiental da Costa Norte — TSM, Clorofila e Profundidade (exemplo)
#'
#' @description
#' Conjunto de **exemplo** representando variáveis ambientais numa **grade
#' regular** de longitude/latitude sobre a costa norte do Brasil (litoral do
#' Pará): temperatura da superfície do mar (TSM), clorofila-a e profundidade.
#' Os valores são **sintéticos**, criados para ilustrar o módulo de **mapa
#' raster/contorno ambiental** do ecossistema EAPA — como o ambiente varia no
#' espaço e como isso ajuda a interpretar a pesca e a aquicultura. **Não** são
#' medições reais nem produto de sensoriamento remoto.
#'
#' @format A data frame with 204 observations and 5 variables (grade 17 × 12):
#' \describe{
#'   \item{lon}{Longitude do centro da célula, em graus decimais (numeric).}
#'   \item{lat}{Latitude do centro da célula, em graus decimais (numeric).}
#'   \item{sst}{Temperatura da superfície do mar, em graus Celsius (numeric; °C).}
#'   \item{clorofila}{Concentração de clorofila-a (numeric; mg/m³).}
#'   \item{profundidade}{Profundidade, em metros (numeric; m).}
#' }
#'
#' @source Conjunto didático de exemplo (EAPA). Grade e valores sintéticos,
#'   plausíveis para o litoral do Pará.
#' @docType data
#' @keywords datasets
#' @name sst_costa_norte
#' @usage data(sst_costa_norte)
#'
#' @examples
#' data(sst_costa_norte)
#' summary(sst_costa_norte)
#'
#' # Mapa raster da TSM com linhas de contorno (requer ggplot2)
#' if (requireNamespace("ggplot2", quietly = TRUE)) {
#'   ggplot2::ggplot(sst_costa_norte, ggplot2::aes(x = lon, y = lat)) +
#'     ggplot2::geom_raster(ggplot2::aes(fill = sst)) +
#'     ggplot2::geom_contour(ggplot2::aes(z = sst), color = "white", alpha = 0.5) +
#'     ggplot2::scale_fill_viridis_c(name = "TSM (°C)") +
#'     ggplot2::coord_fixed() +
#'     ggplot2::labs(title = "Temperatura da superfície do mar (exemplo)",
#'                   x = "Longitude", y = "Latitude")
#' }
#'
NULL
