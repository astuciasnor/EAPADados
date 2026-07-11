# xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
#   PREPARAÇÃO DO DATASET: ocorrencias_peixes
#   Muitos pontos de ocorrência de peixes na costa norte do Pará, para o
#   módulo de mapa de DENSIDADE/heatmap. Conjunto de EXEMPLO (coordenadas
#   sintéticas em dois agrupamentos: estuário e plataforma).
#
#   Rode a partir da raiz do pacote EAPADados:
#       source("data-raw/ocorrencias_peixes.R")
# xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

if (!requireNamespace("readxl", quietly = TRUE)) install.packages("readxl")

ocorrencias_peixes <- readxl::read_excel("CURADORIA_DADOS/fontes_containers_originais/dados_brutos_eapadados.xlsx",
                                         sheet = "ocorrencias_peixes")
ocorrencias_peixes <- as.data.frame(ocorrencias_peixes)
ocorrencias_peixes$id        <- as.integer(ocorrencias_peixes$id)
ocorrencias_peixes$longitude <- as.numeric(ocorrencias_peixes$longitude)
ocorrencias_peixes$latitude  <- as.numeric(ocorrencias_peixes$latitude)
ocorrencias_peixes$especie   <- factor(ocorrencias_peixes$especie)
ocorrencias_peixes$ano       <- as.integer(ocorrencias_peixes$ano)

str(ocorrencias_peixes)
usethis::use_data(ocorrencias_peixes, overwrite = TRUE)
cat("OK: data/ocorrencias_peixes.rda gerado (", nrow(ocorrencias_peixes), " ocorrências).\n", sep = "")
