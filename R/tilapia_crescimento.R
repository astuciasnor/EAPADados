#' Dados de Crescimento de Tilápias sob Diferentes Tratamentos
#' @description Conjunto de dados simulado contendo o peso médio semanal de tilápias
#' submetidas a três formulações de ração ao longo de dez semanas.
#' Útil para exemplificar ANOVA de medidas repetidas ou ajustes de curvas
#' de crescimento.
#' @format Um data frame com 30 observações e 4 variáveis:
#' \describe{
#'   \item{Tratamento}{Tratamento de ração (fator: A, B, C).}
#'   \item{Semana}{Semana de coleta (inteiro, 1–10).}
#'   \item{PesoMedio}{Peso médio por tratamento na semana (g; numérico).}
#'   \item{DataColeta}{Data da coleta (classe \code{Date}).}
#' }
#' @source Dados simulados para o livro *Estatística Aplicada à Pesca e Aquicultura com R*.
#' @docType data
#' @keywords datasets
#' @name tilapia_crescimento
#' @usage data(tilapia_crescimento)
#' @examples
#' data(tilapia_crescimento)
#' summary(tilapia_crescimento)
#'
#' if (requireNamespace("ggplot2", quietly = TRUE)) {
#'   ggplot2::ggplot(tilapia_crescimento,
#'                   ggplot2::aes(Semana, PesoMedio, colour = Tratamento)) +
#'     ggplot2::geom_line() +
#'     ggplot2::geom_point() +
#'     ggplot2::labs(title = "Crescimento de Tilápias por Tratamento",
#'                   x = "Semana", y = "Peso médio (g)")
#' }
"tilapia_crescimento"
