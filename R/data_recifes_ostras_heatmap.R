#' Estrutura de recifes de ostras e assembleias de peixes
#'
#' @description
#' Levantamentos visuais de recifes de ostras, combinando fatores ecológicos
#' (sítio, zona, estação, ano) com métricas de estrutura do habitat e da
#' assembleia de peixes. Base compacta para \strong{heatmap}, correlação,
#' \strong{ACP/PCA} exploratória e comparação entre grupos.
#'
#' @format Um data frame com 301 observações e 26 variáveis:
#' \describe{
#'   \item{id_recife}{Texto: identificador do recife.}
#'   \item{id_levantamento}{Texto: identificador do levantamento (recife x estação x ano).}
#'   \item{sitio}{Fator: sítio (\code{OP-CR}, \code{SY-PH}, \code{SY-TP}).}
#'   \item{numero_recife}{Inteiro: número do recife.}
#'   \item{zona_recife}{Fator: zona (\code{Centre}, \code{Edge}, \code{Off}).}
#'   \item{estacao}{Fator: estação (\code{Summer}, \code{Winter}).}
#'   \item{ano}{Inteiro: ano do levantamento.}
#'   \item{avaliador_video}{Fator: avaliador do vídeo.}
#'   \item{duracao_video_min}{Inteiro: duração do vídeo (min).}
#'   \item{visibilidade_media_m}{Numérico: visibilidade média (m).}
#'   \item{pradaria_marinha_pct}{Numérico: cobertura de pradaria marinha (\%).}
#'   \item{riqueza_especies_zona}{Inteiro: riqueza de espécies na zona.}
#'   \item{indice_shannon_h}{Numérico: índice de diversidade de Shannon (H').}
#'   \item{abundancia_total}{Inteiro: abundância total de peixes.}
#'   \item{area_2d}{Numérico: área 2D do recife.}
#'   \item{indice_forma}{Numérico: índice de forma.}
#'   \item{indice_isometria}{Numérico: índice de isometria.}
#'   \item{indice_circularidade}{Numérico: índice de circularidade.}
#'   \item{indice_fractal}{Numérico: índice de dimensão fractal.}
#'   \item{indice_para}{Numérico: índice perímetro-área (PARA).}
#'   \item{perimetro}{Numérico: perímetro do recife.}
#'   \item{razao_perimetro_area}{Numérico: razão perímetro/área.}
#'   \item{distancia_media_recifes_proximos}{Numérico: distância média aos recifes próximos.}
#'   \item{distancia_vizinho_mais_proximo}{Numérico: distância ao vizinho mais próximo.}
#'   \item{rugosidade}{Numérico: rugosidade do habitat.}
#'   \item{area_3d}{Numérico: área 3D do recife.}
#' }
#'
#' @details
#' Cuidado metodológico: várias métricas estruturais se repetem entre
#' levantamentos do mesmo recife (descrevem o habitat, não o censo) — bom para
#' discutir pseudorrepetição e estrutura hierárquica.
#'
#' @source Bennett et al. (2025). \emph{Dataset on oyster reef structure and fish
#'   assemblages}. Zenodo, record 19993470. DOI: 10.5281/zenodo.19993470.
#'   Verificar a licença exata do registro Zenodo ao publicar.
#' @docType data
#' @encoding UTF-8
#' @keywords datasets ecologia multivariada
#' @name recifes_ostras_heatmap
#' @usage data(recifes_ostras_heatmap)
#'
#' @examples
#' data(recifes_ostras_heatmap)
#' aggregate(cbind(riqueza_especies_zona, indice_shannon_h, abundancia_total) ~
#'             zona_recife, data = recifes_ostras_heatmap, FUN = mean)
"recifes_ostras_heatmap"
