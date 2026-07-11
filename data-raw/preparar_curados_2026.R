# =============================================================================
#  preparar_curados_2026.R
#  Promove ao pacote os 7 conjuntos curados em jul/2026 (fontes publicas abertas).
#
#  Fonte: data-raw/curados/*.csv  (abas limpas extraidas do workbook mestre da
#  curadoria, ja em snake_case ASCII). Mantido separado de preparar_dados.R para
#  nao mexer no dados_brutos_eapadados.xlsx.
#
#  COMO USAR (a partir da raiz do pacote EAPADados):
#     source("data-raw/preparar_curados_2026.R")
#     devtools::document(); devtools::check()
# =============================================================================

garantir <- function(pkgs)
  for (p in pkgs)
    if (!requireNamespace(p, quietly = TRUE)) install.packages(p)
garantir(c("readr", "dplyr", "stringr"))

suppressPackageStartupMessages({
  library(readr); library(dplyr); library(stringr)
})

cur <- "data-raw/curados"
rd  <- function(f) readr::read_csv(file.path(cur, f), show_col_types = FALSE)

# -----------------------------------------------------------------------------
# 1) truta_riacho_crescimento  — regressao linear multipla
#    Rutledge et al. (2025), Dryad, CC0. Unidade: peixe (tanque = agrupamento).
# -----------------------------------------------------------------------------
truta_riacho_crescimento <- rd("truta_riacho_crescimento.csv") |>
  mutate(
    id_peixe    = as.character(id_peixe),
    tanque      = as.factor(tanque),
    racao_fator = as.factor(racao_fator)
  )
stopifnot(nrow(truta_riacho_crescimento) == 69,
          !anyNA(truta_riacho_crescimento$crescimento_especifico_pct_dia))
usethis::use_data(truta_riacho_crescimento, overwrite = TRUE)

# -----------------------------------------------------------------------------
# 2) tilapia_microalgas  — regressao multipla / PCA
#    Amira et al. (2021), Mendeley, CC BY 4.0. Unidade: tanque/replica.
# -----------------------------------------------------------------------------
tilapia_microalgas <- rd("tilapia_microalgas.csv") |>
  mutate(
    id_tanque         = as.character(id_tanque),
    tratamento_codigo = as.factor(tratamento_codigo),
    tipo_microalga    = as.factor(tipo_microalga)
  )
stopifnot(nrow(tilapia_microalgas) == 15,
          !anyNA(tilapia_microalgas$sgr_pct_dia))
usethis::use_data(tilapia_microalgas, overwrite = TRUE)

# -----------------------------------------------------------------------------
# 3) peixes_nutricao_portugal  — PCA / AAH / heatmap
#    Jorge et al. (2025), Mendeley, CC BY 4.0. Unidade: especie comercializada.
# -----------------------------------------------------------------------------
peixes_nutricao_portugal <- rd("peixes_nutricao_portugal.csv") |>
  mutate(
    id_base                    = as.integer(id_base),
    nome_comum                 = as.character(nome_comum),
    nome_cientifico            = as.character(nome_cientifico),
    cluster_autores            = as.factor(cluster_autores),
    perfil_nutricional_autores = as.factor(perfil_nutricional_autores)
  )
stopifnot(nrow(peixes_nutricao_portugal) == 40)
usethis::use_data(peixes_nutricao_portugal, overwrite = TRUE)

# -----------------------------------------------------------------------------
# 4) peixes_morfometria_multivariada  — PCA / AAH (base completa, 35 medidas)
#    Bano & Takacs (2022), Mendeley, CC BY 4.0. Unidade: individuo.
# -----------------------------------------------------------------------------
peixes_morfometria_multivariada <- rd("peixes_morfometria_multivariada.csv") |>
  mutate(
    especie        = as.factor(especie),
    especie_codigo = as.factor(especie_codigo),
    populacao      = as.factor(populacao),
    id_individuo   = as.character(id_individuo)
  )
stopifnot(nrow(peixes_morfometria_multivariada) == 299)
usethis::use_data(peixes_morfometria_multivariada, overwrite = TRUE)

# -----------------------------------------------------------------------------
# 5) morfometria_barbo  — AAH introdutoria (Barbus petenyi, 10 medidas corrigidas)
#    Bano & Takacs (2022), Mendeley, CC BY 4.0. Unidade: individuo.
# -----------------------------------------------------------------------------
morfometria_barbo <- rd("morfometria_barbo.csv") |>
  mutate(
    id_peixe  = as.character(id_peixe),
    populacao = as.factor(populacao),
    rio       = as.factor(rio)
  )
stopifnot(nrow(morfometria_barbo) == 100)
usethis::use_data(morfometria_barbo, overwrite = TRUE)

# -----------------------------------------------------------------------------
# 6) recifes_ostras_heatmap  — heatmap / correlacao / PCA
#    Bennett et al. (2025), Zenodo. Unidade: levantamento de zona de recife.
# -----------------------------------------------------------------------------
recifes_ostras_heatmap <- rd("recifes_ostras_heatmap.csv") |>
  mutate(
    id_recife       = as.character(id_recife),
    id_levantamento = as.character(id_levantamento),
    sitio           = as.factor(sitio),
    numero_recife   = as.integer(numero_recife),
    zona_recife     = as.factor(zona_recife),
    estacao         = as.factor(estacao),
    ano             = as.integer(ano),
    avaliador_video = as.factor(avaliador_video)
  )
stopifnot(nrow(recifes_ostras_heatmap) == 301)
usethis::use_data(recifes_ostras_heatmap, overwrite = TRUE)

