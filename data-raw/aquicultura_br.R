# xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
#
#   PREPARAÇÃO DO DATASET: aquicultura_br
#   Produção da aquicultura brasileira por estado e ano (toneladas).
#   Fonte: Revista PEIXE BR / Peixe-BR (https://www.peixebr.com.br/).
#   Origem dos números: tabela_geral_estados.xlsx (aba "condensada").
#
#   Rode este script UMA vez a partir da raiz do pacote EAPADados para
#   (re)gerar data/aquicultura_br.rda:
#       source("data-raw/aquicultura_br.R")
# xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

if (!requireNamespace("readxl", quietly = TRUE)) install.packages("readxl")

# 1) Ler da planilha-mãe (aba "aquicultura_br") -----------------------
#    Fonte única dos dados brutos do pacote, igual aos demais conjuntos.
aquicultura_br <- readxl::read_excel("data-raw/dados_brutos_eapadados.xlsx",
                                     sheet = "aquicultura_br")
aquicultura_br <- as.data.frame(aquicultura_br)

# 2) Tipar as colunas -------------------------------------------------
aquicultura_br$uf         <- as.character(aquicultura_br$uf)          # sigla (PR, SP, ...)
aquicultura_br$estado     <- as.character(aquicultura_br$estado)      # nome por extenso
aquicultura_br$posicao    <- as.integer(aquicultura_br$posicao)       # ranking nacional
aquicultura_br$producao_t <- as.numeric(aquicultura_br$producao_t)    # produção (t)
aquicultura_br$ano        <- as.integer(aquicultura_br$ano)           # ano de referência

# 3) Ordenar (ano desc, ranking asc) ----------------------------------
aquicultura_br <- aquicultura_br[order(-aquicultura_br$ano, aquicultura_br$posicao), ]
rownames(aquicultura_br) <- NULL

# 4) Conferências rápidas ---------------------------------------------
stopifnot(
  ncol(aquicultura_br) == 5,
  all(c("uf", "estado", "posicao", "producao_t", "ano") %in% names(aquicultura_br)),
  length(unique(aquicultura_br$uf)) == 27
)
str(aquicultura_br)

# 5) Salvar em data/aquicultura_br.rda --------------------------------
usethis::use_data(aquicultura_br, overwrite = TRUE)

cat("OK: data/aquicultura_br.rda gerado (", nrow(aquicultura_br),
    " linhas; anos ", paste(range(aquicultura_br$ano), collapse = "-"), ").\n", sep = "")
