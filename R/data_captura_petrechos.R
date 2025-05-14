#' Dados de Captura por Aparelho de Pesca e Espécie
#' @description Conjunto de dados simulado com a Captura por Unidade de Esforço (CPUE)
#' de diferentes espécies de peixes obtidas por distintos aparelhos de pesca.
#' Pode ser usado para demonstrar tabelas de contingência, testes de associação
#' ou modelos lineares generalizados (p.ex. Poisson para contagens).
#' @format Um data frame com 50 observações e 3 variáveis:
#' \describe{
#'   \item{Especie}{Espécie capturada (fator; p.ex. *Sardinha*, *Corvina*, *Pescada*).}
#'   \item{Petrecho}{Aparelho de pesca utilizado (fator; p.ex. Rede de Emalhe, Arrasto de Fundo, Linha de Anzol).}
#'   \item{CPUE}{Captura por unidade de esforço — número de indivíduos por hora de pesca ou por lance (inteiro).}
#' }
#' @source Dados simulados para o livro *Estatística Aplicada à Pesca e Aquicultura com R*.
#' @docType data
#' @keywords datasets
#' @name captura_petrechos
#' @usage data(captura_petrechos)
#' @examples
#' data(captura_petrechos)
#' summary(captura_petrechos)
#'
#' table(captura_petrechos$Especie, captura_petrechos$Petrecho)
#'
#' if (requireNamespace("ggplot2", quietly = TRUE)) {
#'   ggplot2::ggplot(captura_petrechos,
#'                   ggplot2::aes(x = Especie, y = CPUE, fill = Petrecho)) +
#'     ggplot2::geom_boxplot() +
#'     ggplot2::labs(title = "CPUE por Espécie e Aparelho de Pesca",
#'                   x = "Espécie",
#'                   y = "CPUE (nº de indivíduos)")
#' }
"captura_petrechos"
