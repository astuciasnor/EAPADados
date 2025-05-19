#' @title Relação Peso-Comprimento do Cangulo (Balistes vetula)
#'
#' @description
#' Este conjunto de dados contém medidas de peso (em gramas) e comprimento
#' (em centímetros) de exemplares do peixe cangulo (`Balistes vetula`).
#' Os dados são especialmente úteis para ilustrar análises de regressão não linear,
#' como o ajuste do modelo de potência (W = a * L^b), e para demonstrar
#' transformações que visam a linearização de curvas de crescimento.
#'
#' @format Um data frame com 16 observações e 7 variáveis:
#'\describe{
#'   \item{comprimento_cm}{Numérico. Comprimento total do peixe, em centímetros (cm).}
#'   \item{p1}{Numérico. Primeira medida de peso de peixe, em gramas (g). Representa o peso de um individuo para aquele comprimento especifico}
#'   \item{p2}{Numérico. Segunda medida de peso do peixe, em gramas (g).}
#'   \item{p3}{Numérico. Terceira medida de peso do peixe, em gramas (g).}
#'   \item{peso_g}{Numérico. Media do peso dos tres peixes (p1, p2 e p3), em gramas (g).}
#'   \item{ln_peso}{Numérico. Logaritmo natural do peso medio (`log(peso_g)`).}
#'   \item{ln_comp}{Numérico. Logaritmo natural do comprimento (`log(comprimento_cm)`).}
#' }
#'
#' @details
#' A espécie `Balistes vetula`, conhecida popularmente como cangulo, cangulo-rei,
#' cangurro, peixe-porco ou piruá, pertence à família Balistidae. É encontrada
#' no Atlântico tropical e temperado, podendo atingir até 60 cm de comprimento.
#'
#' Este conjunto de dados pode ser utilizado para:
#' \enumerate{
#'   \item Ajustar um modelo de potência (W = a * L^b) para descrever a relação alométrica entre peso (W) e comprimento (L).
#'   \item Linearizar a relação peso-comprimento através da transformação logarítmica (ln(W) = ln(a) + b * ln(L)) e aplicar regressão linear simples.
#'   \item Explorar a variabilidade nas medições de peso (p1, p2, p3) em relação à medida principal (`peso_g`).
#' }
#'
#' @source Dados de medições de peso e comprimento de exemplares de cangulo,
#'   coletados para fins de estudo biométrico. (Origem específica a ser detalhada se conhecida).
#' @docType data
#' @keywords datasets biometria ictiologia regressao nao-linear modelo-potencia cangulo Balistes-vetula peso-comprimento
#' @name cangulo_crescimento
#' @usage data(cangulo_crescimento)
#'
#' @examples
#' data(cangulo_crescimento)
#' summary(cangulo_crescimento)
#'
#' # Exemplo de regressão linear nos dados transformados
#' modelo_linear <- lm(ln_peso ~ ln_comp, data = cangulo_crescimento)
#' print(summary(modelo_linear))
#'
#' # Exemplos de visualização com ggplot2 (requer o pacote ggplot2)
#' if (requireNamespace("ggplot2", quietly = TRUE)) {
#'   library(ggplot2)
#'
#'   # Visualização da relação peso-comprimento
#'   print(
#'     cangulo_crescimento |>
#'       ggplot(aes(x = comprimento_cm, y = peso_g)) +
#'       geom_point(color = "steelblue", size = 2.5) +
#'       labs(title = "Relação Peso-Comprimento do Cangulo",
#'            x = "Comprimento (cm)",
#'            y = "Peso (g)") +
#'       theme_minimal(base_size = 12)
#'   )
#'
#'   # Visualização da relação log-linearizada
#'   print(
#'     cangulo_crescimento |>
#'       ggplot(aes(x = ln_comp, y = ln_peso)) +
#'       geom_point(color = "darkorange", size = 2.5) +
#'       geom_smooth(method = "lm", se = FALSE, color = "dodgerblue") +
#'       labs(title = "Relação Log-Linearizada Peso-Comprimento",
#'            x = "ln(Comprimento)",
#'            y = "ln(Peso)") +
#'       theme_minimal(base_size = 12)
#'   )
#' }
"cangulo_crescimento" # Nome do objeto de dados como salvo no .rda
