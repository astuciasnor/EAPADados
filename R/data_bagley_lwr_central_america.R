#' Relação comprimento-peso de peixes neotropicais (ANCOVA)
#'
#' @description
#' Peso e comprimento de peixes de água doce neotropicais da América Central,
#' com transformações logarítmicas prontas. Base clássica para \strong{ANCOVA}
#' da relação peso-comprimento (LWR): comparar o expoente alométrico entre
#' espécies e testar isometria.
#'
#' @format Um data frame com 306 observações e 14 variáveis:
#' \describe{
#'   \item{no}{Inteiro: número do indivíduo na base original.}
#'   \item{especie}{Fator: espécie (9 níveis).}
#'   \item{peso_g}{Numérico: peso (g).}
#'   \item{comprimento_padrao_mm}{Numérico: comprimento padrão, SL (mm).}
#'   \item{comprimento_total_mm}{Numérico: comprimento total, TL (mm); com ausentes.}
#'   \item{pais}{Fator: país (\code{Costa Rica}, \code{Nicaragua}, \code{Panama}).}
#'   \item{localidade}{Fator: localidade de coleta.}
#'   \item{latitude}{Numérico: latitude (graus decimais); com ausentes.}
#'   \item{longitude}{Numérico: longitude (graus decimais); com ausentes.}
#'   \item{nadadeira_dorsal}{Fator: anotação da nadadeira dorsal; maioria ausente.}
#'   \item{nadadeira_caudal}{Fator: anotação da nadadeira caudal; maioria ausente.}
#'   \item{sexo}{Fator: \code{female}, \code{male}; maioria ausente.}
#'   \item{log_peso_g}{Numérico: logaritmo natural do peso. Resposta da ANCOVA.}
#'   \item{log_sl_mm}{Numérico: logaritmo natural do comprimento padrão. Covariável.}
#' }
#'
#' @details
#' Modelo-alvo: \code{log_peso_g ~ log_sl_mm * especie}; se a interação não for
#' significativa, \code{log_peso_g ~ log_sl_mm + especie}. Teste de isometria:
#' H0 de que o coeficiente de \code{log_sl_mm} é 3. Cuidados: forte desequilíbrio
#' de n entre espécies (recomenda-se filtrar \code{especie} com n >= 10 ou 20);
#' \code{Atherinella sp.} e \code{Poecilia sp.} são identificações incertas;
#' \code{sexo} tem muitos ausentes.
#'
#' @source Bagley, J. C.; Breitman, M. F.; Johnson, J. B. (2022).
#'   \emph{Length-weight relation for seven Neotropical freshwater fish species
#'   endemic to Central America}. Acta Ichthyologica et Piscatoria 52(3):183-187.
#'   DOI: 10.3897/aiep.52.86467; dataset Mendeley DOI: 10.17632/kphrvvgwwz.1
#'   (licença CC BY 4.0). Adaptação didática.
#' @docType data
#' @encoding UTF-8
#' @keywords datasets pesca ancova regressao
#' @name bagley_lwr_central_america
#' @usage data(bagley_lwr_central_america)
#'
#' @examples
#' data(bagley_lwr_central_america)
#' # ANCOVA da relacao peso-comprimento
#' mod <- aov(log_peso_g ~ log_sl_mm * especie,
#'            data = bagley_lwr_central_america)
#' summary(mod)
"bagley_lwr_central_america"
