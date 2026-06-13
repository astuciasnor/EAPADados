#' Composicao quimica de salmouras de unidades carbonaticas
#'
#' @description
#' Concentracoes ionicas de salmouras / aguas de formacao associadas a tres
#' unidades carbonaticas dos Estados Unidos (Ellenburger Dolomite, Grayburg
#' Dolomite e Viola Limestone), recuperadas em testes de poco. Conjunto pequeno
#' e limpo, classico para PCA e agrupamento hierarquico (AAH/HCA) em
#' hidroquimica/geoquimica. Util tambem como paralelo a dados de qualidade da
#' agua em aquicultura.
#'
#' @format Um data frame com 19 observacoes e 8 variaveis:
#' \describe{
#'   \item{amostra}{Identificador da amostra (codigo, ex.: "E01"; caractere).}
#'   \item{grupo}{Fator com a unidade geologica de origem. Niveis:
#'     "Ellenburger_Dolomite", "Grayburg_Dolomite", "Viola_Limestone".}
#'   \item{HCO3}{Bicarbonato, em ppm (numerica).}
#'   \item{SO4}{Sulfato, em ppm (numerica).}
#'   \item{Cl}{Cloreto, em ppm (numerica).}
#'   \item{Ca}{Calcio, em ppm (numerica).}
#'   \item{Mg}{Magnesio, em ppm (numerica).}
#'   \item{Na}{Sodio, em ppm (numerica).}
#' }
#'
#' @details
#' Cada linha e uma amostra de salmoura/agua de formacao. As variaveis ionicas
#' estao em escalas muito diferentes (Cl e Na dominam em magnitude), o que torna
#' o conjunto ideal para demonstrar como a padronizacao muda a PCA. A versao aqui
#' incluida corrige dois valores da tabela original (V18: Cl = 289,9;
#' V19: Na = 318,1).
#'
#' @source Davis, J. C. (2002). \emph{Statistics and Data Analysis in Geology},
#'   3rd ed. Wiley. Dados de apoio: Kansas Geological Survey, arquivo BRINE.TXT.
#' @docType data
#' @keywords datasets pca hca hidroquimica geoquimica
#' @name brine_carbonatos
#' @usage data(brine_carbonatos)
#'
#' @examples
#' data(brine_carbonatos)
#' str(brine_carbonatos)
#'
#' # PCA com padronizacao (variaveis em escalas diferentes)
#' ions <- c("HCO3", "SO4", "Cl", "Ca", "Mg", "Na")
#' pca <- prcomp(brine_carbonatos[, ions], scale. = TRUE)
#' summary(pca)
#' biplot(pca)
#'
#' # Agrupamento hierarquico (Ward) e comparacao com a unidade geologica
#' d <- dist(scale(brine_carbonatos[, ions]))
#' plot(hclust(d, method = "ward.D2"), labels = brine_carbonatos$grupo)
"brine_carbonatos"
