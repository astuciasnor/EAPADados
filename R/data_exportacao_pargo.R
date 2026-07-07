#' Exportação Brasileira de Pargo em Formato Largo (dados reais do Comex Stat)
#'
#' @encoding UTF-8
#' @description
#' Conjunto **real** de exportação de **pargo** (*Lutjanus purpureus*), extraído
#' do **Comex Stat** (MDIC), o portal oficial de estatísticas de comércio exterior
#' do Brasil. Vem exatamente no **formato largo** (*wide*) em que o site entrega a
#' consulta "horizontal": além das colunas de identificação (país, NCM, ISIC, UF),
#' há **duas colunas de medida por ano**, de 2005 a 2025, com o **ano e a métrica
#' presos no nome da coluna** — `"AAAA - Valor US$ FOB"` e
#' `"AAAA - Quilograma Líquido"`. É o defeito clássico que se resolve **arrumando**
#' os dados.
#'
#' É o par **real** do sintético [treino_desembarque]: serve para praticar, com
#' dados de verdade, a etapa de preparo do ecossistema EAPA e o menu
#' **Arrumar** da IDE CatalyseR. Dá para (1) **empilhar** (`pivot_longer`)
#' extraindo ano e métrica do nome pelo delimitador `" - "`, (2) **alargar**
#' (`pivot_wider`) as métricas em `valor_usd` e `massa_kg`, e ainda (3)
#' **padronizar os níveis** inconsistentes de `Descrição NCM` — que rotula os
#' mesmos dois produtos de formas diferentes ("Pargo (Lutjanus purpureus),
#' congelado" e "Pargos congelados" para o inteiro; "Filé de pargo (Lutjanus
#' purpureus)" e "Filé/pargo (Lutjanus purpureus) congelados" para o filé) —
#' um caso natural de **recodificação de fator**.
#'
#' @format Um data frame com 4 observações e 48 variáveis:
#' \describe{
#'   \item{Países}{País de destino da exportação (character).}
#'   \item{Código NCM}{Código NCM do produto (character).}
#'   \item{Descrição NCM}{Descrição do produto na NCM; com rótulos
#'     inconsistentes, propositalmente preservados (character).}
#'   \item{Código ISIC Grupo}{Código do grupo ISIC (character).}
#'   \item{Descrição ISIC Grupo}{Descrição do grupo ISIC (character).}
#'   \item{UF do Produto}{Unidade da Federação de origem do produto (character).}
#'   \item{AAAA - Valor US$ FOB}{Valor exportado no ano AAAA, em US$ FOB
#'     (numeric). Uma coluna por ano, de 2005 a 2025.}
#'   \item{AAAA - Quilograma Líquido}{Massa exportada no ano AAAA, em quilogramas
#'     líquidos (numeric). Uma coluna por ano, de 2005 a 2025.}
#' }
#'
#' @source Comex Stat, Ministério do Desenvolvimento, Indústria, Comércio e
#'   Serviços (MDIC). \url{http://comexstat.mdic.gov.br}. Consulta de Exportação,
#'   NCM de pargo, anos de 2005 a 2025.
#' @docType data
#' @keywords datasets
#' @name exportacao_pargo
#' @usage data(exportacao_pargo)
#'
#' @examples
#' data(exportacao_pargo)
#' str(exportacao_pargo)
#'
#' # Arrumar (largo -> longo): empilhar as colunas de ano-metrica, separando o
#' # ano e a metrica pelo delimitador " - " (requer tidyr).
#' if (requireNamespace("tidyr", quietly = TRUE)) {
#'   longo <- tidyr::pivot_longer(
#'     exportacao_pargo,
#'     cols = tidyr::matches("^[0-9]{4} - "),
#'     names_to = c("ano", "metrica"),
#'     names_sep = " - ",
#'     values_to = "valor"
#'   )
#'   # Alargar cada metrica em sua propria coluna.
#'   tidyr::pivot_wider(longo, names_from = "metrica", values_from = "valor")
#' }
#'
NULL
