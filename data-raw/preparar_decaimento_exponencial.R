# =============================================================================
#  preparar_decaimento_exponencial.R
#  Prepara um conjunto real para estudar decaimento exponencial na ClaRa:
#  perda de sinal de DNA de presa durante a digestao.
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

# A secagem de beterraba e gengibre, que ficava aqui, saiu do pacote em
# 13/10/2026 (vegetais, fora do contexto de pesca); fonte, documentacao e
# .rda estao em data-raw/substituidos/secagem_beterraba_gengibre/. A curva
# de secagem de pescado passou a ser o D52 da ClaRa (secagem_bagre).

# -----------------------------------------------------------------------------
# Digestao de Chinook em black bass
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

usethis::use_data(chinook_digestao, overwrite = TRUE)

cat("OK: chinook_digestao salvo em data/.\n")
