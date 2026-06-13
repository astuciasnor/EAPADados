#' Acidos graxos em carne de cabritos sob dietas com diferentes niveis de energia
#'
#' @description
#' Composicao de acidos graxos da carne de 32 cabritos jovens (raca Saanen),
#' distribuidos em quatro tratamentos dieteticos isoproteicos com niveis
#' crescentes de energia metabolizavel (T1 a T4). As variaveis resumem grandes
#' classes de acidos graxos e razoes nutricionalmente relevantes. Conjunto
#' classico de quimiometria, usado no estudo original para PCA e agrupamento
#' hierarquico (AAH/HCA). Excelente para ensino: pequeno, limpo, balanceado e
#' com grupos conhecidos.
#'
#' @format Um data frame com 32 observacoes e 10 variaveis:
#' \describe{
#'   \item{amostra}{Identificador da amostra/animal (inteiro, 1 a 32).}
#'   \item{tratamento}{Fator com o grupo dietetico. Niveis: "T1", "T2", "T3", "T4".}
#'   \item{energia_mj_kg}{Energia metabolizavel da dieta, em MJ/kg (numerica).}
#'   \item{n3}{Acidos graxos omega-3 totais, em \% dos acidos graxos totais.}
#'   \item{n6}{Acidos graxos omega-6 totais, em \% dos acidos graxos totais.}
#'   \item{n6_n3}{Razao entre omega-6 e omega-3 (numerica).}
#'   \item{sfa}{Acidos graxos saturados, em \% dos acidos graxos totais.}
#'   \item{mufa}{Acidos graxos monoinsaturados, em \% dos acidos graxos totais.}
#'   \item{pufa}{Acidos graxos poli-insaturados, em \% dos acidos graxos totais.}
#'   \item{pufa_sfa}{Razao entre PUFA e SFA (numerica).}
#' }
#'
#' @details
#' Cada linha e uma amostra de carne do musculo Longissimus dorsi, e cada valor
#' corresponde a media de tres repeticoes analiticas. No estudo original, PC1
#' explicou cerca de 72\% e PC2 cerca de 24\% da variancia (aprox. 96\% nas duas
#' primeiras componentes), com separacao clara entre tratamentos; o tratamento
#' T4 (maior energia) apresentou maior MUFA e n-3, menor razao n-6:n-3 e menor
#' SFA. Recomenda-se padronizacao (z-score / autoscaling) antes da PCA/HCA.
#'
#' @source Coltro, W. K. T. et al. (2005). Correlation of animal diet and fatty
#'   acid content in young goat meat by gas chromatography and chemometrics.
#'   \emph{Meat Science}, 71(2), 358-363. DOI: 10.1016/j.meatsci.2005.04.016.
#' @docType data
#' @keywords datasets quimiometria pca hca acidos-graxos
#' @name cabritos_fa_coltro
#' @usage data(cabritos_fa_coltro)
#'
#' @examples
#' data(cabritos_fa_coltro)
#' str(cabritos_fa_coltro)
#'
#' # PCA sobre as variaveis quimicas padronizadas
#' quimicas <- c("n3", "n6", "n6_n3", "sfa", "mufa", "pufa", "pufa_sfa")
#' pca <- prcomp(cabritos_fa_coltro[, quimicas], scale. = TRUE)
#' summary(pca)
#'
#' # Agrupamento hierarquico (Ward) sobre distancia euclidiana
#' d <- dist(scale(cabritos_fa_coltro[, quimicas]))
#' agrup <- hclust(d, method = "ward.D2")
#' plot(agrup, labels = cabritos_fa_coltro$tratamento)
"cabritos_fa_coltro"
