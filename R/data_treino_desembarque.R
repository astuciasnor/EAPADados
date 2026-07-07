#' Desembarque Pesqueiro em Formato Largo (dados de treino)
#'
#' @description
#' Conjunto **sintético** de treino, criado para aprender a **arrumar dados** no
#' ecossistema EAPA. Imita um relatório de desembarque pesqueiro em **formato
#' largo** (*wide*): para cada ano de 2021 a 2023 há duas colunas de medida,
#' `"AAAA - Captura_t"` e `"AAAA - Receita_mil"`. O ano e a métrica estão presos
#' no **nome** da coluna — exatamente o defeito que se resolve empilhando os
#' dados. É o conjunto-exercício do capítulo *"Preparando os dados"* (Unidade II)
#' e do menu **Empilhar Colunas (Largo → Longo)** da IDE CatalyseR: pratica-se
#' `pivot_longer()` com extração por regex e, em seguida, `pivot_wider()`.
#' Valores fictícios, plausíveis para a pesca amazônica.
#'
#' @format A data frame with 12 observations and 8 variables:
#' \describe{
#'   \item{Porto}{Porto de desembarque (character; Bragança, Vigia, Belém, Augusto Corrêa).}
#'   \item{Especie}{Espécie desembarcada (character; Pargo, Serra, Pescada).}
#'   \item{2021 - Captura_t}{Captura de 2021, em toneladas (numeric).}
#'   \item{2021 - Receita_mil}{Receita de 2021, em milhares de reais (numeric).}
#'   \item{2022 - Captura_t}{Captura de 2022, em toneladas (numeric).}
#'   \item{2022 - Receita_mil}{Receita de 2022, em milhares de reais (numeric).}
#'   \item{2023 - Captura_t}{Captura de 2023, em toneladas (numeric).}
#'   \item{2023 - Receita_mil}{Receita de 2023, em milhares de reais (numeric).}
#' }
#'
#' @source Dados sintéticos gerados para fins didáticos (ecossistema EAPA).
#' @docType data
#' @keywords datasets
#' @name treino_desembarque
#' @usage data(treino_desembarque)
#'
#' @examples
#' data(treino_desembarque)
#' str(treino_desembarque)
#'
#' # Empilhar (largo -> longo), extraindo ano e métrica do nome da coluna,
#' # e depois alargar cada métrica em sua coluna (requer tidyr).
#' if (requireNamespace("tidyr", quietly = TRUE)) {
#'   longo <- tidyr::pivot_longer(
#'     treino_desembarque,
#'     cols = tidyr::matches("^[0-9]{4} - "),
#'     names_to = c("ano", "metrica"),
#'     names_pattern = "^([0-9]{4}) - (.*)$",
#'     values_to = "valor"
#'   )
#'   head(longo)
#'   tidyr::pivot_wider(longo, names_from = "metrica", values_from = "valor")
#' }
#'
NULL
