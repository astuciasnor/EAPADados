#' Resumo Estatistico da Morfometria de Caranguejos
#'
#' @description
#' Calcula estatisticas descritivas (media, desvio padrao e contagem)
#' para as variaveis Largura da Carapaca (LC) e Comprimento da Carapaca (CC)
#' do conjunto de dados de morfometria de caranguejos, agrupadas por Sexo e Estacao.
#'
#' @param data Um data frame. Espera-se que contenha as colunas `Sexo`, `Estacao`,
#'   `LC` e `CC`. Se `NULL` (o padrao), a funcao tentara carregar e usar
#'   o dataset `morfometria_caranguejos` do pacote `EAPADados`.
#'
#' @return Um `tibble` (data frame do `dplyr`) com as seguintes colunas:
#'   \item{Sexo}{Fator indicando o sexo dos individuos.}
#'   \item{Estacao}{Fator indicando a estacao de captura.}
#'   \item{media_LC}{Media da Largura da Carapaca (LC) em mm.}
#'   \item{dp_LC}{Desvio padrao da Largura da Carapaca (LC) em mm.}
#'   \item{media_CC}{Media do Comprimento da Carapaca (CC) em mm.}
#'   \item{dp_CC}{Desvio padrao do Comprimento da Carapaca (CC) em mm.}
#'   \item{n}{Numero de observacoes (tamanho da amostra) para cada grupo.}
#'
#' @details
#' A funcao utiliza pacotes `dplyr` para manipulacao de dados e `magrittr`
#' para o operador pipe `%>%`. Para usar o dataset padrao, o pacote `EAPADados`
#' deve estar instalado.
#' As colunas `LC` e `CC` devem ser numericas. `Sexo` e `Estacao` devem ser
#' fatores ou caracteres que possam ser convertidos em fatores para agrupamento.
#'
#' @importFrom magrittr %>%
#' @importFrom dplyr group_by summarize n
#' @importFrom stats sd
#' @export
#'
#' @examples
#' # Para rodar os exemplos, o pacote EAPADados deve estar instalado.
#' # Se o pacote estiver carregado (ex: library(EAPADados)),
#' # o dataset morfometria_caranguejos estara disponivel.
#'
#' # Exemplo 1: Usando o dataset padrao (morfometria_caranguejos do pacote)
#' if (requireNamespace("EAPADados", quietly = TRUE)) {
#'   print("Calculando resumo com dataset padrao:")
#'   resumo1 <- summarize_morfometria()
#'   print(resumo1)
#' } else {
#'   print("Pacote EAPADados nao instalado. Exemplo 1 pulado.")
#' }
#'
#' # Exemplo 2: Fornecendo um data frame externo
#' # Criando um data frame de exemplo similar ao esperado pela funcao
#' dados_exemplo <- data.frame(
#'   Sexo = factor(rep(c("Macho", "Femea"), each = 10)),
#'   Estacao = factor(rep(c("Seca", "Chuvosa"), times = 10)),
#'   LC = rnorm(20, mean = 60, sd = 5),
#'   CC = rnorm(20, mean = 40, sd = 4)
#' )
#' print("Calculando resumo com dataset de exemplo fornecido:")
#' resumo2 <- summarize_morfometria(data = dados_exemplo)
#' print(resumo2)
#'
#' # Exemplo 3: Usando um subconjunto do dataset do pacote (se carregado)
#' \dontrun{
#' if (requireNamespace("EAPADados", quietly = TRUE) && exists("morfometria_caranguejos")) {
#'   library(EAPADados) # Garante que morfometria_caranguejos esteja acessivel
#'   dados_pequenos <- head(morfometria_caranguejos, 15)
#'   resumo3 <- summarize_morfometria(data = dados_pequenos)
#'   print(resumo3)
#' }
#' }
summarize_morfometria <- function(data = NULL) {

  # Checagem de dependencias de Imports
  if (!requireNamespace("dplyr", quietly = TRUE)) {
    stop("O pacote 'dplyr' e necessario. Por favor, instale-o.", call. = FALSE)
  }
  if (!requireNamespace("magrittr", quietly = TRUE)) {
    stop("O pacote 'magrittr' e necessario. Por favor, instale-o.", call. = FALSE)
  }

  # Se nenhum dado for fornecido, tenta usar o dataset padrao do pacote
  if (is.null(data)) {
    if (requireNamespace("EAPADados", quietly = TRUE)) {
      # Carrega o dataset 'morfometria_caranguejos' do pacote 'EAPADados'
      # em um ambiente temporario para evitar poluir o ambiente global
      # e para ser explicito para o R CMD check.
      data_env <- new.env(parent = emptyenv())
      utils::data("morfometria_caranguejos", package = "EAPADados", envir = data_env)
      if (!exists("morfometria_caranguejos", envir = data_env)) {
        stop("Dataset 'morfometria_caranguejos' nao encontrado no pacote 'EAPADados'.", call. = FALSE)
      }
      data <- data_env$morfometria_caranguejos
    } else {
      stop("Pacote 'EAPADados' nao instalado. Forneca o argumento 'data' ou instale 'EAPADados'.", call. = FALSE)
    }
  }

  # Validacao basica das colunas esperadas no objeto 'data'
  colunas_esperadas <- c("Sexo", "Estacao", "LC", "CC")
  if (!all(colunas_esperadas %in% names(data))) {
    colunas_faltantes <- colunas_esperadas[!colunas_esperadas %in% names(data)]
    stop(paste("O data frame fornecido nao contem as colunas esperadas:",
               paste(colunas_faltantes, collapse = ", ")), call. = FALSE)
  }
  if (!is.numeric(data$LC) || !is.numeric(data$CC)) {
    stop("As colunas 'LC' e 'CC' devem ser numericas.", call. = FALSE)
  }

  # Processamento dos dados
  resultado <- data %>%
    dplyr::group_by(Sexo, Estacao) %>%
    dplyr::summarize(
      media_LC = mean(LC, na.rm = TRUE),
      dp_LC    = stats::sd(LC, na.rm = TRUE), # Explicitando stats::sd
      media_CC = mean(CC, na.rm = TRUE),
      dp_CC    = stats::sd(CC, na.rm = TRUE), # Explicitando stats::sd
      n        = dplyr::n(),
      .groups  = "drop" # Boa pratica para evitar agrupamento residual
    )

  return(resultado)
}

# Declaracao para R CMD check sobre variaveis globais usadas em dplyr
if (getRversion() >= "2.15.1") {
  utils::globalVariables(c("Sexo", "Estacao", "LC", "CC"))
}
