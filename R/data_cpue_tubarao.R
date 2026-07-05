#' CPUE de Tubarão por Ano (1995–2007)
#'
#' @description
#' Captura por unidade de esforço (CPUE) de tubarão registrada por embarcação,
#' mês e ano, entre 1995 e 2007. **Dados reais** (fonte e créditos a completar).
#' É um conjunto de dupla utilidade no ecossistema EAPA: serve de exemplo
#' canônico para o **teste de Kruskal-Wallis** (comparar a CPUE entre os anos,
#' com pós-teste de Dunn e letras de significância) e para **análise de série
#' temporal** (CPUE ao longo do tempo, via a coluna `Data`). A CPUE varia
#' fortemente entre os anos, com tendência de queda ao longo do período.
#'
#' @format A data frame with 424 observations and 5 variables:
#' \describe{
#'   \item{Vessel}{Embarcação (factor; *MB*, *MC*, *SB*).}
#'   \item{Year}{Ano do registro (integer; 1995 a 2007).}
#'   \item{Month}{Mês do registro (integer; 1 a 12).}
#'   \item{CPUE}{Captura por unidade de esforço (numeric).}
#'   \item{Data}{Data do registro (Date).}
#' }
#'
#' @source Dados reais de monitoramento pesqueiro (fonte e créditos a completar).
#' @docType data
#' @keywords datasets
#' @name cpue_tubarao
#' @usage data(cpue_tubarao)
#'
#' @examples
#' data(cpue_tubarao)
#' summary(cpue_tubarao)
#'
#' # Kruskal-Wallis: a CPUE difere entre os anos? (requer rstatix)
#' if (requireNamespace("rstatix", quietly = TRUE)) {
#'   dados <- subset(cpue_tubarao, CPUE <= 28)
#'   dados$Year <- factor(dados$Year)
#'   rstatix::kruskal_test(dados, CPUE ~ Year)
#' }
#'
#' # Série temporal simples da CPUE (requer ggplot2)
#' if (requireNamespace("ggplot2", quietly = TRUE)) {
#'   ggplot2::ggplot(cpue_tubarao, ggplot2::aes(x = Data, y = CPUE)) +
#'     ggplot2::geom_line(color = "grey70") +
#'     ggplot2::geom_smooth(se = FALSE, color = "#0F3B5F") +
#'     ggplot2::labs(title = "CPUE de tubarão ao longo do tempo", x = NULL, y = "CPUE")
#' }
#'
NULL
