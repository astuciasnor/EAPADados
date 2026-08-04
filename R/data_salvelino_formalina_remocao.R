#' Sobrevivência à eclosão de ovos de salvelino-do-Ártico sob formalina e remoção manual
#'
#' @description
#' Dados no nível da unidade experimental de um ensaio fatorial 2 x 2 com ovos
#' de salvelino-do-Ártico (\emph{Salvelinus alpinus}) em incubatório. Os fatores
#' são a aplicação de formalina antes da fase de olhos e a remoção semanal
#' manual de ovos mortos durante essa fase. A resposta percentual é acompanhada
#' pelas contagens que a originam.
#'
#' @format Um data frame com 30 observações e 7 variáveis:
#' \describe{
#'   \item{unidade_experimental}{Texto: identificador do compartimento/ensaio.}
#'   \item{formalin}{Fator: aplicação de formalina (\code{sem}, \code{com}).}
#'   \item{remocao_semanal}{Fator: remoção manual semanal (\code{sem}, \code{com}).}
#'   \item{ovos_iniciais}{Inteiro: número de ovos no início da unidade.}
#'   \item{ovos_eclodidos}{Inteiro: número de ovos que eclodiram.}
#'   \item{mortalidade_total}{Inteiro: número de ovos mortos ao final do acompanhamento.}
#'   \item{sobrevivencia_eclosao_pct}{Numérico: 100 vezes ovos eclodidos dividido por ovos iniciais.}
#' }
#'
#' @details
#' Cada linha representa uma unidade experimental, não um ovo individual. O
#' delineamento é desequilibrado (12, 8, 3 e 7 unidades nas quatro células).
#' Para reproduzir a análise publicada, a transformação arco-seno da raiz
#' quadrada da proporção pode ser aplicada à resposta percentual. Como os
#' denominadores variam entre unidades, as contagens também permitem discutir
#' um modelo binomial para o número de ovos eclodidos, sem substituir a coluna
#' percentual original.
#'
#' @source Olk, T. R.; Lydersen, E.; Wollebæk, J. (2023). \emph{Replication
#'   data for: Formalin treatments before eyeing and hand-picking of Arctic charr
#'   (Salvelinus alpinus) eggs – re-evaluating the timing of antifungal
#'   treatments}. DataverseNO. DOI: https://doi.org/10.23642/USN.7334573. Licença CC BY 4.0.
#'   A versão enxuta mantém o registro final de cada unidade experimental.
#'
#' @docType data
#' @encoding UTF-8
#' @keywords datasets aquicultura anova fatorial sobrevivencia
#' @name salvelino_formalina_remocao
#' @usage data(salvelino_formalina_remocao)
#'
#' @examples
#' data(salvelino_formalina_remocao)
#' mod <- aov(asin(sqrt(sobrevivencia_eclosao_pct / 100)) ~
#'              formalin * remocao_semanal,
#'            data = salvelino_formalina_remocao)
#' summary(mod)
#'
"salvelino_formalina_remocao"
