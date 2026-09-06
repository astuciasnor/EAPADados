# xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
#   PREPARAÇÃO DO DATASET: treino_coletas
#   Registros de coleta SINTÉTICOS com metadados ESPREMIDOS numa coluna:
#   'codigo_coleta' no formato ESPECIE-ANO-PORTO (ex.: "PARGO-2023-BRA") e
#   'estacao_periodo' no formato Exx_Periodo (ex.: "E03_Seca").
#   Feito para TREINAR a SEPARAÇÃO de uma coluna em várias (tidyr::extract),
#   praticando regex com 2 e com 3 grupos de captura.
#   Dados fictícios, valores plausíveis para a pesca amazônica.
#
#   Rode a partir da raiz do pacote EAPADados:
#       source("data-raw/treino_coletas.R")
# xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

if (!requireNamespace("readxl", quietly = TRUE)) install.packages("readxl")

treino_coletas <- readxl::read_excel("../APOIO/CURADORIA_DADOS/fontes_containers_originais/dados_brutos_eapadados.xlsx",
                                     sheet = "treino_coletas")
treino_coletas <- as.data.frame(treino_coletas, stringsAsFactors = FALSE)

treino_coletas$id              <- as.integer(treino_coletas$id)
treino_coletas$codigo_coleta   <- as.character(treino_coletas$codigo_coleta)
treino_coletas$estacao_periodo <- as.character(treino_coletas$estacao_periodo)
treino_coletas$comprimento_cm  <- as.numeric(treino_coletas$comprimento_cm)
treino_coletas$peso_g          <- as.numeric(treino_coletas$peso_g)

str(treino_coletas)
usethis::use_data(treino_coletas, overwrite = TRUE)
cat("OK: data/treino_coletas.rda gerado (", nrow(treino_coletas),
    " linhas x ", ncol(treino_coletas), " colunas).\n", sep = "")
