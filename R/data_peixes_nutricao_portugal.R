#' Composição nutricional de peixes comercializados em Portugal
#'
#' @description
#' Composição nutricional (macronutrientes, ácidos graxos e minerais) de espécies
#' de peixes vendidas em Portugal. Cada linha é uma espécie. Base enxuta para
#' \strong{ACP/PCA}, \strong{AAH/HCA}, k-means, heatmap e correlação em ciência
#' do pescado.
#'
#' @format Um data frame com 40 observações e 22 variáveis:
#' \describe{
#'   \item{id_base}{Inteiro: identificador da espécie na base original.}
#'   \item{nome_comum}{Texto: nome comum do peixe.}
#'   \item{nome_cientifico}{Texto: nome científico.}
#'   \item{cluster_autores}{Fator: agrupamento publicado pelos autores (rótulo auxiliar).}
#'   \item{perfil_nutricional_autores}{Fator: \code{magros}, \code{gordos}, \code{atipicos} (rótulo dos autores).}
#'   \item{energia_kcal_100g}{Inteiro: energia (kcal/100 g).}
#'   \item{proteina_g_100g}{Numérico: proteína (g/100 g).}
#'   \item{lipideos_g_100g}{Numérico: lipídeos (g/100 g).}
#'   \item{umidade_g_100g}{Numérico: umidade (g/100 g).}
#'   \item{cinzas_g_100g}{Numérico: cinzas (g/100 g).}
#'   \item{sfa_g_100g}{Numérico: ácidos graxos saturados (g/100 g).}
#'   \item{mufa_g_100g}{Numérico: ácidos graxos monoinsaturados (g/100 g).}
#'   \item{pufa_g_100g}{Numérico: ácidos graxos poli-insaturados (g/100 g).}
#'   \item{epa_g_100g}{Numérico: EPA (g/100 g).}
#'   \item{dha_g_100g}{Numérico: DHA (g/100 g).}
#'   \item{sodio_mg_100g}{Inteiro: sódio (mg/100 g).}
#'   \item{potassio_mg_100g}{Inteiro: potássio (mg/100 g).}
#'   \item{calcio_mg_100g}{Numérico: cálcio (mg/100 g).}
#'   \item{fosforo_mg_100g}{Inteiro: fósforo (mg/100 g).}
#'   \item{magnesio_mg_100g}{Inteiro: magnésio (mg/100 g).}
#'   \item{ferro_mg_100g}{Numérico: ferro (mg/100 g).}
#'   \item{zinco_mg_100g}{Numérico: zinco (mg/100 g).}
#' }
#'
#' @details
#' Evite misturar variáveis brutas com índices derivados na mesma ACP. O cluster
#' dos autores serve apenas para comparar com os agrupamentos obtidos em aula.
#'
#' @source Jorge, A. O.; Oliveira, M. B. P. P.; Prieto, M. A. (2025).
#'   \emph{Nutritional Composition and Derived Indices of Fish Species Sold in
#'   Portugal}. Mendeley Data. DOI: 10.17632/3wvbgtwkfz.1 (licença CC BY 4.0).
#'   Adaptação didática da aba RAW_DATA (40 espécies completas).
#' @docType data
#' @encoding UTF-8
#' @keywords datasets pescado multivariada
#' @name peixes_nutricao_portugal
#' @usage data(peixes_nutricao_portugal)
#'
#' @examples
#' data(peixes_nutricao_portugal)
#' vars <- c("proteina_g_100g", "lipideos_g_100g", "umidade_g_100g",
#'           "cinzas_g_100g", "sfa_g_100g", "mufa_g_100g", "pufa_g_100g",
#'           "epa_g_100g", "dha_g_100g")
#' prcomp(peixes_nutricao_portugal[, vars], scale. = TRUE)
"peixes_nutricao_portugal"
