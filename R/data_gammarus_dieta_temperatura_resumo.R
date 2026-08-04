#' Resumo de sobrevivência e crescimento de Gammarus sob dieta e temperatura
#'
#' @description
#' Médias e desvios-padrão publicados para juvenis do anfípode marinho
#' \emph{Gammarus locusta} mantidos por 21 dias em um experimento fatorial
#' com três dietas e quatro temperaturas. Cada linha é uma combinação de
#' tratamento; as quatro repetições são representadas apenas por média, desvio-
#' padrão e tamanho amostral.
#'
#' @format Um data frame com 12 observações e 11 variáveis:
#' \describe{
#'   \item{dieta}{Fator: Fucus, folhas de cenoura ou polpa de coco.}
#'   \item{temperatura_c}{Numérico: temperatura experimental (°C).}
#'   \item{n_repeticoes}{Inteiro: número de recipientes por combinação (4).}
#'   \item{sobrevivencia_media_pct}{Numérico: média da sobrevivência (\%).}
#'   \item{sobrevivencia_dp_pct}{Numérico: desvio-padrão da sobrevivência (\%).}
#'   \item{biomassa_media_mg}{Numérico: média da biomassa final (mg).}
#'   \item{biomassa_dp_mg}{Numérico: desvio-padrão da biomassa final (mg).}
#'   \item{comprimento_final_medio_mm}{Numérico: média do comprimento final (mm).}
#'   \item{comprimento_final_dp_mm}{Numérico: desvio-padrão do comprimento final (mm).}
#'   \item{taxa_crescimento_especifica_media_pct_dia}{Numérico: média da taxa de crescimento específico (\% por dia).}
#'   \item{taxa_crescimento_especifica_dp_pct_dia}{Numérico: desvio-padrão da taxa de crescimento específico (\% por dia).}
#' }
#'
#' @details
#' Esta é uma tabela de resumo, e não uma base com as 48 repetições. Ela é
#' apropriada para gráficos de médias com barras de erro, descrição do
#' delineamento e interpretação dos resultados reportados pelos autores. Não
#' deve ser usada para recalcular ANOVA, pressupostos ou comparações múltiplas;
#' para isso seriam necessários os valores de cada recipiente.
#'
#' @source Ribes-Navarro, A.; Alberts-Hubatsch, H.; Monroig, Ó.; Hontoria, F.;
#'   Navarro, J. C. (2022). \emph{Effects of diet and temperature on the fatty
#'   acid composition of the gammarid Gammarus locusta fed alternative
#'   terrestrial feeds}. \emph{Frontiers in Marine Science}, 9, 931991.
#'   DOI: https://doi.org/10.3389/fmars.2022.931991. Licença CC BY.
#'   Valores transcritos da Table 1 do artigo.
#'
#' @docType data
#' @encoding UTF-8
#' @keywords datasets aquicultura anova fatorial crescimento
#' @name gammarus_dieta_temperatura_resumo
#' @usage data(gammarus_dieta_temperatura_resumo)
#'
#' @examples
#' data(gammarus_dieta_temperatura_resumo)
#' with(gammarus_dieta_temperatura_resumo,
#'      interaction.plot(temperatura_c, dieta, sobrevivencia_media_pct))
#'
"gammarus_dieta_temperatura_resumo"
