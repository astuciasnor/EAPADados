#' Dados de Contagem de Camarões por Sexo e Espécie
#'
#' @description Conjunto de dados representando a contagem de indivíduos
#' de duas espécies de camarões classificados por sexo. Ideal para exemplificar
#' o teste do qui-quadrado de independência em tabelas de contingência.
#'
#' @format Um data frame com 170 observações e 2 variáveis:
#' \describe{
#'   \item{sexo}{Sexo do camarão (fator: Macho, Fêmea).}
#'   \item{especie}{Espécie do camarão (fator: \emph{P. brasiliensis}, \emph{P. schmitti}).}
#' }
#'
#' @source Dados reais extraídos de livro (referência a ser adicionada posteriormente).
#'
#' @docType data
#' @keywords datasets
#' @name camaroes_sexo
#' @usage data(camaroes_sexo)
#'
#' @examples
#' data(camaroes_sexo)
#' # resumo e teste χ²
#' table(camaroes_sexo$sexo, camaroes_sexo$especie) |>
#'   chisq.test()
#'
#' if (requireNamespace("ggplot2", quietly = TRUE)) {
#'   ggplot2::ggplot(camaroes_sexo,
#'                   ggplot2::aes(x = especie, fill = sexo)) +
#'     ggplot2::geom_bar(position = "dodge") +
#'     ggplot2::labs(title = "Distribuição de Sexo por Espécie de Camarão")
#' }
"camaroes_sexo"
