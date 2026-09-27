# xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
#   PREPARAÇÃO DO DATASET: doubs_ambiente
#   Variáveis ambientais das 30 estações do rio Doubs (Jura francês),
#   com a riqueza de espécies de peixes e a classificação em trechos
#   do curso — a mesma montagem do roteiro de PCA do ecossistema EAPA
#   (Curadoria_Literatura_R/Multivariada_02_PCA).
#
#   Os valores ambientais são os do ade4::doubs$env, SEM alteração;
#   riqueza e trecho são colunas derivadas, exatamente como no roteiro.
#
#   Rode a partir da raiz do pacote EAPADados:
#       source("data-raw/doubs_ambiente.R")
# xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

if (!requireNamespace("ade4", quietly = TRUE)) install.packages("ade4")

data(doubs, package = "ade4")

# Tabela de variáveis ambientais: 30 estações, 11 variáveis (do ade4, intactas).
ambiente <- doubs$env

# Nomes de estação fáceis de ler (E01, E02, ...), como no roteiro de PCA.
rownames(ambiente) <- sprintf("E%02d", seq_len(nrow(ambiente)))

# Riqueza de espécies de peixes por estação (contagem de espécies presentes).
riqueza <- as.integer(rowSums(doubs$fish > 0))

# Classificação em trechos do rio, com os mesmos grupos do guia de HCA/PCA.
trecho <- dplyr::case_when(
  rownames(ambiente) %in% sprintf("E%02d", 1:10)  ~ "Alto curso",
  rownames(ambiente) %in% c("E23", "E25")         ~ "Trecho impactado",
  rownames(ambiente) %in% sprintf("E%02d", 11:22) ~ "Médio curso",
  TRUE                                            ~ "Baixo curso"
)

# Ordem dos níveis: da nascente para a foz, com o trecho impactado por último.
trecho <- factor(trecho, levels = c("Alto curso", "Médio curso",
                                    "Baixo curso", "Trecho impactado"))

doubs_ambiente <- data.frame(ambiente, riqueza = riqueza, trecho = trecho)
rownames(doubs_ambiente) <- sprintf("E%02d", seq_len(nrow(doubs_ambiente)))

str(doubs_ambiente)
usethis::use_data(doubs_ambiente, overwrite = TRUE)
cat("OK: data/doubs_ambiente.rda gerado (", nrow(doubs_ambiente),
    " linhas x ", ncol(doubs_ambiente), " colunas).\n", sep = "")
