# =============================================================================
# MOLDE - documentacao de um novo dataset do EAPADados
# -----------------------------------------------------------------------------
# COMO USAR:
#   1. Copie TODO o bloco roxygen abaixo (as linhas que comecam com #').
#   2. Crie um arquivo novo em  R/data_<nome>.R
#   3. Cole o bloco la e preencha os campos entre <...>.
#   4. A ULTIMA linha do arquivo deve ser o nome do dataset entre aspas,
#      SEM @export  (e assim que se documenta um DADO, nao uma funcao).
#   5. Os nomes em \item{} TEM que bater EXATAMENTE com as colunas da .rda.
#
# Este arquivo vive em data-raw/ de proposito: assim o roxygen NAO o processa
# (evita o aviso de "objeto inexistente") e ele nao entra no pacote construido.
# E so um molde para copiar.
# =============================================================================

#' <Titulo curto e descritivo do dataset>
#'
#' @description
#' <1 a 3 frases: o que e o dado, qual o contexto (pesca / aquicultura /
#' bioecologia / tecnologia do pescado) e para qual analise ele serve
#' (ex.: teste t, ANOVA, regressao linear, qui-quadrado).>
#'
#' @format Um data frame com <N> observacoes e <k> variaveis:
#' \describe{
#'   \item{<coluna_1>}{<tipo e descricao; se for fator, liste os niveis>.}
#'   \item{<coluna_2>}{<tipo e descricao; inclua a unidade, ex.: cm, g, mg/dia>.}
#'   \item{<coluna_3>}{<...>.}
#' }
#'
#' @details
#' <Opcional: pergunta(s) de pesquisa, premissas e qual teste aplicar.>
#'
#' @source <Origem dos dados. Se forem reais, cite a fonte (livro/planilha/artigo).
#'   Se forem SIMULADOS ou RECONSTRUIDOS, diga isso explicitamente e cite a
#'   referencia. Ex.: "Reconstruido das estatisticas resumidas de LI, Q. et al.
#'   (2022). DOI: 10.3389/fevo.2022.916873.">
#' @docType data
#' @keywords datasets <area> <tipo-de-analise>
#' @name <nome_do_dataset>
#' @usage data(<nome_do_dataset>)
#'
#' @examples
#' data(<nome_do_dataset>)
#' summary(<nome_do_dataset>)
#'
#' # <Um exemplo minimo da analise-alvo, usando os nomes REAIS das colunas.>
#' # Ex. (teste t pareado):
#' # t.test(<nome_do_dataset>$<col_1>, <nome_do_dataset>$<col_2>, paired = TRUE)
"<nome_do_dataset>"   # <-- troque pelo nome real; mantenha as aspas; SEM @export
