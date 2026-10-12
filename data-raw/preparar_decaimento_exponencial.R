# =============================================================================
#  preparar_decaimento_exponencial.R
#  Prepara dois conjuntos reais para estudar decaimento exponencial na ClaRa:
#  secagem de vegetais e perda de sinal de DNA de presa durante a digestao.
#
#  Fontes brutas, sem alteracao, em data-raw/curados/. Os objetos finais usam
#  nomes em portugues; as ressalvas de cada fonte ficam no codigo e no roxygen.
#
#  Execute a partir da raiz de EAPADados:
#    source("data-raw/preparar_decaimento_exponencial.R")
#    devtools::document()
# =============================================================================

suppressPackageStartupMessages({
  library(dplyr)
  library(readxl)
})

# -----------------------------------------------------------------------------
# 1) Secagem de beterraba e gengibre
#
# O deposito declara dois produtos e dois pre-tratamentos, mas a planilha so
# identifica esses grupos pelos codigos B/G e C/E. Nao atribuimos significados
# aos codigos ate que o depositante publique o dicionario. A unidade de time
# tambem nao vem declarada no arquivo nem na pagina do deposito: tempo_origem
# conserva o numero como foi entregue e nao autoriza chamar a meia-vida de h
# ou min.
# -----------------------------------------------------------------------------
secagem_bruta <- readxl::read_excel(
  "data-raw/curados/beterraba_gengibre_fonte.xlsx",
  sheet = "Planilha1"
)

secagem_beterraba_gengibre <- secagem_bruta |>
  transmute(
    id_amostra = as.character(ID),
    produto_codigo = as.factor(product),
    tratamento_codigo = as.factor(treatment),
    temperatura_c = as.numeric(temp),
    repeticao = as.integer(rep),
    tempo_origem = round(as.numeric(time), 3),
    razao_umidade = as.numeric(mr)
  ) |>
  mutate(
    id_serie = interaction(produto_codigo, tratamento_codigo,
                           temperatura_c, repeticao, drop = TRUE)
  ) |>
  select(id_serie, id_amostra, produto_codigo, tratamento_codigo,
         temperatura_c, repeticao, tempo_origem, razao_umidade)

stopifnot(
  nrow(secagem_beterraba_gengibre) == 594L,
  nlevels(secagem_beterraba_gengibre$id_serie) == 36L,
  !anyNA(secagem_beterraba_gengibre$razao_umidade),
  all(secagem_beterraba_gengibre$razao_umidade > 0),
  identical(sort(unique(secagem_beterraba_gengibre$temperatura_c)), c(60, 70, 80))
)

# -----------------------------------------------------------------------------
# 2) Digestao de Chinook em black bass
#
# Recorte didatico pre-declarado: LMB, 18,5 C e tres smolts. Cada linha e um
# peixe sacrificado uma vez no tempo indicado. A resposta de metabarcoding e
# uma contagem e o qPCR pode estar ausente por nao deteccao; esses fatos sao
# preservados para que o exemplo nao finja ter erros homocedasticos.
# -----------------------------------------------------------------------------
chinook_bruto <- readxl::read_excel(
  "data-raw/curados/chinook_dryad_fonte.xlsx",
  sheet = "Controlled Feeding"
)

chinook_digestao <- chinook_bruto |>
  filter(
    `Predator Species` == "LMB",
    `Water Temperature` == 18.5,
    `Binary Feed Ration` == 3
  ) |>
  transmute(
    id_peixe = as.integer(`Fish ID`),
    classe_tempo_h = as.integer(`Hour Class`),
    tempo_ingestao_h = as.numeric(`Time Ingested`),
    leitura_metabarcoding = as.integer(`Read Count (metabarcoding)`),
    copias_qpcr = suppressWarnings(as.numeric(`Copy Number (qPCR)`))
  ) |>
  mutate(qpcr_detectado = !is.na(copias_qpcr))

stopifnot(
  nrow(chinook_digestao) == 91L,
  length(unique(chinook_digestao$id_peixe)) == 91L,
  identical(sort(unique(chinook_digestao$classe_tempo_h)),
            c(6L, 12L, 24L, 36L, 48L, 60L, 72L, 84L, 96L, 120L)),
  !anyNA(chinook_digestao$leitura_metabarcoding),
  sum(!chinook_digestao$qpcr_detectado) == 26L
)

usethis::use_data(secagem_beterraba_gengibre, chinook_digestao, overwrite = TRUE)

cat("OK: secagem_beterraba_gengibre e chinook_digestao salvos em data/.\n")
