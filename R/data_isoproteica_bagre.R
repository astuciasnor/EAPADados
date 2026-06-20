#' Peso Final de Bagres Alimentados com Racoes Comerciais Iso-Proteicas
#'
#' @description
#' Pesos medios finais (g) de bagres (\emph{Ictalurus} spp.) submetidos a
#' \strong{quatro racoes comerciais iso-proteicas} (mesmo teor de proteina
#' bruta), porem com \strong{niveis de lipidios diferentes}. Os dados reproduzem
#' a \strong{Tabela 7.4} de Bhujel (2011) e constituem o exemplo classico de
#' \strong{Delineamento Inteiramente Casualizado (DIC / CRD)} analisado por
#' \strong{ANOVA unifatorial} naquele livro.
#'
#' No ensaio original, 50 peixes foram estocados em cada gaiola e quatro gaiolas
#' (replicatas) por racao foram instaladas dentro de um \strong{unico tanque de
#' grande porte} \emph{(single large pond)}, mantendo as demais condicoes
#' constantes. Durante o manejo, os peixes de uma gaiola da racao \code{"C"}
#' (replicata 5) \strong{escaparam}; por isso a racao \code{C} tem apenas 4
#' replicatas e o conjunto e \strong{desbalanceado}, totalizando
#' \strong{19 observacoes}.
#'
#' Cada valor de \code{peso_g} e a \strong{media} do peso final dos 50 peixes de
#' uma gaiola (a gaiola e a unidade experimental, nao o peixe individual).
#'
#' @format Um data frame (\code{data.frame}) com 19 linhas e 2 variaveis:
#' \describe{
#'   \item{racao}{Fator com 4 niveis indicando a racao comercial iso-proteica
#'     oferecida: \code{"A"}, \code{"B"}, \code{"C"} e \code{"D"}. No livro
#'     correspondem a \emph{Feed 1, Feed 2, Feed 3} e \emph{Feed 4},
#'     respectivamente. As racoes diferem apenas no nivel de lipidios.}
#'   \item{peso_g}{Numerica continua: peso medio final dos peixes da gaiola,
#'     em \strong{gramas (g)}.}
#' }
#'
#' @details
#' \strong{Desenho experimental.} Delineamento Inteiramente Casualizado (DIC),
#' fator unico (tipo de racao) com 4 niveis e 5 replicatas planejadas por nivel
#' (uma perdida em \code{C}). Modelo:
#' \deqn{Y_{ij} = m + T_i + R_{ij}}
#' em que \eqn{m} e a media geral, \eqn{T_i} o efeito da racao \eqn{i} e
#' \eqn{R_{ij}} o erro aleatorio.
#'
#' \strong{Hipoteses.}
#' \eqn{H_0: \mu_A = \mu_B = \mu_C = \mu_D} (as racoes nao diferem) contra
#' \eqn{H_1:} ao menos uma media difere.
#'
#' \strong{Totais por racao (conferem com o livro).}
#' \tabular{lrrr}{
#'   Racao \tab n \tab Total (g) \tab Media (g) \cr
#'   A (Feed 1) \tab 5 \tab 431 \tab 86,2 \cr
#'   B (Feed 2) \tab 5 \tab 444 \tab 88,8 \cr
#'   C (Feed 3) \tab 4 \tab 410 \tab 102,5 \cr
#'   D (Feed 4) \tab 5 \tab 463 \tab 92,6 \cr
#'   \strong{Geral} \tab \strong{19} \tab \strong{1748} \tab
#' }
#' (O livro arredonda as medias de C e D para 102,6 e 92,5; os totais e os
#' valores brutos aqui sao os exatos da Tabela 7.4.)
#'
#' \strong{Resultado esperado da ANOVA (Tabela 7.5 do livro).}
#' \tabular{lrrrr}{
#'   Fonte \tab SS \tab df \tab MS \tab F \cr
#'   Tratamento (racao) \tab 665 \tab 3 \tab 222 \tab 26 \cr
#'   Erro (residuo) \tab 128 \tab 15 \tab 9 \tab \cr
#'   Total \tab 793 \tab 18 \tab \tab
#' }
#' Como \eqn{F = 26 > F_{3;15;0,01} = 5,42}, rejeita-se \eqn{H_0}
#' (\eqn{P < 0,01}): ha efeito altamente significativo da racao sobre o
#' crescimento. Nas comparacoes multiplas do livro (LSD/Tukey, valor critico
#' de diferenca aproximado de 4,0 g): a racao \strong{C (Feed 3)} produz o maior
#' peso; \strong{D (Feed 4)} supera \strong{A (Feed 1)}; e os pares A-B e B-D
#' nao diferem significativamente.
#'
#' \strong{Questoes que o conjunto permite explorar.}
#' \enumerate{
#'   \item Ha diferenca significativa entre as medias de peso das quatro racoes?
#'   \item Qual racao proporciona o maior ganho de peso medio?
#'   \item Como conduzir e interpretar um pos-teste (Tukey HSD / LSD) apos a
#'         ANOVA, em um desenho \strong{desbalanceado}?
#'   \item Os pressupostos da ANOVA (normalidade dos residuos e homogeneidade
#'         de variancias) estao atendidos?
#' }
#' Sugere-se ANOVA unifatorial (\eqn{\alpha = 0,05}) e, se significativa,
#' comparacoes multiplas (Tukey HSD). Lembre-se de que a significancia
#' estatistica nao basta para a recomendacao pratica: o livro ressalta que o
#' \strong{valor economico} (preco da racao versus ganho de producao) tambem
#' deve ser considerado.
#'
#' @source
#' Bhujel, R. C. (2011). \emph{Statistics for Aquaculture} (1st ed.).
#' Wiley-Blackwell. Capitulo 7 (Experimental designs and analysis of variance),
#' \strong{Tabela 7.4}, p. 103. Disponivel em
#' \url{https://www.perlego.com/book/1006312/statistics-for-aquaculture-pdf}.
#'
#' @references
#' Bhujel, R. C. (2011). \emph{Statistics for Aquaculture} (1st ed.). Wiley.
#' (Obra original publicada em 2011.)
#'
#' @docType data
#' @keywords datasets aquicultura anova dic crd bagre catfish racao
#' @name isoproteica_bagre
#' @aliases isoproteica_bagre
#' @usage data(isoproteica_bagre)
#'
#' @examples
#' data(isoproteica_bagre)
#' str(isoproteica_bagre)
#' summary(isoproteica_bagre)
#'
#' ## Totais e medias por racao (conferem com a Tabela 7.4):
#' aggregate(peso_g ~ racao, data = isoproteica_bagre,
#'           FUN = function(x) c(n = length(x), soma = sum(x), media = mean(x)))
#'
#' ## Boxplot com pontos individuais (requer ggplot2):
#' if (requireNamespace("ggplot2", quietly = TRUE)) {
#'   library(ggplot2)
#'   ggplot(isoproteica_bagre, aes(racao, peso_g, fill = racao)) +
#'     geom_boxplot(alpha = 0.7, width = 0.6, colour = "white") +
#'     geom_jitter(width = 0.1, size = 2, alpha = 0.6) +
#'     labs(title = "Peso final de bagres por racao iso-proteica",
#'          x = "Racao (A-D)", y = "Peso medio final (g)") +
#'     theme_minimal()
#' }
#'
#' ## ANOVA unifatorial (reproduz a Tabela 7.5: SS_trat = 665, SS_erro = 128,
#' ## F ~ 26, P < 0,01):
#' modelo <- aov(peso_g ~ racao, data = isoproteica_bagre)
#' summary(modelo)
#'
#' ## Comparacoes multiplas se a ANOVA for significativa:
#' if (anova(modelo)[["Pr(>F)"]][1] < 0.05) {
#'   TukeyHSD(modelo)
#' }
"isoproteica_bagre"   # Nome do objeto salvo em .rda - NAO use @export!
