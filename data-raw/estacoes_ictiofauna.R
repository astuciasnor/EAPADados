# xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
#   PREPARAÇÃO DO DATASET: estacoes_ictiofauna
#   Estações de coleta de ictiofauna na costa norte do Pará (região de
#   Bragança/Caeté/Salgado). Conjunto de EXEMPLO (coordenadas plausíveis,
#   valores de CPUE/abundância sintéticos), para os módulos de mapas de
#   pontos/bolhas e densidade do ecossistema EAPA.
#
#   Rode a partir da raiz do pacote EAPADados:
#       source("data-raw/estacoes_ictiofauna.R")
# xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

if (!requireNamespace("readxl", quietly = TRUE)) install.packages("readxl")

estacoes_ictiofauna <- readxl::read_excel("CURADORIA_DADOS/fontes_containers_originais/dados_brutos_eapadados.xlsx",
                                          sheet = "estacoes_ictiofauna")
estacoes_ictiofauna <- as.data.frame(estacoes_ictiofauna)

estacoes_ictiofauna$id_estacao <- as.character(estacoes_ictiofauna$id_estacao)
estacoes_ictiofauna$latitude   <- as.numeric(estacoes_ictiofauna$latitude)
estacoes_ictiofauna$longitude  <- as.numeric(estacoes_ictiofauna$longitude)
estacoes_ictiofauna$ano        <- as.integer(estacoes_ictiofauna$ano)
estacoes_ictiofauna$campanha   <- factor(estacoes_ictiofauna$campanha)
estacoes_ictiofauna$ambiente   <- factor(estacoes_ictiofauna$ambiente)
estacoes_ictiofauna$especie    <- factor(estacoes_ictiofauna$especie)
estacoes_ictiofauna$cpue       <- as.numeric(estacoes_ictiofauna$cpue)
estacoes_ictiofauna$abundancia <- as.integer(estacoes_ictiofauna$abundancia)

str(estacoes_ictiofauna)
usethis::use_data(estacoes_ictiofauna, overwrite = TRUE)
cat("OK: data/estacoes_ictiofauna.rda gerado (", nrow(estacoes_ictiofauna), " estações).\n", sep = "")
