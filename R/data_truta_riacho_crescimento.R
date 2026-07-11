#' Crescimento de truta-de-riacho sob temperatura e ração
#'
#' @description
#' Crescimento específico de trutas-de-riacho (\emph{Salvelinus fontinalis})
#' juvenis submetidas a combinações de temperatura da água e nível de ração,
#' em experimento de aquicultura/bioecologia. Base real e enxuta, pensada para
#' \strong{regressão linear múltipla} (resposta contínua com covariáveis).
#'
#' @format Um data frame com 69 observações e 8 variáveis:
#' \describe{
#'   \item{id_peixe}{Identificador do peixe (texto).}
#'   \item{tanque}{Fator: tanque experimental (agrupamento; possível pseudorrepetição).}
#'   \item{crescimento_especifico_pct_dia}{Numérico: taxa de crescimento específico (\% por dia). Variável resposta.}
#'   \item{temperatura_c}{Inteiro: temperatura da água (°C).}
#'   \item{racao_g}{Numérico: ração fornecida (g).}
#'   \item{massa_inicial_g}{Numérico: massa inicial do peixe (g).}
#'   \item{eficiencia_conversao}{Numérico: eficiência de conversão alimentar.}
#'   \item{racao_fator}{Fator: nível de ração (\code{high}, \code{low}).}
#' }
#'
#' @details
#' A unidade observacional é o peixe individual, mas os peixes compartilham
#' \code{tanque} e tratamentos, o que gera dependência — útil para discutir
#' pseudorrepetição. Foram removidas as linhas de ração zero (sem
#' \code{eficiencia_conversao}). Modelo simples sugerido:
#' \code{crescimento_especifico_pct_dia ~ temperatura_c + racao_g + massa_inicial_g + eficiencia_conversao}.
#'
#' @source Rutledge, E.; Nislow, K.; Fuller, M.; McCormick, S.; Chen, C.;
#'   Chadwick, J. G. (2025). \emph{Interactive effects of temperature and food
#'   ration on growth and mercury concentration in eastern brook trout}
#'   [Dataset]. Dryad. DOI: 10.5061/dryad.v6wwpzh86 (licença CC0). Adaptação
#'   didática do subconjunto completo.
#' @docType data
#' @encoding UTF-8
#' @keywords datasets aquicultura regressao
#' @name truta_riacho_crescimento
#' @usage data(truta_riacho_crescimento)
#'
#' @examples
#' data(truta_riacho_crescimento)
#' summary(truta_riacho_crescimento)
#' mod <- lm(crescimento_especifico_pct_dia ~ temperatura_c + racao_g +
#'             massa_inicial_g + eficiencia_conversao,
#'           data = truta_riacho_crescimento)
#' summary(mod)
"truta_riacho_crescimento"
