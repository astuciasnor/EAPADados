#' Estações de Coleta de Ictiofauna na Costa do Pará (exemplo)
#'
#' @description
#' Conjunto de **exemplo** com estações de coleta de ictiofauna na costa norte do
#' Pará (região de Bragança, estuário do Caeté e Salgado paraense). As coordenadas
#' são plausíveis para a região; a CPUE (captura por unidade de esforço) e a
#' abundância são **sintéticas**, criadas para ilustrar os módulos de mapas de
#' **pontos, estações e bolhas proporcionais** e de **densidade** do ecossistema
#' EAPA. Serve para discutir plano amostral, cobertura espacial e magnitude
#' observada por local — a etapa "antes da análise".
#'
#' @format A data frame with 14 observations and 9 variables:
#' \describe{
#'   \item{id_estacao}{Identificador da estação (character; ex.: *E01*).}
#'   \item{latitude}{Latitude em graus decimais (numeric; negativa no Hemisfério Sul).}
#'   \item{longitude}{Longitude em graus decimais (numeric; negativa a Oeste).}
#'   \item{ano}{Ano da campanha (integer; 2023, 2024).}
#'   \item{campanha}{Período de coleta (factor; *Seca*, *Chuvosa*).}
#'   \item{ambiente}{Ambiente amostrado (factor; *Praia*, *Manguezal*, *Estuario*, *Plataforma*).}
#'   \item{especie}{Espécie-alvo (factor; *Pescada-amarela*, *Bagre*, *Robalo*).}
#'   \item{cpue}{Captura por unidade de esforço (numeric; ind./h — valores de exemplo).}
#'   \item{abundancia}{Número de indivíduos capturados (integer — valores de exemplo).}
#' }
#'
#' @source Conjunto didático de exemplo (EAPA). Coordenadas plausíveis da costa
#'   norte do Pará; CPUE e abundância sintéticas.
#' @docType data
#' @keywords datasets
#' @name estacoes_ictiofauna
#' @usage data(estacoes_ictiofauna)
#'
#' @examples
#' data(estacoes_ictiofauna)
#' summary(estacoes_ictiofauna)
#'
#' # Mapa simples de estações, com o tamanho do ponto pela CPUE (requer ggplot2)
#' if (requireNamespace("ggplot2", quietly = TRUE)) {
#'   ggplot2::ggplot(estacoes_ictiofauna,
#'                   ggplot2::aes(x = longitude, y = latitude,
#'                                size = cpue, color = ambiente)) +
#'     ggplot2::geom_point(alpha = 0.8) +
#'     ggplot2::labs(title = "Estações de coleta e CPUE — costa do Pará",
#'                   x = "Longitude", y = "Latitude", size = "CPUE", color = "Ambiente") +
#'     ggplot2::coord_fixed()
#' }
#'
NULL
