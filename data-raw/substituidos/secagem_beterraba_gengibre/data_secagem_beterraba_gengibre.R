#' Secagem de beterraba e gengibre sob diferentes condições
#'
#' @description
#' Razão de umidade durante a secagem em ar forçado de dois produtos vegetais,
#' com ou sem pré-tratamento e a 60, 70 ou 80 °C. É uma base real para estudar
#' curvas de decaimento e comparar séries experimentais.
#'
#' @format Um data frame com 594 observações e 8 variáveis:
#' \describe{
#'   \item{id_serie}{Fator: combinação de produto, tratamento, temperatura e réplica.}
#'   \item{id_amostra}{Texto: identificador original da observação.}
#'   \item{produto_codigo}{Fator: código B ou G usado pela fonte.}
#'   \item{tratamento_codigo}{Fator: código C ou E usado pela fonte.}
#'   \item{temperatura_c}{Numérico: temperatura do ar de secagem, em °C.}
#'   \item{repeticao}{Inteiro: réplica de secagem.}
#'   \item{tempo_origem}{Numérico: tempo informado pela fonte; a unidade não foi declarada.}
#'   \item{razao_umidade}{Numérico: razão de umidade sem unidade, igual a 1 no início da série.}
#' }
#'
#' @details
#' A fonte descreve cubos de beterraba e fatias de gengibre, com pré-tratamento
#' em etanol a 50\% ou controle. Contudo, ela não declara qual dos códigos B/G
#' identifica cada produto nem qual dos códigos C/E identifica cada tratamento.
#' Também não informa a unidade da coluna original \code{time}. Por honestidade,
#' o conjunto preserva os códigos e chama o tempo de \code{tempo_origem}; antes
#' de interpretar uma meia-vida em minutos ou horas, confirme esses metadados
#' com o depositante.
#'
#' Cada série é uma amostra de produto acompanhada na sua réplica de secagem.
#' Para um exemplo introdutório, filtre uma única \code{id_serie}, ajuste
#' \code{razao_umidade ~ a + b * exp(-k * tempo_origem)} e compare o resultado
#' com uma reta. O conjunto completo permite, depois de confirmar os códigos,
#' comparar a taxa \code{k} entre condições.
#'
#' @source Granella, S. (2025). \emph{Drying kinetics (MR) data and AI model
#' scripts for ethanol-pretreated beetroot and ginger}. Mendeley Data.
#' DOI: \doi{10.17632/zkvb73tn79.1}. Licença CC BY 4.0.
#'
#' @docType data
#' @keywords datasets secagem regressao-nao-linear decaimento
#' @name secagem_beterraba_gengibre
#' @usage data(secagem_beterraba_gengibre)
#'
#' @examples
#' data(secagem_beterraba_gengibre)
#' serie <- subset(secagem_beterraba_gengibre, id_serie == levels(id_serie)[1])
#' modelo <- nls(razao_umidade ~ a + b * exp(-k * tempo_origem), data = serie,
#'               start = list(a = min(serie$razao_umidade),
#'                            b = max(serie$razao_umidade) - min(serie$razao_umidade),
#'                            k = 0.01),
#'               algorithm = "port", lower = c(a = 0, b = 0, k = 0))
#' coef(modelo)
"secagem_beterraba_gengibre"
