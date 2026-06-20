#' Composição química de salmouras de unidades carbonáticas
#'
#' @description
#' Concentrações iônicas de salmouras / águas de formação associadas a três
#' unidades carbonáticas dos Estados Unidos (Ellenburger Dolomite, Grayburg
#' Dolomite e Viola Limestone), recuperadas em testes de poço. Conjunto pequeno
#' e limpo, clássico para PCA e agrupamento hierárquico (AAH/HCA) em
#' hidroquímica/geoquímica. Útil também como paralelo a dados de qualidade da
#' água em aquicultura.
#'
#' @format Um data frame com 19 observações e 8 variáveis:
#' \describe{
#'   \item{amostra}{Identificador da amostra (código, ex.: "E01"; caractere).}
#'   \item{grupo}{Fator com a unidade geológica de origem. Níveis:
#'     "Ellenburger_Dolomite", "Grayburg_Dolomite", "Viola_Limestone".}
#'   \item{HCO3}{Bicarbonato, em ppm (numérica).}
#'   \item{SO4}{Sulfato, em ppm (numérica).}
#'   \item{Cl}{Cloreto, em ppm (numérica).}
#'   \item{Ca}{Cálcio, em ppm (numérica).}
#'   \item{Mg}{Magnésio, em ppm (numérica).}
#'   \item{Na}{Sódio, em ppm (numérica).}
#' }
#'
#' @details
#' Cada linha é uma amostra de salmoura/água de formação. As variáveis iônicas
#' estão em escalas muito diferentes (Cl e Na dominam em magnitude), o que torna
#' o conjunto ideal para demonstrar como a padronização muda a PCA. A versão aqui
#' incluída corrige dois valores da tabela original (V18: Cl = 289,9;
#' V19: Na = 318,1).
#'
#' @source Davis, J. C. (2002). \emph{Statistics and Data Analysis in Geology},
#'   3rd ed. Wiley. Dados de apoio: Kansas Geological Survey, arquivo BRINE.TXT.
#' @docType data
#' @encoding UTF-8
#' @keywords datasets pca hca hidroquimica geoquimica
#' @name brine_carbonatos
#' @usage data(brine_carbonatos)
#'
#' @examples
#' data(brine_carbonatos)
#' str(brine_carbonatos)
#'
#' # PCA com padronização (variáveis em escalas diferentes)
#' ions <- c("HCO3", "SO4", "Cl", "Ca", "Mg", "Na")
#' pca <- prcomp(brine_carbonatos[, ions], scale. = TRUE)
#' summary(pca)
#' biplot(pca)
#'
#' # Agrupamento hierárquico (Ward) e comparação com a unidade geológica
#' d <- dist(scale(brine_carbonatos[, ions]))
#' plot(hclust(d, method = "ward.D2"), labels = brine_carbonatos$grupo)
"brine_carbonatos"
