# xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
#   PREPARACAO DO DATASET: exportacao_pargo
#   Exportacao brasileira de PARGO (Lutjanus purpureus) em formato LARGO
#   (wide), extraida do Comex Stat (MDIC) -- dados REAIS e oficiais.
#
#   Estrutura tal como o site oficial exporta ("tipo de exibicao horizontal"):
#     - 6 colunas de identificacao: Paises, Codigo NCM, Descricao NCM,
#       Codigo ISIC Grupo, Descricao ISIC Grupo, UF do Produto;
#     - 42 colunas de medida, DUAS por ano de 2005 a 2025, com o ano e a metrica
#       presos no NOME da coluna: "AAAA - Valor US$ FOB" e "AAAA - Quilograma
#       Liquido".
#
#   E o par REAL do sintetico treino_desembarque: serve para praticar a
#   arrumacao com dados de verdade -- empilhar (pivot_longer) extraindo ano e
#   metrica do nome da coluna (delimitador " - "), alargar (pivot_wider) e ainda
#   padronizar os niveis inconsistentes da "Descricao NCM" (recodificacao).
#
#   Fonte: Comex Stat -- http://comexstat.mdic.gov.br  (consulta de Exportacao,
#   NCM de pargo, 2005-2025; arquivo H_EXPORTACAO_GERAL_..._DT20260705.xlsx).
#
#   Rode a partir da raiz do pacote EAPADados:
#       source("data-raw/exportacao_pargo.R")
# xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

if (!requireNamespace("readxl", quietly = TRUE)) install.packages("readxl")

tb <- readxl::read_excel("data-raw/exportacao_pargo_comexstat.xlsx",
                         sheet = "Resultado")

# IMPORTANTE: preservar os nomes de coluna NAO sintaticos ("2025 - Valor US$ FOB").
# O as.data.frame() padrao os mangleria (check.names); reforcamos os nomes.
nomes <- names(tb)
exportacao_pargo <- as.data.frame(tb, stringsAsFactors = FALSE, check.names = FALSE)
names(exportacao_pargo) <- nomes

# Identificadores como texto; colunas de medida (ano-metrica) como numerico.
# Medida = colunas cujo nome comeca com 4 digitos + " - " (ex.: "2025 - Valor...").
cols_medida <- grep("^[0-9]{4} - ", names(exportacao_pargo), value = TRUE)

for (col in names(exportacao_pargo)) {
  if (col %in% cols_medida) {
    exportacao_pargo[[col]] <- as.numeric(exportacao_pargo[[col]])
  } else {
    exportacao_pargo[[col]] <- as.character(exportacao_pargo[[col]])
  }
}

str(exportacao_pargo)
usethis::use_data(exportacao_pargo, overwrite = TRUE)
cat("OK: data/exportacao_pargo.rda gerado (", nrow(exportacao_pargo),
    " linhas x ", ncol(exportacao_pargo), " colunas).\n", sep = "")
