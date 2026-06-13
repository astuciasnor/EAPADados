#' Pinguins do Arquipelago Palmer (palmerpenguins) com nomes em portugues
#'
#' @description
#' Medidas morfometricas de tres especies de pinguins (organismos marinhos
#' mergulhadores) coletadas na regiao da Palmer Station, Antartida. E uma versao
#' contextualizada em portugues do conjunto \code{penguins} do pacote
#' \pkg{palmerpenguins}. Excelente para analise exploratoria multivariada
#' (PCA, AAH/HCA), comparacao de medias (teste t, ANOVA), regressao, graficos
#' e pratica de tratamento de valores ausentes.
#'
#' @format Um data frame com 344 observacoes e 8 variaveis:
#' \describe{
#'   \item{especie}{Especie do pinguim (fator: "Adelie", "Chinstrap", "Gentoo").}
#'   \item{ilha}{Ilha de coleta no Arquipelago Palmer (fator: "Biscoe", "Dream",
#'     "Torgersen").}
#'   \item{comprimento_bico_mm}{Comprimento do bico (culmen), em mm (numerica).}
#'   \item{profundidade_bico_mm}{Profundidade (altura) do bico, em mm (numerica).}
#'   \item{comprimento_nadadeira_mm}{Comprimento da nadadeira, em mm (inteiro).}
#'   \item{massa_g}{Massa corporal, em gramas (inteiro).}
#'   \item{sexo}{Sexo do individuo (fator: "femea", "macho").}
#'   \item{ano}{Ano da observacao (inteiro: 2007 a 2009).}
#' }
#'
#' @details
#' O conjunto contem alguns valores ausentes (\code{NA}), uteis para ensinar
#' tratamento de dados. Para PCA/AAH, use as quatro medidas morfometricas
#' (\code{comprimento_bico_mm}, \code{profundidade_bico_mm},
#' \code{comprimento_nadadeira_mm}, \code{massa_g}), com padronizacao, e use a
#' especie como grupo conhecido para validar os agrupamentos.
#'
#' @source Horst, A. M.; Hill, A. P.; Gorman, K. B. (2020). \emph{palmerpenguins:
#'   Palmer Archipelago (Antarctica) penguin data}. Pacote R, versao 0.1.0.
#'   DOI: 10.5281/zenodo.3960218. Dados originais: Gorman, K. B.; Williams, T. D.;
#'   Fraser, W. R. (2014), coletados pela Palmer Station Antarctica LTER.
#'   Licenca: CC0 (dominio publico).
#' @docType data
#' @keywords datasets pca hca morfometria pinguins
#' @name pinguins
#' @usage data(pinguins)
#'
#' @examples
#' data(pinguins)
#' str(pinguins)
#'
#' # PCA das medidas morfometricas (removendo NAs)
#' vars <- c("comprimento_bico_mm", "profundidade_bico_mm",
#'           "comprimento_nadadeira_mm", "massa_g")
#' dados <- na.omit(pinguins[, c("especie", vars)])
#' pca <- prcomp(dados[, vars], scale. = TRUE)
#' summary(pca)
#'
#' # Agrupamento hierarquico (Ward) e comparacao com a especie
#' d <- dist(scale(dados[, vars]))
#' plot(hclust(d, method = "ward.D2"), labels = dados$especie)
#'
#' # Grafico de dispersao por especie (requer ggplot2)
#' if (requireNamespace("ggplot2", quietly = TRUE)) {
#'   library(ggplot2)
#'   ggplot(pinguins, aes(comprimento_nadadeira_mm, massa_g, color = especie)) +
#'     geom_point(na.rm = TRUE) +
#'     theme_minimal()
#' }
"pinguins"
