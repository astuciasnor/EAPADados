#' Biometria do camarao-branco Litopenaeus vannamei
#'
#' Conjunto de dados biometricos de camaroes-brancos
#' (\emph{Litopenaeus vannamei}) provenientes de cinco subconjuntos amostrais
#' associados a cultivos em fazenda industrial e viveiro academico.
#' Os dados foram originalmente organizados para estudos de visao
#' computacional, deteccao de organismos e estimativa nao invasiva de
#' biomassa em aquicultura. No EAPADados, o conjunto e disponibilizado
#' em formato tabular para atividades de regressao linear, especialmente
#' para estudar a relacao entre comprimento corporal e peso individual.
#'
#' @format Um data frame com 170 linhas e 9 variaveis:
#' \describe{
#'   \item{id_camarao}{Identificador unico criado a partir da base e da amostra.}
#'   \item{base}{Subconjunto original: DB1, DB2, DB3, DB4 ou DB5.}
#'   \item{origem}{Origem geral do cultivo: fazenda industrial ou viveiro academico.}
#'   \item{arquivo_origem}{Nome do arquivo Excel original.}
#'   \item{amostra}{Numero original do camarao no arquivo de origem.}
#'   \item{comprimento_cm}{Comprimento corporal total, em centimetros.}
#'   \item{cefalotorax_cm}{Comprimento do cefalotorax, em centimetros. Ausente no DB1.}
#'   \item{peso_g}{Peso individual, em gramas.}
#'   \item{imagem_completa}{Indicador da presenca de pelo menos uma imagem de corpo inteiro: 1 = sim; 0 = nao.}
#' }
#'
#' @details
#' A relacao entre peso e comprimento pode ser explorada por regressao linear
#' simples, usando \code{peso_g ~ comprimento_cm}, ou por uma forma linearizada
#' da relacao alometrica comprimento-peso, usando
#' \code{log10(peso_g) ~ log10(comprimento_cm)}.
#'
#' @source
#' Ramirez-Coronel, Fernando Joaquin; Esquer-Miranda, Edgard;
#' Rodriguez-Elias, Oscar Mario; Garcia-Hinostro, Pedro; Parra-Salazar,
#' Guadalupe Cesar. 2024. \emph{A Litopenaeus vannamei shrimp dataset with images
#' and corresponding weight-size measurements for the development of artificial
#' intelligence-based biomass estimation and organism detection algorithms}.
#' Mendeley Data, Version 2. DOI: 10.17632/h8tcn6ykky.2. Licenca CC BY 4.0.
#'
#' @references
#' Ramirez-Coronel, F. J.; Esquer-Miranda, E.; Rodriguez-Elias, O. M.;
#' Garcia-Hinostro, P.; Parra-Salazar, G. C. 2024. \emph{A Litopenaeus vannamei
#' shrimp dataset for artificial intelligence-based biomass estimation and
#' organism detection algorithms}. Data in Brief, 110964.
#' DOI: 10.1016/j.dib.2024.110964.
#'
#' @docType data
#' @encoding UTF-8
#' @keywords datasets aquicultura regressao camarao
#' @name camarao_vannamei_biometria
#' @usage data(camarao_vannamei_biometria)
#'
#' @examples
#' data(camarao_vannamei_biometria)
#'
#' modelo1 <- lm(peso_g ~ comprimento_cm, data = camarao_vannamei_biometria)
#' summary(modelo1)
#'
#' modelo2 <- lm(log10(peso_g) ~ log10(comprimento_cm),
#'               data = camarao_vannamei_biometria)
#' summary(modelo2)
"camarao_vannamei_biometria"
