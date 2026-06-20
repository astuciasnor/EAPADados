#' Dicionário de variáveis dos conjuntos de amostragem
#'
#' Tabela que descreve, em português, cada variável dos conjuntos
#' \code{walleye_erie}, \code{snapper_hg} e \code{crabs_morfometria}: nome,
#' descrição, unidade, tipo e papel na amostragem (variável de interesse ou
#' estrato). Útil como apoio didático em amostragem aleatória simples (AAS) e
#' amostragem estratificada proporcional.
#'
#' @format Um data frame (tibble) com 6 colunas:
#' \describe{
#'   \item{base}{Nome do conjunto de dados ao qual a variável pertence.}
#'   \item{variavel}{Nome da variável, em português.}
#'   \item{descricao}{Descrição da variável.}
#'   \item{unidade}{Unidade de medida, quando aplicável (NA caso contrário).}
#'   \item{tipo}{Tipo da variável (inteiro, numérica, categórica, lógica, etc.).}
#'   \item{uso_na_amostragem}{Papel na amostragem (estrato, variável de interesse, etc.).}
#' }
#' @source Elaboração própria a partir das documentações dos pacotes FSAdata e MASS.
#' @docType data
#' @encoding UTF-8
#' @keywords datasets amostragem dicionario
#' @name dicionario_variaveis_amostragem
#' @usage data(dicionario_variaveis_amostragem)
#'
#' @examples
#' data(dicionario_variaveis_amostragem)
#' head(dicionario_variaveis_amostragem)
#' subset(dicionario_variaveis_amostragem, base == "walleye_erie")
"dicionario_variaveis_amostragem"


#' Referências dos conjuntos de amostragem
#'
#' Tabela com as referências bibliográficas e os títulos originais das
#' documentações dos conjuntos \code{walleye_erie}, \code{snapper_hg} e
#' \code{crabs_morfometria}, preservando os títulos no idioma original.
#'
#' @format Um data frame (tibble) com 4 colunas:
#' \describe{
#'   \item{base}{Nome do conjunto de dados.}
#'   \item{citacao_curta}{Citação curta (pacote/objeto de origem ou autores).}
#'   \item{referencia}{Título original da documentação ou referência bibliográfica.}
#'   \item{observacao}{Notas sobre o preparo dos dados para o EAPADados.}
#' }
#' @source Títulos originais das documentações dos pacotes FSAdata e MASS.
#' @docType data
#' @encoding UTF-8
#' @keywords datasets amostragem referencias
#' @name referencias_dados_amostragem
#' @usage data(referencias_dados_amostragem)
#'
#' @examples
#' data(referencias_dados_amostragem)
#' referencias_dados_amostragem
"referencias_dados_amostragem"
