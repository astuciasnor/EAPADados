# xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
#
#           PROCEDIMENTOS DE PREPARAÇÃO DE DADOS
#
#xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
  rm(list = ls())
# Pacotes a serem usados -----------------------------------------
  source("data-raw/instala_carrega-pak.R")

  # Lista de pacotes necessários para o script de preparação
  pacotes_para_preparacao <- c("rio", "readxl", "janitor", "dplyr")
  garantir_pacotes(pacotes_para_preparacao) # Garantir que os pacotes estão disponíveis

# Exportando dados com o o pacote "rio" -------------------------

      # rio::export(dados_brutos,
      #             "data-raw/dados_camarao_sexo.xlsx",
      #             format = "xlsx")

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
biometria_caranguejos <- read_excel("data-raw/pesca_aquic_bioecol.xlsx", sheet = 10)
biometria_caranguejos <- biometria_caranguejos %>%
  mutate_if(is.character, as.factor)

glimpse(biometria_caranguejos)

usethis::use_data(biometria_caranguejos, overwrite = TRUE)

# Camarao Sexo - Qui-quadrado --------------------------------------
camaroes_sexo <- read_excel("data-raw/pesca_aquic_bioecol.xlsx", sheet = 17) |>
  select(1:2) |>
  clean_names() |>
  mutate(across(everything(), as.factor))


usethis::use_data(camaroes_sexo, overwrite = TRUE)

# Artemia e alimentaçao --------------------------------------

artemia <- read_excel("data-raw/pesca_aquic_bioecol.xlsx", sheet = 18) |>
  select(1:2) |>
  mutate(across(where(is.character), as.factor)) |>
  clean_names()

  # Verifique os tipos de dados:
  artemia |> glimpse()

  # Mude os nomes de variaveis se necessario
  colnames(artemia) <- c("racao", "taxa_crescimento_mg_dia")

  # Adicione ao pacote (este comando é crucial)
  usethis::use_data(artemia, overwrite = TRUE)


# Cangulo - Peso e Comprimento --------------------------------------

  cangulo_crescimento <- read_excel("data-raw/pesca_aquic_bioecol.xlsx", sheet = 15) |>
    # select(1:2) |>
    mutate(across(where(is.character), as.factor)) |>
    clean_names()

  # Verifique os tipos de dados:
  cangulo_crescimento |> glimpse()

  # Mude os nomes de variaveis se necessario
  # colnames(artemia) <- c("racao", "taxa_crescimento_mg_dia")

  # Adicione ao pacote (este comando é crucial)
  usethis::use_data(cangulo_crescimento, overwrite = TRUE)


# Bagres e ração isoproteica - ANOVA --------------------------------------

  isoproteica <- read_excel("data-raw/pesca_aquic_bioecol.xlsx", sheet = 19) |>
    mutate(across(where(is.character), as.factor)) |>
    clean_names()

  # Verifique os tipos de dados:
  isoproteica |> glimpse()

  # Mude os nomes de variaveis se necessario
  colnames(isoproteica) <- c("racao", "peso_g")

  # Adicione ao pacote (este comando é crucial)
  usethis::use_data(isoproteica, overwrite = TRUE)


# Proximo Conjunto Dados --------------------------------------------







