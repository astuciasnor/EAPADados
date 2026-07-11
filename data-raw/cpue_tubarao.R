# xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
#   PREPARAÇÃO DO DATASET: cpue_tubarao
#   CPUE (captura por unidade de esforço) de tubarão por ano/mês/embarcação,
#   1995–2007. DADOS REAIS (fonte/créditos a completar na documentação).
#   Serve para Kruskal-Wallis (CPUE ~ Year) e para análise de série temporal.
#
#   Rode a partir da raiz do pacote EAPADados:
#       source("data-raw/cpue_tubarao.R")
# xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

if (!requireNamespace("readxl", quietly = TRUE)) install.packages("readxl")

cpue_tubarao <- readxl::read_excel("CURADORIA_DADOS/fontes_containers_originais/dados_brutos_eapadados.xlsx",
                                   sheet = "cpue_tubarao")
cpue_tubarao <- as.data.frame(cpue_tubarao)
cpue_tubarao$Vessel <- factor(cpue_tubarao$Vessel)
cpue_tubarao$Year   <- as.integer(cpue_tubarao$Year)
cpue_tubarao$Month  <- as.integer(cpue_tubarao$Month)
cpue_tubarao$CPUE   <- as.numeric(cpue_tubarao$CPUE)
cpue_tubarao$Data   <- as.Date(cpue_tubarao$Data)

str(cpue_tubarao)
usethis::use_data(cpue_tubarao, overwrite = TRUE)
cat("OK: data/cpue_tubarao.rda gerado (", nrow(cpue_tubarao), " registros).\n", sep = "")
