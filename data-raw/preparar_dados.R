# xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
#
#           PROCEDIMENTOS DE PREPARAÇÃO DE DADOS
#
#xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

# Pacotes usados ------------------------------------------------
  install.packages("rio")
  install.packages("readxl")
  install.packages("janitor")
  install.packages("dplyr")

# Exportando dados com o o pacote "rio" -------------------------
  library(rio)
  rio::export(dados_brutos,
              "data-raw/dados_camarao_sexo.xlsx",
              format = "xlsx")

# Simulados tilapia_crescimento ----------------------------------
tilapia_crescimento <- data.frame(
  Tratamento = factor(rep(c("A", "B", "C"), each = 10)),
  Semana = rep(1:10, times = 3),
  PesoMedio = rnorm(30, mean = 50, sd = 10) + rep(1:10, times = 3)*5,
  DataColeta = seq(as.Date("2023-01-01"), by = "week", length.out = 30)
)
# str(tilapia_crescimento) # Verifique as classes!
usethis::use_data(tilapia_crescimento, overwrite = TRUE)

# Simulados captura_petrechos ------------------------------------
captura_petrechos <- data.frame(
  Especie = factor(sample(c("Sardinha", "Corvina", "Pescada"), 50, replace = TRUE)),
  Petrecho = factor(sample(c("Rede Emalhe", "Arrasto Fundo", "Linha Anzol"), 50, replace = TRUE)),
  CPUE = rpois(50, lambda = 5)
)
# str(captura_petrechos) # Verifique as classes!
usethis::use_data(captura_petrechos, overwrite = TRUE)

cat("Conjuntos de dados processados e salvos na pasta data/.\n")

# Biometria Caranguejos ------------------------------------------
library(readxl)
library(dplyr)
biometria_caranguejo <- read_excel("data-raw/Aulas_Gerais_Parte1.xlsx", sheet = 20)
biometria_caranguejo <- biometria_caranguejo %>%
  mutate_if(is.character, as.factor)
glimpse(biometria_caranguejo)

usethis::use_data(biometria_caranguejo, overwrite = TRUE)

# Camarao Sexo - Qui-quadrado --------------------------------------
df <- read_excel("data-raw/pesca_aquic_bioecol.xlsx", sheet = 17) |>
      select(1:2) |>
      mutate(across(everything(), as.factor))

camaroes_sexo <- df
usethis::use_data(camaroes_sexo, overwrite = TRUE)

# Proximo Conjunto Dados --------------------------------------------
