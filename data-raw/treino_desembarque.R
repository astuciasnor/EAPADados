# xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
#   PREPARAÇÃO DO DATASET: treino_desembarque
#   Desembarque pesqueiro SINTÉTICO em formato LARGO (wide): para cada ano
#   (2021–2023) há duas colunas — "AAAA - Captura_t" e "AAAA - Receita_mil".
#   Feito para TREINAR arrumação: empilhar (pivot_longer) com extração do
#   ano/métrica do nome da coluna e alargar (pivot_wider) uma métrica.
#   Dados fictícios, valores plausíveis para a pesca amazônica.
#
#   Rode a partir da raiz do pacote EAPADados:
#       source("data-raw/treino_desembarque.R")
# xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

if (!requireNamespace("readxl", quietly = TRUE)) install.packages("readxl")

tb <- readxl::read_excel("CURADORIA_DADOS/fontes_containers_originais/dados_brutos_eapadados.xlsx",
                         sheet = "treino_desembarque")

# IMPORTANTE: preservar os nomes de coluna NÃO sintáticos ("2021 - Captura_t").
# O as.data.frame() padrão os mangleria (check.names); reforçamos os nomes.
nomes <- names(tb)
treino_desembarque <- as.data.frame(tb, stringsAsFactors = FALSE, check.names = FALSE)
names(treino_desembarque) <- nomes

treino_desembarque$Porto   <- as.character(treino_desembarque$Porto)
treino_desembarque$Especie <- as.character(treino_desembarque$Especie)

str(treino_desembarque)
usethis::use_data(treino_desembarque, overwrite = TRUE)
cat("OK: data/treino_desembarque.rda gerado (", nrow(treino_desembarque),
    " linhas x ", ncol(treino_desembarque), " colunas).\n", sep = "")