# -----------------------------------------------------------------------------
# 7) bagley_lwr_central_america  — ANCOVA (relacao peso-comprimento)
#    Bagley et al. (2022), Pensoft/Mendeley, CC BY 4.0. Unidade: individuo.
#    str_squish corrige "red fin " vs "red fin" na nadadeira dorsal.
# -----------------------------------------------------------------------------
bagley_lwr_central_america <- rd("bagley_lwr_central_america.csv") |>
  mutate(
    no               = as.integer(no),
    especie          = as.factor(especie),
    pais             = as.factor(pais),
    localidade       = as.factor(localidade),
    nadadeira_dorsal = as.factor(str_squish(nadadeira_dorsal)),
    nadadeira_caudal = as.factor(str_squish(nadadeira_caudal)),
    sexo             = as.factor(sexo)
  )
stopifnot(nrow(bagley_lwr_central_america) == 306,
          !anyNA(bagley_lwr_central_america$log_peso_g),
          !anyNA(bagley_lwr_central_america$log_sl_mm))
usethis::use_data(bagley_lwr_central_america, overwrite = TRUE)

# -----------------------------------------------------------------------------
# 8) lagostas_kelp_sexo  — qui-quadrado de independencia (sexo x ambiente)
#    Jasus lalandii, Luderitz/Namibia. CSV exportado do Excel: separador ';' e
#    decimal ',' (por isso read_csv2). Le SO as colunas limpas — o restante da
#    planilha bruta tem texto inconsistente e residuo de tabela dinamica.
#    Os dois sitios (DIAZ/SWB) sao os dois ambientes de kelp (natural x cultivo);
#    o mapeamento exato de qual e qual fica para o autor confirmar na fonte.
# -----------------------------------------------------------------------------
lagostas_kelp_sexo <- readr::read_csv2(
    file.path(cur, "lagostas_kelp_sexo.csv"),
    col_select = c(id_lagosta, data_amostragem, ano, mes, mes_nome, sitio, sexo,
                   comprimento_cefalotorax_mm),
    show_col_types = FALSE
  ) |>
  mutate(
    id_lagosta                 = as.character(id_lagosta),
    data_amostragem            = as.Date(data_amostragem),
    ano                        = as.integer(ano),
    mes                        = as.integer(mes),
    mes_nome                   = factor(mes_nome,
                                   levels = c("setembro", "outubro", "dezembro",
                                              "janeiro", "marco", "abril")),
    sitio                      = as.factor(sitio),
    sexo                       = factor(sexo, levels = c("F", "M"),
                                        labels = c("femea", "macho")),
    comprimento_cefalotorax_mm = as.numeric(comprimento_cefalotorax_mm)
  ) |>
  filter(!is.na(sexo), !is.na(sitio))
stopifnot(nlevels(lagostas_kelp_sexo$sexo) == 2,
          nlevels(lagostas_kelp_sexo$sitio) == 2,
          nrow(lagostas_kelp_sexo) >= 1400)
usethis::use_data(lagostas_kelp_sexo, overwrite = TRUE)

# -----------------------------------------------------------------------------
# 9) darter_ontario  — Mann-Whitney (idade x rio). Percina copelandi, Ontario.
#    Fonte: pacote FSAdata (dataset DarterOnt, GPL-2/3), reconstruido da Fig. 2
#    de Reid (2004). 54 individuos, 3 variaveis. Objeto criado a partir do
#    pacote de origem para manter rastreabilidade.
# -----------------------------------------------------------------------------
if (!requireNamespace("FSAdata", quietly = TRUE)) install.packages("FSAdata")
darter_ontario <- FSAdata::DarterOnt |>
  transmute(
    idade_anos           = as.integer(age),
    comprimento_total_mm = as.numeric(tl),
    rio                  = factor(river, levels = c("Salmon", "Trent"))
  )
stopifnot(nrow(darter_ontario) == 54,
          identical(levels(darter_ontario$rio), c("Salmon", "Trent")))
usethis::use_data(darter_ontario, overwrite = TRUE)

# NOTA: truta_touro_manejo (BullTroutRML1) foi movido para atividade-só (banco
# externo: atividades/dados/truta_touro_manejo.xlsx). Mantido apenas 1 exemplo de
# Mann-Whitney no pacote (darter_ontario), na convencao "1 canonico por teste".

# -----------------------------------------------------------------------------
# 10) idades_savel_repetibilidade  — Wilcoxon pareado (repetibilidade de idade).
#     Alosa sapidissima (sável-americano). Fonte: FSAdata (ShadCR, GPL-2/3),
#     McBride et al. (2005). 53 peixes; idade verdadeira (marcação prévia) + 3
#     leitores x 2 leituras. NAs onde o leitor nao atribuiu idade (leitor B tem
#     varias). Nomes em ingles snake_case; o dicionario (doc) traduz.
# -----------------------------------------------------------------------------
if (!requireNamespace("FSAdata", quietly = TRUE)) install.packages("FSAdata")
idades_savel_repetibilidade <- FSAdata::ShadCR |>
  transmute(
    fish_id    = as.character(fishID),
    true_age   = as.integer(trueAge),
    reader_a_1 = as.integer(agerA1),
    reader_a_2 = as.integer(agerA2),
    reader_b_1 = as.integer(agerB1),
    reader_b_2 = as.integer(agerB2),
    reader_c_1 = as.integer(agerC1),
    reader_c_2 = as.integer(agerC2)
  )
stopifnot(nrow(idades_savel_repetibilidade) == 53,
          ncol(idades_savel_repetibilidade) == 8)
usethis::use_data(idades_savel_repetibilidade, overwrite = TRUE)

cat("\nOK: 10 conjuntos curados gravados em data/. Rode devtools::document() e depois devtools::check().\n")
