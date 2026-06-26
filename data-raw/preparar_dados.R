# xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
#
#           PROCEDIMENTOS DE PREPARAÇÃO DE DADOS
#
#   Fonte unica dos dados brutos: data-raw/dados_brutos_eapadados.xlsx
#   (cada conjunto numa aba; ver a aba "Índice" para a descricao).
#xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
  rm(list = ls())
# Pacotes a serem usados -----------------------------------------
  # Helper enxuto: instala (se preciso) e carrega pacotes
  garantir_pacotes <- function(pacotes) {
    for (p in pacotes) {
      if (!require(p, character.only = TRUE, quietly = TRUE)) {
        install.packages(p, dependencies = TRUE)
        if (!require(p, character.only = TRUE, quietly = TRUE))
          stop("Falha ao instalar/carregar o pacote: ", p, call. = FALSE)
      }
    }
    invisible(TRUE)
  }

  pacotes_para_preparacao <- c("rio", "readxl", "janitor", "dplyr", "stringr", "lubridate", "readr")
  garantir_pacotes(pacotes_para_preparacao)

# Arquivo unico de dados brutos ----------------------------------
  brutos <- "data-raw/dados_brutos_eapadados.xlsx"

# Simulados tilapia_crescimento ----------------------------------
tilapia_crescimento <- data.frame(
  Tratamento = factor(rep(c("A", "B", "C"), each = 10)),
  Semana = rep(1:10, times = 3),
  PesoMedio = rnorm(30, mean = 50, sd = 10) + rep(1:10, times = 3)*5,
  DataColeta = seq(as.Date("2023-01-01"), by = "week", length.out = 30)
)
usethis::use_data(tilapia_crescimento, overwrite = TRUE)

# Simulados captura_petrechos ------------------------------------
captura_petrechos <- data.frame(
  Especie = factor(sample(c("Sardinha", "Corvina", "Pescada"), 50, replace = TRUE)),
  Petrecho = factor(sample(c("Rede Emalhe", "Arrasto Fundo", "Linha Anzol"), 50, replace = TRUE)),
  CPUE = rpois(50, lambda = 5)
)
usethis::use_data(captura_petrechos, overwrite = TRUE)

cat("Conjuntos de dados processados e salvos na pasta data/.\n")

# Biometria Caranguejos ------------------------------------------
biometria_caranguejos <- read_excel(brutos, sheet = "src_caranguejos")
biometria_caranguejos <- biometria_caranguejos %>%
  mutate_if(is.character, as.factor)
glimpse(biometria_caranguejos)
usethis::use_data(biometria_caranguejos, overwrite = TRUE)

# Camarao Sexo - Qui-quadrado --------------------------------------
camaroes_sexo <- read_excel(brutos, sheet = "src_camaroes_sexo") |>
  select(1:2) |>
  clean_names() |>
  mutate(across(everything(), as.factor))
usethis::use_data(camaroes_sexo, overwrite = TRUE)

# Artemia e alimentaçao --------------------------------------
artemia <- read_excel(brutos, sheet = "src_artemia") |>
  select(1:2) |>
  mutate(across(where(is.character), as.factor)) |>
  clean_names()
colnames(artemia) <- c("racao", "taxa_crescimento_mg_dia")
usethis::use_data(artemia, overwrite = TRUE)

# Cangulo - Peso e Comprimento --------------------------------------
cangulo_crescimento <- read_excel(brutos, sheet = "src_cangulo") |>
  mutate(across(where(is.character), as.factor)) |>
  clean_names()
glimpse(cangulo_crescimento)
usethis::use_data(cangulo_crescimento, overwrite = TRUE)

# Bagres e ração iso-proteica - ANOVA (Bhujel 2011, Tabela 7.4) -----------
isoproteica_bagre <- read_excel(brutos, sheet = "src_isoproteica") |>
  mutate(across(where(is.character), as.factor)) |>
  clean_names()
colnames(isoproteica_bagre) <- c("racao", "peso_g")
usethis::use_data(isoproteica_bagre, overwrite = TRUE)

# Multivariadas (PCA e AAH/HCA) -------------------------------------
# cabritos_fa_coltro - acidos graxos em carne de cabritos (Coltro et al. 2005)
cabritos_fa_coltro <- as.data.frame(read_excel(brutos, sheet = "cabritos_fa_coltro"))
cabritos_fa_coltro$tratamento <- factor(cabritos_fa_coltro$tratamento,
                                        levels = c("T1", "T2", "T3", "T4"))
usethis::use_data(cabritos_fa_coltro, overwrite = TRUE)

# brine_carbonatos - salmouras de unidades carbonaticas (Davis 2002 / KGS)
brine_carbonatos <- as.data.frame(read_excel(brutos, sheet = "brine_carbonatos"))
brine_carbonatos$grupo <- factor(brine_carbonatos$grupo)
usethis::use_data(brine_carbonatos, overwrite = TRUE)

