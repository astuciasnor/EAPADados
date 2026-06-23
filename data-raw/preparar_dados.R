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


# Bagres e ração iso-proteica - ANOVA (Bhujel 2011, Tabela 7.4) -----------
# Renomeado de `isoproteica` para `isoproteica_bagre` (jun/2026).

  isoproteica_bagre <- read_excel("data-raw/pesca_aquic_bioecol.xlsx", sheet = 19) |>
    mutate(across(where(is.character), as.factor)) |>
    clean_names()

  # Verifique os tipos de dados:
  isoproteica_bagre |> glimpse()

  # Mude os nomes de variaveis se necessario
  colnames(isoproteica_bagre) <- c("racao", "peso_g")

  # Adicione ao pacote (este comando é crucial)
  usethis::use_data(isoproteica_bagre, overwrite = TRUE)


# Multivariadas (PCA e AAH/HCA) -------------------------------------

# cabritos_fa_coltro - acidos graxos em carne de cabritos (Coltro et al. 2005)
cabritos_fa_coltro <- read.csv("data-raw/cabritos_fa_coltro.csv",
                               stringsAsFactors = FALSE)
cabritos_fa_coltro$tratamento <- factor(cabritos_fa_coltro$tratamento,
                                        levels = c("T1", "T2", "T3", "T4"))
# glimpse(cabritos_fa_coltro)  # confira os tipos
usethis::use_data(cabritos_fa_coltro, overwrite = TRUE)

# brine_carbonatos - salmouras de unidades carbonaticas (Davis 2002 / KGS)
brine_carbonatos <- read.csv("data-raw/brine_carbonatos.csv",
                             stringsAsFactors = FALSE)
brine_carbonatos$grupo <- factor(brine_carbonatos$grupo)
# glimpse(brine_carbonatos)  # confira os tipos
usethis::use_data(brine_carbonatos, overwrite = TRUE)

# pinguins - palmerpenguins contextualizado em portugues (CC0) ------
# Requer o pacote palmerpenguins instalado:
#   install.packages("palmerpenguins")
pinguins <- as.data.frame(palmerpenguins::penguins)
names(pinguins) <- c("especie", "ilha", "comprimento_bico_mm", "profundidade_bico_mm",
                     "comprimento_nadadeira_mm", "massa_g", "sexo", "ano")
levels(pinguins$sexo) <- c("femea", "macho")   # original: female, male
# glimpse(pinguins)  # confira os tipos (especie/ilha/sexo = fatores; medidas = numericas)
usethis::use_data(pinguins, overwrite = TRUE)


# Proximo Conjunto Dados --------------------------------------------








# captura_pescada_amarela - capturas de pescada-amarela por embarcacao -------
# Dados reais (nao publicados) do grupo de pesquisa. Servem de exemplo de
# TRATAMENTO de dados no livro (cap. 3): o conjunto BRUTO traz defeitos de
# digitacao de proposito; o conjunto LIMPO e o resultado do tratamento, usado
# nas analises das Unidades IV e V (CPUE por periodo, aparelho, embarcacao).
#
# Requer: readxl, janitor, dplyr, stringr, lubridate
arq_pescada <- "data-raw/dados-captura-pescada-amarela-lucas-prontos.xlsx"

# (a) VERSAO BRUTA - lida como veio, com TODOS os erros preservados ----------
#     (nomes com acento/espaco, "chuvoso " com espaco, data "15/10//2020",
#      mes como texto, CPUE com casas decimais demais)
bruto_tmp <- suppressWarnings(readxl::read_excel(arq_pescada, sheet = 1))

# A coluna "Data de Chegada" tem uma celula de texto invalida ("15/10//2020")
# misturada as datas; por isso o readxl devolve a coluna INTEIRA como TEXTO,
# com as datas boas no formato de numero de serie do Excel ("43831"...).
# Convertemos os seriais para dd/mm/aaaa e REINSERIMOS o defeito original,
# para o conjunto bruto servir de exemplo de data malformada.
ch <- bruto_tmp[["Data de Chegada"]]
ch_txt <- format(as.Date(suppressWarnings(as.numeric(ch)), origin = "1899-12-30"),
                 "%d/%m/%Y")
ch_txt[is.na(ch_txt)] <- ch[is.na(ch_txt)]   # devolve "15/10//2020"
bruto_tmp[["Data de Chegada"]] <- ch_txt

captura_pescada_amarela_bruta <- as.data.frame(bruto_tmp)
# glimpse(captura_pescada_amarela_bruta)  # confira os defeitos
usethis::use_data(captura_pescada_amarela_bruta, overwrite = TRUE)

# (b) VERSAO LIMPA - tratamento espelhando o cap. 3 do livro -----------------
meses_ord <- c("Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho",
               "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro")

captura_pescada_amarela <- captura_pescada_amarela_bruta |>
  janitor::clean_names() |>                                  # nomes padronizados
  dplyr::mutate(
    periodo_sazonal     = stringr::str_squish(periodo_sazonal),   # apara "chuvoso "
    nome_aparelho_pesca = stringr::str_squish(nome_aparelho_pesca),
    data_de_chegada     = lubridate::dmy(stringr::str_replace(data_de_chegada, "//", "/")), # corrige e converte
    data_de_saida       = as.Date(data_de_saida),   # ja vem como data do Excel
    mes_ano             = as.Date(mes_ano),
    embarcacao          = as.factor(embarcacao),
    periodo_sazonal     = as.factor(periodo_sazonal),
    nome_aparelho_pesca = as.factor(nome_aparelho_pesca),
    mes  = factor(mes, levels = meses_ord),                  # ordem de calendario
    ano  = as.integer(ano),
    cpue_pescada = round(cpue_pescada, 2),
    cpue         = round(cpue, 2)
  )
# glimpse(captura_pescada_amarela)  # confira os tipos
usethis::use_data(captura_pescada_amarela, overwrite = TRUE)
