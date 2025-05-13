#' Estatisticas Resumidas da Morfometria de Caranguejos
#'
#' @description
#' Calcula estatisticas descritivas (media, desvio-padrao e tamanho da amostra)
#' para as variaveis Largura da Carapaca (LC) e Comprimento da Carapaca (CC),
#' agrupadas por Sexo e Estacao, usando o conjunto de dados `morfometria_caranguejos`.
#'
#' @param data
#'   Um data frame contendo as colunas `Sexo`, `Estacao`, `LC` e `CC`.
#'   Por padrao, utiliza o dataset `morfometria_caranguejos` do pacote.
#'
#' @return
#'   Um tibble com as colunas:
#'   * `Sexo`     : Sexo dos individuos ("Macho" / "Femea").
#'   * `Estacao`  : Estacao de captura ("Seca" / "Chuvosa").
#'   * `media_LC` : Media da Largura da Carapaca (mm).
#'   * `dp_LC`    : Desvio-padrao da Largura da Carapaca (mm).
#'   * `media_CC` : Media do Comprimento da Carapaca (mm).
#'   * `dp_CC`    : Desvio-padrao do Comprimento da Carapaca (mm).
#'   * `n`        : Numero de observacoes em cada grupo.
#'
#' @details
#'   Utiliza funcoes do pacote `dplyr` e o operador `%>%` do `magrittr` para agrupar
#'   e resumir os dados.
#'
#' @importFrom magrittr %>%
#' @importFrom dplyr group_by summarize n
#' @importFrom stats sd
#' @export
#'
#' @examples
#' \dontrun{
#' library(EAPADados)
#' library(dplyr)
#'
#' # Estatisticas por sexo e estacao
#' summarize_morfometria()
#'
#' # Usando outro data frame como exemplo
#' df_exemplo <- head(morfometria_caranguejos, 20)
#' summarize_morfometria(df_exemplo)
#' }
summarize_morfometria <- function(data = morfometria_caranguejos) {
  if (!requireNamespace("dplyr", quietly = TRUE)) {
    stop("O pacote 'dplyr' e necessario para usar summarize_morfometria().", call. = FALSE)
  }

  data %>%
    dplyr::group_by(Sexo, Estacao) %>%
    dplyr::summarize(
      media_LC = mean(LC, na.rm = TRUE),
      dp_LC    = sd(LC, na.rm = TRUE),
      media_CC = mean(CC, na.rm = TRUE),
      dp_CC    = sd(CC, na.rm = TRUE),
      n         = dplyr::n(),
      .groups   = "drop"
    )
}

# Evita notas sobre bindings globais no R CMD check
if (getRversion() >= "2.15.1") {
  utils::globalVariables(c("Sexo", "Estacao", "LC", "CC"))
}
