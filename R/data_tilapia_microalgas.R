#' Tilápia-do-Nilo alimentada com microalgas marinhas
#'
#' @description
#' Crescimento, sobrevivência, qualidade da água e índices hemato-bioquímicos de
#' alevinos de tilápia-do-Nilo (\emph{Oreochromis niloticus}) alimentados com
#' microalgas marinhas selecionadas. Cada linha é um tanque/réplica. Serve para
#' \strong{regressão múltipla} e \strong{PCA/ACP} exploratória em aquicultura.
#'
#' @format Um data frame com 15 observações e 32 variáveis:
#' \describe{
#'   \item{id_tanque}{Identificador do tanque (texto, minúsculas).}
#'   \item{tratamento_codigo}{Fator: código do tratamento/réplica (ex.: \code{CR1}, \code{N25R2}).}
#'   \item{tipo_microalga}{Fator: \code{controle}, \code{nannochloropsis}, \code{tetraselmis}.}
#'   \item{nivel_substituicao_pct}{Inteiro: nível de substituição por microalga (\%).}
#'   \item{repeticao}{Inteiro: número da réplica.}
#'   \item{sgr_pct_dia}{Numérico: taxa de crescimento específico (\% por dia). Resposta.}
#'   \item{sobrevivencia_pct}{Numérico: sobrevivência (\%).}
#'   \item{peso_inicial_medio_g}{Numérico: peso médio inicial (g).}
#'   \item{peso_final_medio_g}{Numérico: peso médio final (g).}
#'   \item{peixes_estocados}{Inteiro: peixes estocados no tanque.}
#'   \item{peixes_colhidos}{Inteiro: peixes colhidos no tanque.}
#'   \item{temperatura_c}{Numérico: temperatura da água (°C).}
#'   \item{oxigenio_dissolvido_mg_l}{Numérico: oxigênio dissolvido (mg/L).}
#'   \item{ph}{Numérico: pH da água.}
#'   \item{tan_mg_l}{Numérico: nitrogênio amoniacal total (mg/L).}
#'   \item{no2_n_mg_l}{Numérico: nitrogênio de nitrito (mg/L).}
#'   \item{srp_mg_l}{Numérico: fósforo reativo solúvel (mg/L).}
#'   \item{rbc_10_6_ul}{Numérico: eritrócitos (10^6/µL).}
#'   \item{hemoglobina_g_dl}{Numérico: hemoglobina (g/dL).}
#'   \item{pcv_pct}{Numérico: hematócrito (\%).}
#'   \item{wbc_10_3_ul}{Numérico: leucócitos (10^3/µL).}
#'   \item{linfocitos_pct}{Numérico: linfócitos (\%).}
#'   \item{plaquetas_10_3_ul}{Numérico: plaquetas (10^3/µL).}
#'   \item{proteina_total_g_dl}{Numérico: proteína total sérica (g/dL).}
#'   \item{albumina_g_dl}{Numérico: albumina (g/dL).}
#'   \item{globulina_g_dl}{Numérico: globulina (g/dL).}
#'   \item{razao_albumina_globulina}{Numérico: razão albumina/globulina.}
#'   \item{glicose_mg_dl}{Numérico: glicose (mg/dL).}
#'   \item{triglicerideos_mg_dl}{Numérico: triglicerídeos (mg/dL).}
#'   \item{colesterol_mg_dl}{Numérico: colesterol (mg/dL).}
#'   \item{ureia_mg_dl}{Numérico: ureia (mg/dL).}
#'   \item{bun_mg_dl}{Numérico: nitrogênio ureico sanguíneo (mg/dL).}
#' }
#'
#' @details
#' Cuidado central: a unidade experimental é o \strong{tanque}, não os peixes
#' individuais. Modelo sugerido:
#' \code{sgr_pct_dia ~ tipo_microalga + nivel_substituicao_pct + temperatura_c +
#' oxigenio_dissolvido_mg_l + ph + tan_mg_l + no2_n_mg_l + srp_mg_l}.
#'
#' @source Amira, K. I.; Rahman, M. R.; Sikder, S.; Khatoon, H.; Afruj, J.;
#'   Haque, M. E.; Minhaz, T. M. (2021). \emph{Data on Growth, Survivability,
#'   Water quality and Hemato-biochemical Indices of Nile Tilapia fed with
#'   Selected Marine Microalgae}. Mendeley Data. DOI: 10.17632/hv5fg5r869.1
#'   (licença CC BY 4.0). Adaptação didática.
#' @docType data
#' @encoding UTF-8
#' @keywords datasets aquicultura regressao multivariada
#' @name tilapia_microalgas
#' @usage data(tilapia_microalgas)
#'
#' @examples
#' data(tilapia_microalgas)
#' summary(tilapia_microalgas)
#' lm(sgr_pct_dia ~ tipo_microalga + temperatura_c + oxigenio_dissolvido_mg_l,
#'    data = tilapia_microalgas)
"tilapia_microalgas"
