#' Dados de biometria de Caranguejos Capturados no Município de Bragança, PA
#'
#' @description
#' Conjunto de dados reais com medidas de largura e comprimento da carapaça
#' de caranguejos capturados em Bragança (PA, Brasil). Foram coletos indivíduos
#' machos e fêmeas, nas estações Seca e Chuvosa, nas localidades de
#' Ajuruteua e Caratateua. Pode ser usado para demonstrações de análise de
#' variância, regressão linear, tabelas de contingência e visualizações gráficas.
#'
#' @format A data frame with 993 observations and 5 variables:
#' \describe{
#'   \item{Local}{Local de captura (factor; *Ajuruteua*, *Caratateua*).}
#'   \item{Estacao}{Estação do ano (factor; *Seca*, *Chuvosa*).}
#'   \item{Sexo}{Sexo do indivíduo (factor; *Macho*, *Fêmea*).}
#'   \item{LC}{Largura da Carapaça em milímetros (numeric).}
#'   \item{CC}{Comprimento da Carapaça em milímetros (numeric).}
#' }
#'
#' @source Dados coletados em estudo de campo no município de Bragança, PA, Brasil.
#' @docType data
#' @keywords datasets
#' @name biometria_caranguejos
#' @usage data(biometria_caranguejos)
#'
#' @examples
#' data(biometria_caranguejos)
#' summary(biometria_caranguejos)
#' table(biometria_caranguejos$Local, biometria_caranguejos$Estacao)
#'
#' if (requireNamespace("ggplot2", quietly = TRUE)) {
#'   ggplot2::ggplot(biometria_caranguejos,
#'                   ggplot2::aes(x = LC, y = CC, color = Sexo)) +
#'     ggplot2::geom_point() +
#'     ggplot2::labs(
#'       title = "Relação entre Largura e Comprimento da Carapaça por Sexo",
#'       x = "Largura da Carapaça (mm)",
#'       y = "Comprimento da Carapaça (mm)"
#'     )
#' }
#'
"biometria_caranguejos"

