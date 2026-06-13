#' Dicionario de variaveis dos conjuntos de amostragem
#'
#' Tabela que descreve, em portugues, cada variavel dos conjuntos
#' \code{walleye_erie}, \code{snapper_hg} e \code{crabs_morfometria}: nome,
#' descricao, unidade, tipo e papel na amostragem (variavel de interesse ou
#' estrato). Util como apoio didatico em amostragem aleatoria simples (AAS) e
#' amostragem estratificada proporcional.
#'
#' @format Um data frame (tibble) com 6 colunas:
#' \describe{
#'   \item{base}{Nome do conjunto de dados ao qual a variavel pertence.}
#'   \item{variavel}{Nome da variavel, em portugues.}
#'   \item{descricao}{Descricao da variavel.}
#'   \item{unidade}{Unidade de medida, quando aplicavel (NA caso contrario).}
#'   \item{tipo}{Tipo da variavel (inteiro, numerica, categorica, logica, etc.).}
#'   \item{uso_na_amostragem}{Papel na amostragem (estrato, variavel de interesse, etc.).}
#' }
#' @source Elaboracao propria a partir das documentacoes dos pacotes FSAdata e MASS.
#' @docType data
#' @keywords datasets amostragem dicionario
#' @name dicionario_variaveis_amostragem
#' @usage data(dicionario_variaveis_amostragem)
#'
#' @examples
#' data(dicionario_variaveis_amostragem)
#' head(dicionario_variaveis_amostragem)
#' subset(dicionario_variaveis_amostragem, base == "walleye_erie")
"dicionario_variaveis_amostragem"


#' Referencias dos conjuntos de amostragem
#'
#' Tabela com as referencias bibliograficas e os titulos originais das
#' documentacoes dos conjuntos \code{walleye_erie}, \code{snapper_hg} e
#' \code{crabs_morfometria}, preservando os titulos no idioma original.
#'
#' @format Um data frame (tibble) com 4 colunas:
#' \describe{
#'   \item{base}{Nome do conjunto de dados.}
#'   \item{citacao_curta}{Citacao curta (pacote/objeto de origem ou autores).}
#'   \item{referencia}{Titulo original da documentacao ou referencia bibliografica.}
#'   \item{observacao}{Notas sobre o preparo dos dados para o EAPADados.}
#' }
#' @source Titulos originais das documentacoes dos pacotes FSAdata e MASS.
#' @docType data
#' @keywords datasets amostragem referencias
#' @name referencias_dados_amostragem
#' @usage data(referencias_dados_amostragem)
#'
#' @examples
#' data(referencias_dados_amostragem)
#' referencias_dados_amostragem
"referencias_dados_amostragem"
