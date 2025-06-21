#' Peso Final de Bagres Alimentados com Rações Iso-Proteicas
#'
#' @description
#' Este conjunto de dados apresenta os **pesos médios finais (g)** de bagres
#' (_Ictalurus spp._) após serem alimentados com **quatro rações comerciais
#' iso-proteicas** (mesmo teor de proteína), porém com **níveis de lipídios
#' diferentes**. Para o ensaio, 50 peixes foram estocados em cada gaiola
#' (quatro gaiolas por ração) e todas as gaiolas permaneceram dentro de um
#' único tanque de grande porte.
#' Durante a manipulação, os peixes de uma gaiola da ração **C** (replicata 5)
#' escaparam; por isso há apenas **19 observações** no total.
#'
#' Este dataset é útil para **demonstrar análise de variância (ANOVA
#' unifatorial)**, comparando as médias de peso entre as quatro rações.
#'
#' @format Um data frame com 19 linhas e 2 variáveis:
#' \describe{
#'   \item{racao}{Fator indicando a ração oferecida.
#'                Níveis: `"A"`, `"B"`, `"C"` e `"D"`.}
#'   \item{peso_g}{Variável numérica contínua: peso médio final dos peixes
#'                 por gaiola, em **gramas (g)**.}
#' }
#'
#' @details
#' Questões que podem ser investigadas com estes dados:
#' \enumerate{
#'   \item Existe diferença significativa entre as médias de peso para as
#'         quatro rações?
#'   \item Qual ração resulta no maior ganho de peso médio?
#'   \item Como interpretar os resultados de um teste de Tukey após a ANOVA?
#' }
#' Recomenda-se aplicar uma **ANOVA unidirecional** (nível de significância
#' \eqn{\alpha = 0{,}05}) e, se significativa, um **pós-teste de comparações
#' múltiplas** (por exemplo, Tukey HSD).
#'
#' @source Dados adaptados do livro *Statistics for Aquaculture*
#'   (Ram C. Bhujel, Wiley-Blackwell, 2009, ISBN 978-0-813-81587-9).
#'
#' @docType data
#' @keywords datasets aquicultura anova bagre
#' @name isoproteica
#' @usage data(isoproteica)
#'
#' @examples
#' data(isoproteica)
#' summary(isoproteica)
#'
#' ## Boxplot com pontos individuais (requer ggplot2):
#' if (requireNamespace("ggplot2", quietly = TRUE)) {
#'   library(ggplot2)
#'   ggplot(isoproteica, aes(racao, peso_g, fill = racao)) +
#'     geom_boxplot(alpha = 0.7, width = 0.6, colour = "white") +
#'     geom_jitter(width = 0.1, size = 2, alpha = 0.6) +
#'     labs(title = "Peso final de bagres por ração",
#'          x = "Ração", y = "Peso (g)") +
#'     theme_minimal()
#' }
#'
#' ## ANOVA e teste de Tukey:
#' modelo <- aov(peso_g ~ racao, data = isoproteica)
#' summary(modelo)          # resultado da ANOVA
#' if (anova(modelo)[["Pr(>F)"]][1] < 0.05) {
#'   TukeyHSD(modelo)       # comparações múltiplas se ANOVA significativa
#' }
"isoproteica"   # Nome do objeto salvo em .rda — NÃO use @export!
