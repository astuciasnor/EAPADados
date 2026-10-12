#' Desembarques Mensais de Anchova-do-Norte na Califórnia (1971–1991)
#'
#' @description
#' Série mensal real de desembarques da categoria de mercado anchova-do-norte
#' (*Anchovy, Northern*) em todos os portos da Califórnia, de janeiro de 1971
#' a dezembro de 1991. O conjunto tem 252 meses consecutivos, sem lacunas ou
#' zeros, e serve para explorar sazonalidade, tendência e autocorrelação em
#' séries temporais. Desembarque comercial não é medida direta de abundância
#' nem de tamanho do estoque.
#'
#' @format Um data frame com 252 observações e 6 variáveis:
#' \describe{
#'   \item{data}{Mês de referência, no primeiro dia do mês (Date). A fonte
#'     registra o dia 16; a mudança representa o período mensal.}
#'   \item{ano}{Ano do registro (integer; 1971 a 1991).}
#'   \item{mes}{Mês do registro (factor ordenado, de janeiro a dezembro).}
#'   \item{categoria_mercado}{Categoria de mercado (factor; anchova-do-norte).
#'     Não deve ser interpretada automaticamente como um estoque biológico puro.}
#'   \item{porto}{Agregação dos locais de desembarque (factor; todos_os_portos).}
#'   \item{desembarque_lb}{Peso desembarcado no mês, em libras (numeric).
#'     É o valor original disponibilizado pela fonte.}
#' }
#'
#' @details
#' A série é o recorte contínuo de 1971–1991 da categoria `Anchovy, Northern`,
#' com `port = All`, no conjunto California Fish Market Catch Landings, Short
#' List, 1928–2002, Monthly. O arquivo-fonte distribuído pelo ERDDAP é mantido
#' em `data-raw/anchova_norte_california_fonte.csv`; sua linha de unidades não
#' entra como observação no objeto.
#'
#' @section Utilidade no ecossistema:
#' Na **Trilha**, este é o exemplo da tela de Séries Temporais: permite ler a
#' ordem mensal, a sazonalidade, a tendência e a autocorrelação sem ocultar os
#' desembarques originais. Na **ClaRa**, o conjunto entra no catálogo para
#' leitura e estudo do formato de uma série mensal. A ClaRa ainda não tem um
#' verbo próprio para séries temporais; não se deve forçar esta série em uma
#' comparação de médias ou em uma regressão como se os meses fossem
#' observações independentes.
#'
#' @source California Department of Fish and Game (dados originais), distribuído
#'   pelo NOAA Southwest Fisheries Science Center, Environmental Research
#'   Division, ERDDAP. <https://coastwatch.pfeg.noaa.gov/erddap/info/erdCAMarCatSM/index.html>.
#'   A página do conjunto informa que os dados podem ser usados e redistribuídos
#'   gratuitamente; ela não nomeia uma licença Creative Commons.
#' @docType data
#' @keywords datasets pesca series-temporais desembarque
#' @name anchova_norte_california
#' @usage data(anchova_norte_california)
#'
#' @examples
#' data(anchova_norte_california)
#' serie <- stats::ts(anchova_norte_california$desembarque_lb,
#'                    start = c(1971, 1), frequency = 12)
#' plot(serie, ylab = "Desembarque (lb)", xlab = "Ano")
#' stats::acf(serie)
"anchova_norte_california"
