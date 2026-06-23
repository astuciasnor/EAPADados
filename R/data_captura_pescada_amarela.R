#' Capturas de Pescada-Amarela por Embarcacao (versao TRATADA)
#'
#' @description
#' Versao \strong{tratada} (limpa e \emph{tidy}) de um conjunto real de capturas
#' de pescada-amarela (\emph{Cynoscion acoupa}) por embarcacoes artesanais, com
#' registros mensais de sete embarcacoes (B1 a B7), entre 2019 e 2021. Resulta
#' do tratamento aplicado a \code{\link{captura_pescada_amarela_bruta}},
#' espelhando o exemplo de limpeza do livro. Adequado a comparacao de medias e
#' de postos (teste t / Mann-Whitney por periodo ou aparelho; ANOVA /
#' Kruskal-Wallis por embarcacao), regressao (CPUE vs precipitacao) e
#' visualizacao.
#'
#' @details
#' Apos o tratamento: \code{periodo_sazonal} tem 2 niveis (chuvoso, seco, com
#' 126 viagens cada); \code{nome_aparelho_pesca} tem 2 niveis (Espinhel = 180,
#' Rede = 72); cada embarcacao soma 36 viagens; a data invalida foi corrigida;
#' \code{mes} e um fator ordenado de Janeiro a Dezembro; e a CPUE foi arredondada
#' a 2 casas. Sugestoes de uso: \code{cpue ~ periodo_sazonal} (2 grupos),
#' \code{cpue ~ nome_aparelho_pesca} (2 grupos) e \code{cpue ~ embarcacao}
#' (7 grupos).
#'
#' @format Um data frame com 252 observacoes e 16 variaveis:
#' \describe{
#'   \item{embarcacao}{Identificador da embarcacao (fator; B1 a B7).}
#'   \item{tamanho_m}{Comprimento da embarcacao, em metros (numerico).}
#'   \item{precipitacao}{Precipitacao acumulada no periodo, em mm (numerico).}
#'   \item{mes}{Mes da viagem (fator ordenado: Janeiro < ... < Dezembro).}
#'   \item{ano}{Ano da viagem (inteiro; 2019 a 2021).}
#'   \item{periodo_sazonal}{Estacao do ano (fator: chuvoso, seco).}
#'   \item{mes_ano}{Mes/ano de referencia (Date).}
#'   \item{data_de_saida}{Data de saida ao mar (Date).}
#'   \item{data_de_chegada}{Data de chegada (Date).}
#'   \item{dias_ao_mar}{Duracao da viagem, em dias (inteiro).}
#'   \item{cpue_pescada}{Captura por unidade de esforco da pescada-amarela
#'     (numerico).}
#'   \item{cpue}{Captura por unidade de esforco total (numerico).}
#'   \item{pessoal_embarcado}{Numero de tripulantes (inteiro; 8 ou 10).}
#'   \item{peso_balanca}{Peso total registrado na balanca, em kg (inteiro).}
#'   \item{nome_aparelho_pesca}{Aparelho de pesca (fator: Espinhel, Rede).}
#'   \item{quantidade_aparelho_pesca}{Quantidade/medida do aparelho (inteiro).}
#' }
#'
#' @source Dados reais (ainda nao publicados) do grupo de pesquisa.
#'   <COMPLETAR: autoria/coleta (Lucas et al.), local, periodo e referencia.>
#'   Documentacao mais detalhada (metadados e imagens) a ser adicionada.
#' @docType data
#' @keywords datasets pesca cpue teste-t kruskal-wallis regressao
#' @name captura_pescada_amarela
#' @usage data(captura_pescada_amarela)
#'
#' @seealso \code{\link{captura_pescada_amarela_bruta}} (versao bruta, para limpeza).
#'
#' @examples
#' data(captura_pescada_amarela)
#' summary(captura_pescada_amarela)
#'
#' # CPUE por estacao (2 grupos -> teste t ou Mann-Whitney)
#' tapply(captura_pescada_amarela$cpue,
#'        captura_pescada_amarela$periodo_sazonal, median)
#'
#' # CPUE por embarcacao (7 grupos -> ANOVA ou Kruskal-Wallis)
#' if (requireNamespace("ggplot2", quietly = TRUE)) {
#'   ggplot2::ggplot(captura_pescada_amarela,
#'                   ggplot2::aes(x = embarcacao, y = cpue)) +
#'     ggplot2::geom_boxplot()
#' }
"captura_pescada_amarela"
