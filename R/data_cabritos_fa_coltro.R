#' Ácidos graxos em carne de cabritos sob dietas com diferentes níveis de energia
#'
#' @description
#' Composição de ácidos graxos da carne de 32 cabritos jovens (raça Saanen),
#' distribuídos em quatro tratamentos dietéticos isoproteicos com níveis
#' crescentes de energia metabolizável (T1 a T4). As variáveis resumem grandes
#' classes de ácidos graxos e razões nutricionalmente relevantes. Conjunto
#' clássico de quimiometria, usado no estudo original para PCA e agrupamento
#' hierárquico (AAH/HCA). Excelente para ensino: pequeno, limpo, balanceado e
#' com grupos conhecidos.
#'
#' @format Um data frame com 32 observações e 10 variáveis:
#' \describe{
#'   \item{amostra}{Identificador da amostra/animal (inteiro, 1 a 32).}
#'   \item{tratamento}{Fator com o grupo dietético. Níveis: "T1", "T2", "T3", "T4".}
#'   \item{energia_mj_kg}{Energia metabolizável da dieta, em MJ/kg (numérica).}
#'   \item{n3}{Ácidos graxos ômega-3 totais, em \% dos ácidos graxos totais.}
#'   \item{n6}{Ácidos graxos ômega-6 totais, em \% dos ácidos graxos totais.}
#'   \item{n6_n3}{Razão entre ômega-6 e ômega-3 (numérica).}
#'   \item{sfa}{Ácidos graxos saturados, em \% dos ácidos graxos totais.}
#'   \item{mufa}{Ácidos graxos monoinsaturados, em \% dos ácidos graxos totais.}
#'   \item{pufa}{Ácidos graxos poli-insaturados, em \% dos ácidos graxos totais.}
#'   \item{pufa_sfa}{Razão entre PUFA e SFA (numérica).}
#' }
#'
#' @details
#' Cada linha é uma amostra de carne do músculo Longissimus dorsi, e cada valor
#' corresponde à média de três repetições analíticas. No estudo original, PC1
#' explicou cerca de 72\% e PC2 cerca de 24\% da variância (aprox. 96\% nas duas
#' primeiras componentes), com separação clara entre tratamentos; o tratamento
#' T4 (maior energia) apresentou maior MUFA e n-3, menor razão n-6:n-3 e menor
#' SFA. Recomenda-se padronização (z-score / autoscaling) antes da PCA/HCA.
#'
#' @source Coltro, W. K. T. et al. (2005). Correlation of animal diet and fatty
#'   acid content in young goat meat by gas chromatography and chemometrics.
#'   \emph{Meat Science}, 71(2), 358-363. DOI: 10.1016/j.meatsci.2005.04.016.
#' @docType data
#' @encoding UTF-8
#' @keywords datasets quimiometria pca hca acidos-graxos
#' @name cabritos_fa_coltro
#' @usage data(cabritos_fa_coltro)
#'
#' @examples
#' data(cabritos_fa_coltro)
#' str(cabritos_fa_coltro)
#'
#' # PCA sobre as variáveis químicas padronizadas
#' quimicas <- c("n3", "n6", "n6_n3", "sfa", "mufa", "pufa", "pufa_sfa")
#' pca <- prcomp(cabritos_fa_coltro[, quimicas], scale. = TRUE)
#' summary(pca)
#'
#' # Agrupamento hierárquico (Ward) sobre distância euclidiana
#' d <- dist(scale(cabritos_fa_coltro[, quimicas]))
#' agrup <- hclust(d, method = "ward.D2")
#' plot(agrup, labels = cabritos_fa_coltro$tratamento)
"cabritos_fa_coltro"
