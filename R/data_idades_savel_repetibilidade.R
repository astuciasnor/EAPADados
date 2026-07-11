#' Repetibilidade da determinação da idade do sável-americano
#'
#' @description
#' Estimativas de idade de 53 exemplares de sável-americano
#' (\emph{Alosa sapidissima}) por leitura de escamas, feitas por três leitores
#' (A, B e C), cada um em dois momentos. Como os peixes foram marcados antes de
#' soltos, a \strong{idade verdadeira} é conhecida. Base pequena e rica para o
#' \strong{teste de Wilcoxon pareado} (repetibilidade), além de viés, precisão e
#' comparação com a idade real.
#'
#' @format Um data frame com 53 observações e 8 variáveis (nomes em inglês
#' \code{snake_case}; traduções abaixo):
#' \describe{
#'   \item{fish_id}{Texto: identificação do peixe.}
#'   \item{true_age}{Inteiro: idade verdadeira (anos), conhecida por marcação prévia.}
#'   \item{reader_a_1}{Inteiro: idade estimada pelo leitor A na 1ª leitura.}
#'   \item{reader_a_2}{Inteiro: idade estimada pelo leitor A na 2ª leitura.}
#'   \item{reader_b_1}{Inteiro: idade estimada pelo leitor B na 1ª leitura (com ausências).}
#'   \item{reader_b_2}{Inteiro: idade estimada pelo leitor B na 2ª leitura (com ausências).}
#'   \item{reader_c_1}{Inteiro: idade estimada pelo leitor C na 1ª leitura.}
#'   \item{reader_c_2}{Inteiro: idade estimada pelo leitor C na 2ª leitura.}
#' }
#'
#' @details
#' Pergunta didática: as estimativas do leitor A diferem sistematicamente entre a
#' 1ª e a 2ª leitura? Compare \code{reader_a_1} e \code{reader_a_2} com o
#' \strong{Wilcoxon de postos sinalizados} (pareado), com as diferenças
#' \eqn{d_i = \text{2ª leitura}_i - \text{1ª leitura}_i}. H0: a distribuição das
#' diferenças está centrada em zero (sem diferença sistemática).
#'
#' Cuidados: ausência de diferença significativa \strong{não} prova concordância
#' perfeita — acompanhe com \% de concordância exata, distribuição das diferenças,
#' tabela cruzada e comparação com \code{true_age}. Como a idade é discreta, há
#' muitos empates e diferenças zero: use a aproximação para empates
#' (\code{exact = FALSE}). O pressuposto-chave é a simetria das diferenças; se for
#' muito violado, o teste dos sinais é alternativa (menor poder). Valores ausentes:
#' em cada comparação, mantenha apenas os peixes com as duas leituras
#' correspondentes; não descarte um peixe de tudo só por faltar a leitura de outro
#' avaliador.
#'
#' @source McBride, R. S.; Hendricks, M. L.; Olney, J. E. (2005). \emph{Testing
#'   the validity of Cating's (1953) method for age determination of American Shad
#'   using scales}. Fisheries 30:10-18. Três dos 13 leitores do estudo original.
#'   Obtido do pacote \pkg{FSAdata} (dataset \code{ShadCR}), licença GPL-2 | GPL-3.
#' @docType data
#' @encoding UTF-8
#' @keywords datasets pesca naoparametrico
#' @name idades_savel_repetibilidade
#' @usage data(idades_savel_repetibilidade)
#'
#' @examples
#' data(idades_savel_repetibilidade)
#' # Wilcoxon pareado: leitor A, 1a vs 2a leitura (com empates)
#' with(idades_savel_repetibilidade,
#'      wilcox.test(reader_a_1, reader_a_2, paired = TRUE, exact = FALSE))
#'
#' # Concordancia exata entre as duas leituras do leitor A
#' with(idades_savel_repetibilidade, mean(reader_a_1 == reader_a_2, na.rm = TRUE))
"idades_savel_repetibilidade"
