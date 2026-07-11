#' Idade e comprimento da percina-do-canal em dois rios de Ontário
#'
#' @description
#' Idade, comprimento total e local de captura de exemplares de
#' \emph{Percina copelandi} (channel darter, percina-do-canal), um pequeno peixe
#' de água doce, coletados nos rios Salmon e Trent (Ontário, Canadá). A idade foi
#' estimada pela leitura de otólitos e o comprimento medido com precisão de
#' 0,1 mm. Base pequena (54 indivíduos), ideal para o \strong{teste de
#' Mann–Whitney} (comparação de dois grupos independentes).
#'
#' @format Um data frame com 54 observações e 3 variáveis:
#' \describe{
#'   \item{idade_anos}{Inteiro: idade estimada pelo otólito, em anos.}
#'   \item{comprimento_total_mm}{Numérico: comprimento total (mm).}
#'   \item{rio}{Fator: rio de captura, com níveis \code{Salmon} e \code{Trent}.}
#' }
#'
#' @details
#' Pergunta sugerida: a distribuição das idades difere entre os rios Salmon e
#' Trent? Aplique Mann–Whitney com \code{idade_anos} como resposta e \code{rio}
#' como agrupamento. A idade é discreta e com poucos valores, então há
#' \strong{empates} nos postos — use a aproximação para dados com empates (sem
#' exigir o cálculo exato). Interprete em termos de posição/mediana das
#' distribuições, não como simples comparação de médias; a leitura por mediana é
#' mais segura quando as duas distribuições têm formatos semelhantes.
#'
#' Cuidados: os dados vêm de amostragem (pesca elétrica), que pode subamostrar
#' os exemplares menores/mais jovens; diferenças podem refletir a estrutura
#' etária ou o processo de captura. Não misture idade e comprimento no mesmo
#' teste — o comprimento é fortemente influenciado pela idade.
#'
#' @source Reconstruído da Figura 2 de Reid, S. M. (2004). \emph{Age estimates
#'   and length distributions of Ontario channel darter (Percina copelandi)
#'   populations}. Journal of Freshwater Ecology 19:441-444. Obtido do pacote
#'   \pkg{FSAdata} (dataset \code{DarterOnt}), licença GPL-2 | GPL-3.
#' @docType data
#' @encoding UTF-8
#' @keywords datasets pesca naoparametrico
#' @name darter_ontario
#' @usage data(darter_ontario)
#'
#' @examples
#' data(darter_ontario)
#' summary(darter_ontario)
#' # Mann-Whitney: idade entre os dois rios (com empates)
#' wilcox.test(idade_anos ~ rio, data = darter_ontario, exact = FALSE)
#'
#' # Descritivas por rio
#' aggregate(idade_anos ~ rio, data = darter_ontario, FUN = summary)
"darter_ontario"
