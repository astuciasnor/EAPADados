#' Barbo: morfometria corrigida para agrupamento (AAH)
#'
#' @description
#' Medidas morfométricas de \emph{Barbus petenyi}, já corrigidas alometricamente
#' pelo comprimento padrão, para uma \strong{Análise de Agrupamento Hierárquico
#' (AAH/HCA)} introdutória. As cinco populações servem só para interpretar os
#' grupos depois. Base enxuta e balanceada.
#'
#' @format Um data frame com 100 observações e 13 variáveis:
#' \describe{
#'   \item{id_peixe}{Texto: identificador do indivíduo.}
#'   \item{populacao}{Fator: população de origem (\code{POP06} a \code{POP10}).}
#'   \item{rio}{Fator: rótulo didático do rio (\code{rio_pop06} a \code{rio_pop10}).}
#'   \item{comprimento_cabeca}{Numérico: comprimento da cabeça (corrigido por SL).}
#'   \item{comprimento_pre_anal}{Numérico: distância pré-anal.}
#'   \item{focinho_occipital}{Numérico: focinho ao occipital.}
#'   \item{distancia_pre_peitoral}{Numérico: distância pré-peitoral.}
#'   \item{distancia_dorsal_pelvica}{Numérico: distância dorsal-pélvica.}
#'   \item{focinho_operculo_ventral}{Numérico: focinho ao opérculo ventral.}
#'   \item{distancia_pre_dorsal}{Numérico: distância pré-dorsal.}
#'   \item{distancia_dorsal_peitoral}{Numérico: distância dorsal-peitoral.}
#'   \item{diametro_horizontal_olho}{Numérico: diâmetro horizontal do olho.}
#'   \item{altura_maxima_corpo}{Numérico: altura máxima do corpo.}
#' }
#'
#' @details
#' As dez variáveis quantitativas já estão corrigidas pelo tamanho; a
#' padronização z-score deve ser feita antes da distância euclidiana. As colunas
#' \code{populacao}/\code{rio} entram só como rótulos externos.
#'
#' @source Bánó, K.; Takács, P. (2022). \emph{Raw morphometric data of three
#'   freshwater fish species}. Mendeley Data / Hydrobiologia.
#'   DOI: 10.17632/c8856zg4hj.1 (licença CC BY 4.0). Recorte didático de
#'   \emph{Barbus petenyi}.
#' @docType data
#' @encoding UTF-8
#' @keywords datasets morfometria multivariada
#' @name morfometria_barbo
#' @usage data(morfometria_barbo)
#'
#' @examples
#' data(morfometria_barbo)
#' vars <- c("comprimento_cabeca", "comprimento_pre_anal", "focinho_occipital",
#'           "distancia_pre_peitoral", "distancia_dorsal_pelvica",
#'           "focinho_operculo_ventral", "distancia_pre_dorsal",
#'           "distancia_dorsal_peitoral", "diametro_horizontal_olho",
#'           "altura_maxima_corpo")
#' hc <- hclust(dist(scale(morfometria_barbo[vars])), method = "ward.D2")
#' table(cutree(hc, k = 5), morfometria_barbo$populacao)
"morfometria_barbo"
