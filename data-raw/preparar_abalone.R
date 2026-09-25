# =============================================================================
#  preparar_abalone.R
#  Promove ao pacote o conjunto de abalones (Haliotis) da Tasmânia, após as
#  pequenas arrumações documentadas: restauração de unidades, exclusão de
#  imaturos, remoção de alturas impossíveis e recorte nos adultos (>= 8 anéis).
#
#  Fonte pública: UCI Machine Learning Repository (Nash et al., 1994).
#  O bruto original, intocado, fica preservado em data-raw/curados/.
#
#  COMO USAR (a partir da raiz do pacote EAPADados):
#     source("data-raw/preparar_abalone.R")
#     devtools::document()
# =============================================================================

garantir <- function(pkgs)
  for (p in pkgs)
    if (!requireNamespace(p, quietly = TRUE)) install.packages(p)
garantir(c("readr", "dplyr"))

suppressPackageStartupMessages({
  library(readr); library(dplyr)
})

# -----------------------------------------------------------------------------
# Leitura do bruto
# -----------------------------------------------------------------------------
abalone_bruto <- read_csv("data-raw/curados/abalone_bruto_uci.csv",
                          show_col_types = FALSE)

# -----------------------------------------------------------------------------
# Arrumação 1 — nomes em português e unidades restauradas
# O arquivo distribuído pelo UCI traz as medidas divididas por 200 (concha em
# "unidades de 200 mm" e pesos em "unidades de 200 g"). Multiplicar por 200
# devolve mm e g: a calibração bate com o tamanho máximo da espécie (~163 mm)
# e com o tamanho mínimo legal de captura na Tasmânia (132 mm).
# -----------------------------------------------------------------------------
abalone <- abalone_bruto |>
  rename(
    sexo            = Sex,
    comprimento_mm  = Length,
    diametro_mm     = Diameter,
    altura_mm       = Height,
    peso_total_g    = `Whole weight`,
    peso_carne_g    = `Shucked weight`,
    peso_visceras_g = `Viscera weight`,
    peso_concha_g   = `Shell weight`,
    aneis           = Rings
  ) |>
  mutate(across(
    c(comprimento_mm, diametro_mm, altura_mm,
      peso_total_g, peso_carne_g, peso_visceras_g, peso_concha_g),
    ~ .x * 200
  ))

n_bruto <- nrow(abalone)

# -----------------------------------------------------------------------------
# Arrumação 2 — exclusão dos imaturos
# O sexo "I" (infant/juvenile) reúne animais que ainda não dava para sexar.
# Misturá-los aos adultos juntaria duas populações de tamanhos muito
# diferentes e distorceria qualquer distribuição.
# -----------------------------------------------------------------------------
abalone <- abalone |> filter(sexo != "I")
n_imaturos <- n_bruto - nrow(abalone)

# -----------------------------------------------------------------------------
# Arrumação 3 — remoção das alturas impossíveis
# A altura típica é ~1/3 do diâmetro (mediana da razão ≈ 0,34; percentil 99
# ≈ 0,46). Regra única e documentada: altura <= 0 ou razão altura/diâmetro
# > 0,55 é registro com erro de digitação/mensura e sai da base.
# -----------------------------------------------------------------------------
razao_altura   <- abalone$altura_mm / abalone$diametro_mm
altura_invalid <- abalone$altura_mm <= 0 | razao_altura > 0.55
n_alturas      <- sum(altura_invalid)
abalone        <- abalone[!altura_invalid, ]

# -----------------------------------------------------------------------------
# Arrumação 4 — recorte nos adultos (>= 8 anéis)
# Idade ≈ anéis + 1,5; com 8 anéis o animal já está na fase adulta. Sem teto:
# a sensibilidade do corte 8–15 fica para as análises, não para o pacote.
# -----------------------------------------------------------------------------
abalone <- abalone |> filter(aneis >= 8)
n_adultos <- nrow(abalone)

# -----------------------------------------------------------------------------
# Base final: sexo como fator com níveis explícitos (Fêmea antes de Macho,
# para tabelas e gráficos saírem sempre na mesma ordem)
# -----------------------------------------------------------------------------
abalone_adultos <- abalone |>
  mutate(
    sexo  = factor(sexo, levels = c("F", "M"), labels = c("Femea", "Macho")),
    aneis = as.integer(aneis)
  ) |>
  select(sexo, comprimento_mm, diametro_mm, altura_mm,
         peso_total_g, peso_carne_g, peso_visceras_g, peso_concha_g, aneis)

# -----------------------------------------------------------------------------
# Conferências: o script só salva se os números baterem com o esperado
# -----------------------------------------------------------------------------
cat("Registros no bruto:               ", n_bruto, "\n")
cat("Imaturos (sexo I) excluídos:      ", n_imaturos, "\n")
cat("Alturas impossíveis removidas:    ", n_alturas, "\n")
cat("Adultos (>= 8 anéis) na base:     ", n_adultos, "\n")
cat("Por sexo:\n"); print(table(abalone_adultos$sexo))

stopifnot(
  n_bruto == 4177,
  n_adultos > 2400,
  !anyNA(abalone_adultos),
  all(levels(abalone_adultos$sexo) %in% c("Femea", "Macho")),
  min(abalone_adultos$aneis) >= 8
)

usethis::use_data(abalone_adultos, overwrite = TRUE)

cat("Conjunto abalone_adultos salvo em data/. Falta documentar em",
    "R/data_abalone_adultos.R e rodar devtools::document().\n")