# pinguins - palmerpenguins contextualizado em portugues (CC0) ------
# Requer: install.packages("palmerpenguins")
pinguins <- as.data.frame(palmerpenguins::penguins)
names(pinguins) <- c("especie", "ilha", "comprimento_bico_mm", "profundidade_bico_mm",
                     "comprimento_nadadeira_mm", "massa_g", "sexo", "ano")
levels(pinguins$sexo) <- c("femea", "macho")
usethis::use_data(pinguins, overwrite = TRUE)

# captura_pescada_amarela - capturas de pescada-amarela por embarcacao -------
# Conjunto BRUTO (com defeitos de digitacao de proposito) na aba
# "captura_pescada_amarela_bruta"; a versao LIMPA e o resultado do tratamento.
bruto_tmp <- suppressWarnings(read_excel(brutos, sheet = "captura_pescada_amarela_bruta"))

# A coluna "Data de Chegada" tem uma celula de texto invalida ("15/10//2020")
# misturada as datas; o readxl devolve a coluna como TEXTO (seriais do Excel).
# Convertemos os seriais para dd/mm/aaaa e REINSERIMOS o defeito original.
ch <- bruto_tmp[["Data de Chegada"]]
ch_txt <- format(as.Date(suppressWarnings(as.numeric(ch)), origin = "1899-12-30"),
                 "%d/%m/%Y")
ch_txt[is.na(ch_txt)] <- ch[is.na(ch_txt)]   # devolve "15/10//2020"
bruto_tmp[["Data de Chegada"]] <- ch_txt

captura_pescada_amarela_bruta <- as.data.frame(bruto_tmp)
usethis::use_data(captura_pescada_amarela_bruta, overwrite = TRUE)

# VERSAO LIMPA - tratamento espelhando o cap. 3 do livro
meses_ord <- c("Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho",
               "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro")

captura_pescada_amarela <- captura_pescada_amarela_bruta |>
  janitor::clean_names() |>
  dplyr::mutate(
    periodo_sazonal     = stringr::str_squish(periodo_sazonal),
    nome_aparelho_pesca = stringr::str_squish(nome_aparelho_pesca),
    data_de_chegada     = lubridate::dmy(stringr::str_replace(data_de_chegada, "//", "/")),
    data_de_saida       = as.Date(data_de_saida),
    mes_ano             = as.Date(mes_ano),
    embarcacao          = as.factor(embarcacao),
    periodo_sazonal     = as.factor(periodo_sazonal),
    nome_aparelho_pesca = as.factor(nome_aparelho_pesca),
    mes  = factor(mes, levels = meses_ord),
    ano  = as.integer(ano),
    cpue_pescada = round(cpue_pescada, 2),
    cpue         = round(cpue, 2)
  )
usethis::use_data(captura_pescada_amarela, overwrite = TRUE)


# camarao_vannamei_biometria - biometria de Litopenaeus vannamei -------------
# Fonte: Ramirez-Coronel et al. (2024), Mendeley Data v2, DOI 10.17632/h8tcn6ykky.2
# (CC BY 4.0). Tabela ja consolidada (170 linhas) na aba "camarao_vannamei_biometria".
camarao_vannamei_biometria <- as.data.frame(
  read_excel(brutos, sheet = "camarao_vannamei_biometria")
)
camarao_vannamei_biometria$amostra         <- as.integer(camarao_vannamei_biometria$amostra)
camarao_vannamei_biometria$imagem_completa <- as.integer(camarao_vannamei_biometria$imagem_completa)

stopifnot(nrow(camarao_vannamei_biometria) == 170)
stopifnot(!any(is.na(camarao_vannamei_biometria$comprimento_cm)))
stopifnot(!any(is.na(camarao_vannamei_biometria$peso_g)))

# CSV de conferencia
if (!dir.exists("inst/extdata")) dir.create("inst/extdata", recursive = TRUE)
readr::write_csv(camarao_vannamei_biometria, "inst/extdata/camarao_vannamei_biometria.csv")

usethis::use_data(camarao_vannamei_biometria, overwrite = TRUE)

# Conjuntos ja processados (.rds) - amostragem real e tabelas auxiliares -----
# Fonte: data-raw/processados/*.rds (objetos R prontos). Documentados em
# R/dados_amostragem_reais.R e R/dados_amostragem_tabelas.R.
crabs_morfometria <- readRDS("data-raw/processados/crabs_morfometria.rds")
usethis::use_data(crabs_morfometria, overwrite = TRUE)

snapper_hg <- readRDS("data-raw/processados/snapper_hg.rds")
usethis::use_data(snapper_hg, overwrite = TRUE)

walleye_erie <- readRDS("data-raw/processados/walleye_erie.rds")
usethis::use_data(walleye_erie, overwrite = TRUE)

dicionario_variaveis_amostragem <- readRDS("data-raw/processados/dicionario_variaveis_amostragem.rds")
usethis::use_data(dicionario_variaveis_amostragem, overwrite = TRUE)

referencias_dados_amostragem <- readRDS("data-raw/processados/referencias_dados_amostragem.rds")
usethis::use_data(referencias_dados_amostragem, overwrite = TRUE)
