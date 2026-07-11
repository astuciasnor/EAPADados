#' Morfometria de três espécies de peixes de água doce (base completa)
#'
#' @description
#' Base morfométrica completa de três espécies de peixes de água doce, com 35
#' medidas corporais por indivíduo. Pensada para \strong{ACP/PCA} e
#' \strong{AAH/HCA}, distâncias entre indivíduos, heatmap e discussão sobre
#' seleção de variáveis em análise multivariada.
#'
#' @format Um data frame com 299 observações e 39 variáveis. As quatro primeiras
#' identificam o indivíduo; as demais (\code{da}...\code{sl}) são medidas
#' morfométricas (mm), com nomes-código reconstruídos da fonte:
#' \describe{
#'   \item{especie}{Fator: \code{Barbus petenyi}, \code{Gobio sp.}, \code{Lepomis gibbosus}.}
#'   \item{especie_codigo}{Fator: código da espécie (\code{barbus_petenyi}, \code{gobio_sp}, \code{lepomis_gibbosus}).}
#'   \item{populacao}{Fator: população de origem (\code{POP01} a \code{POP15}).}
#'   \item{id_individuo}{Texto: identificador do indivíduo.}
#'   \item{da}{Numérico: medida morfométrica (mm).}
#'   \item{dalc}{Numérico: medida morfométrica (mm).}
#'   \item{dauc}{Numérico: medida morfométrica (mm).}
#'   \item{dlc}{Numérico: medida morfométrica (mm).}
#'   \item{dod}{Numérico: medida morfométrica (mm).}
#'   \item{dopl}{Numérico: medida morfométrica (mm).}
#'   \item{dpc}{Numérico: medida morfométrica (mm).}
#'   \item{dpl}{Numérico: medida morfométrica (mm).}
#'   \item{dso}{Numérico: medida morfométrica (mm).}
#'   \item{dsv}{Numérico: medida morfométrica (mm).}
#'   \item{duc}{Numérico: medida morfométrica (mm).}
#'   \item{dvpl}{Numérico: medida morfométrica (mm).}
#'   \item{eh}{Numérico: medida morfométrica (mm).}
#'   \item{ev}{Numérico: medida morfométrica (mm).}
#'   \item{fl}{Numérico: medida morfométrica (mm).}
#'   \item{hd}{Numérico: medida morfométrica (mm).}
#'   \item{hh}{Numérico: medida morfométrica (mm).}
#'   \item{hl}{Numérico: medida morfométrica (mm).}
#'   \item{hmax}{Numérico: altura máxima do corpo (mm).}
#'   \item{hmin}{Numérico: altura mínima do corpo (mm).}
#'   \item{la}{Numérico: medida morfométrica (mm).}
#'   \item{lbd}{Numérico: medida morfométrica (mm).}
#'   \item{ld}{Numérico: medida morfométrica (mm).}
#'   \item{llc}{Numérico: medida morfométrica (mm).}
#'   \item{lpec}{Numérico: medida morfométrica (mm).}
#'   \item{lpl}{Numérico: medida morfométrica (mm).}
#'   \item{luc}{Numérico: medida morfométrica (mm).}
#'   \item{mo}{Numérico: medida morfométrica (mm).}
#'   \item{pa}{Numérico: medida morfométrica (mm).}
#'   \item{pd}{Numérico: medida morfométrica (mm).}
#'   \item{poo}{Numérico: medida morfométrica (mm).}
#'   \item{ppec}{Numérico: medida morfométrica (mm).}
#'   \item{ppl}{Numérico: medida morfométrica (mm).}
#'   \item{pre}{Numérico: medida morfométrica (mm).}
#'   \item{sl}{Numérico: comprimento padrão (mm).}
#' }
#'
#' @details
#' Os nomes das 35 medidas foram reconstruídos da aba \code{variables} da fonte
#' (o bruto tinha cabeçalho inconsistente). Padronize por z-score antes de
#' distâncias/ACP. A seleção do subconjunto de medidas altera o resultado — um
#' bom ponto de discussão em multivariada.
#'
#' @source Bánó, K.; Takács, P. (2022). \emph{Raw morphometric data of three
#'   freshwater fish species}. Mendeley Data / Hydrobiologia.
#'   DOI: 10.17632/c8856zg4hj.1 (licença CC BY 4.0). Base curada completa.
#' @docType data
#' @encoding UTF-8
#' @keywords datasets morfometria multivariada
#' @name peixes_morfometria_multivariada
#' @usage data(peixes_morfometria_multivariada)
#'
#' @examples
#' data(peixes_morfometria_multivariada)
#' medidas <- c("dod", "dpl", "dsv", "eh", "hh", "hl", "hmax", "hmin",
#'              "lbd", "lpec", "pa", "ppec", "sl")
#' pca <- prcomp(peixes_morfometria_multivariada[, medidas], scale. = TRUE)
#' summary(pca)
"peixes_morfometria_multivariada"
