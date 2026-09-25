#' Morfometria de abalones adultos da Tasmânia
#'
#' @description
#' Medidas de concha e peso de abalones do gênero \emph{Haliotis} coletados por
#' biólogos pesqueiros na Tasmânia (Austrália), com sexo e número de anéis de
#' crescimento. Base real e grande (n = 2.641), pensada para
#' \strong{estatística descritiva e análise exploratória}: tem uma variável
#' aproximadamente normal (altura), outras assimétricas (pesos), dimorfismo
#' sexual discreto e tamanho de amostra suficiente para demonstrar a
#' hipersensibilidade do teste de Shapiro-Wilk com n grande.
#'
#' @format Um data frame com 2.641 observações e 9 variáveis:
#' \describe{
#'   \item{sexo}{Fator: \code{Femea} ou \code{Macho}.}
#'   \item{comprimento_mm}{Numérico: maior dimensão da concha (mm).}
#'   \item{diametro_mm}{Numérico: largura perpendicular ao comprimento (mm).}
#'   \item{altura_mm}{Numérico: altura do animal com a concha (mm).}
#'   \item{peso_total_g}{Numérico: peso do animal inteiro (g).}
#'   \item{peso_carne_g}{Numérico: peso da carne após retirar da concha (g).}
#'   \item{peso_visceras_g}{Numérico: peso das vísceras (g).}
#'   \item{peso_concha_g}{Numérico: peso da concha seca (g).}
#'   \item{aneis}{Inteiro: número de anéis de crescimento; a idade é
#'     aproximadamente \code{aneis + 1,5} anos.}
#' }
#'
#' @details
#' O conjunto original passou por \strong{pequenas arrumações}, documentadas no
#' script \code{data-raw/preparar_abalone.R} (o bruto original permanece
#' preservado em \code{data-raw/curados/abalone_bruto_uci.csv}):
#' \enumerate{
#'   \item \strong{Unidades restauradas} (× 200): o arquivo distribuído traz as
#'     medidas divididas por 200; a calibração bate com o tamanho máximo da
#'     espécie (~163 mm) e com o tamanho mínimo legal de captura na Tasmânia
#'     (132 mm).
#'   \item \strong{Imaturos excluídos}: 1.342 registros com sexo \code{I}
#'     (juvenis ainda não sexáveis) — misturá-los aos adultos distorceria as
#'     distribuições.
#'   \item \strong{Alturas impossíveis removidas}: 3 registros com altura
#'     ≤ 0 ou razão altura/diâmetro > 0,55 (a razão típica é ~0,34), erro
#'     evidente de digitação ou mensura.
#'   \item \strong{Recorte nos adultos}: apenas animais com 8 anéis ou mais
#'     (2.641 registros).
#' }
#' A altura é a variável aproximadamente normal (assimetria ≈ −0,1); os pesos
#' puxam para a direita (assimetria ≈ +0,45 a +0,7), pois peso cresce com o
#' cubo do comprimento — bom gancho para transformação logarítmica. Com
#' n > 2.600, o Shapiro-Wilk rejeita quase tudo: use gráficos (histograma,
#' QQ) e, para o teste, subamostras (ex.: 200 por sexo, com semente fixa).
#'
#' @source Nash, W. J.; Sellers, T. A.; Talbot, S. R.; Cawthorn, A. J.;
#'   Ford, W. B. (1994). The Population Biology of Abalone
#'   (\emph{Haliotis} species) in Tasmania. I. Blacklip Abalone
#'   (\emph{H. rubra}) from the North Coast and Islands of Bass Strait.
#'   Marine and Freshwater Research, 45(6), 1229–1250. Distribuído pelo UCI
#'   Machine Learning Repository:
#'   \url{https://archive.ics.uci.edu/dataset/1/abalone}.
#' @docType data
#' @encoding UTF-8
#' @keywords datasets bioecologia descritiva
#' @name abalone_adultos
#' @usage data(abalone_adultos)
#'
#' @examples
#' data(abalone_adultos)
#' str(abalone_adultos)
#'
#' # Descritiva por sexo para a altura (a variável aproximadamente normal)
#' aggregate(altura_mm ~ sexo, data = abalone_adultos,
#'           FUN = function(x) c(media = mean(x), dp = sd(x)))
#'
#' # A armadilha do n grande: Shapiro rejeita na base cheia...
#' shapiro.test(abalone_adultos$altura_mm)$p.value
#' # ...e aceita numa subamostra de 200 por sexo (semente fixa)
#' set.seed(42)
#' sub <- do.call(rbind, lapply(split(abalone_adultos, abalone_adultos$sexo),
#'                              function(g) g[sample(nrow(g), 200), ]))
#' shapiro.test(sub$altura_mm)$p.value
"abalone_adultos"
