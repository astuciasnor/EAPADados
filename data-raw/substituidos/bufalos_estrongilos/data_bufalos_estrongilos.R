#' Búfalos-africanos: ovos de estrongilídeos antes e depois de vermifugação
#'
#' @description
#' Acompanhamento de búfalos-africanos (\emph{Syncerus caffer}) submetidos a
#' fenbendazol de liberação lenta ou mantidos como controle. Cada animal tem uma
#' linha antes da intervenção e, quando disponível, a primeira recaptura com
#' resultado válido até 180 dias depois. A resposta é a presença de ovos de
#' estrongilídeos nas fezes.
#'
#' @format Um data frame em formato longo com 418 observações e 6 variáveis:
#' \describe{
#'   \item{id_bufalo}{Texto: identificador do mesmo búfalo nas duas avaliações.}
#'   \item{id_captura}{Texto: identificador da captura ou recaptura original.}
#'   \item{tratamento}{Fator: \code{controle} ou \code{fenbendazol}.}
#'   \item{momento}{Fator: \code{antes} ou \code{depois}.}
#'   \item{presenca_ovos_estrongilos}{Inteiro: 0 = ovos ausentes; 1 = ovos presentes; \code{NA} = exame basal sem resultado.}
#'   \item{dias_apos_intervencao}{Inteiro: 0 antes da intervenção e 25 a 180 na recaptura.}
#' }
#'
#' @details
#' Há 216 animais na linha de base e 202 recapturas no recorte. Ao remover
#' resultados ausentes e transformar a base para o formato largo, restam 196
#' pares completos: 98 no controle e 98 no grupo com fenbendazol. Quatorze
#' animais com resultado basal válido não tiveram recaptura válida na janela;
#' outros seis têm resultado basal ausente. Eles ficam no conjunto para que a
#' turma veja, antes de aplicar o McNemar, quais linhas não formam um par.
#'
#' Para manter uma única intervenção por comparação didática, a cópia usa a
#' primeira recaptura com presença/ausência conhecida até 180 dias. A fonte
#' original tem outras recapturas e redoses; elas não foram somadas nem usadas
#' como se fossem pares independentes.
#'
#' \strong{Utilidade didática:} o formato longo não é um obstáculo a contornar
#' silenciosamente: ele é parte do exercício. A turma pode conferir o
#' identificador repetido, transformar \code{momento} em duas colunas
#' (\code{antes} e \code{depois}), localizar os animais sem uma das medições e
#' só então montar a tabela 2 por 2 para o McNemar. O grupo-controle permite
#' repetir o percurso e discutir por que tratar essas linhas como observações
#' independentes perderia a informação do pareamento.
#'
#' @source Ezenwa, V. O.; Jolles, A. E. (2015). \emph{Opposite effects of
#'   anthelmintic treatment on microbial infection at individual versus
#'   population scales}. Science. DOI: \doi{10.1126/science.1261714}.
#'   Dados: Zenodo, DOI: \doi{10.5061/dryad.q2m38}, licença CC0. Recorte e
#'   tradução didáticos do EAPADados; os CSVs brutos estão em
#'   \code{data-raw/bufalos_estrongilos/fonte/}.
#'
#' @docType data
#' @encoding UTF-8
#' @keywords datasets mcnemar dados_pareados parasitologia saude_animal
#' @name bufalos_estrongilos
#' @usage data(bufalos_estrongilos)
#'
#' @examples
#' data(bufalos_estrongilos)
#'
#' # Passar do formato longo ao largo e manter só os pares completos.
#' largo <- reshape(
#'   bufalos_estrongilos[, c("id_bufalo", "tratamento", "momento",
#'                            "presenca_ovos_estrongilos")],
#'   idvar = c("id_bufalo", "tratamento"), timevar = "momento",
#'   direction = "wide"
#' )
#' pares <- largo[stats::complete.cases(largo), ]
#'
#' # McNemar no grupo tratado: quais animais mudaram de resultado?
#' pares_tratados <- subset(pares, tratamento == "fenbendazol")
#' tabela <- with(
#'   pares_tratados,
#'   table(presenca_ovos_estrongilos.antes, presenca_ovos_estrongilos.depois)
#' )
#' stats::mcnemar.test(tabela)
"bufalos_estrongilos"
