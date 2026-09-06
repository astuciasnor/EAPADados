# xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
#   PREPARAÇÃO DO DATASET: sst_costa_norte
#   Grade ambiental (EXEMPLO) da costa norte do Brasil (litoral do Pará):
#   temperatura da superfície do mar (TSM/SST), clorofila-a e profundidade,
#   numa grade regular de longitude/latitude. Valores SINTÉTICOS, para os
#   módulos de mapa raster/contorno ambiental do ecossistema EAPA.
#
#   Rode a partir da raiz do pacote EAPADados:
#       source("data-raw/sst_costa_norte.R")
# xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

if (!requireNamespace("readxl", quietly = TRUE)) install.packages("readxl")

sst_costa_norte <- readxl::read_excel("../APOIO/CURADORIA_DADOS/fontes_containers_originais/dados_brutos_eapadados.xlsx",
                                      sheet = "sst_costa_norte")
sst_costa_norte <- as.data.frame(sst_costa_norte)
sst_costa_norte$lon          <- as.numeric(sst_costa_norte$lon)
sst_costa_norte$lat          <- as.numeric(sst_costa_norte$lat)
sst_costa_norte$sst          <- as.numeric(sst_costa_norte$sst)
sst_costa_norte$clorofila    <- as.numeric(sst_costa_norte$clorofila)
sst_costa_norte$profundidade <- as.numeric(sst_costa_norte$profundidade)

str(sst_costa_norte)
usethis::use_data(sst_costa_norte, overwrite = TRUE)
cat("OK: data/sst_costa_norte.rda gerado (", nrow(sst_costa_norte), " células).\n", sep = "")
