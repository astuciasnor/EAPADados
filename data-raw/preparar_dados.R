# Exemplo: data-raw/preparar_dados.R

# --- Dados de Crescimento de Tilápias ---
# Suponha que você tenha um arquivo dados_brutos/tilapia_crescimento.csv
# tilapia_bruto <- read.csv("dados_brutos/tilapia_crescimento.csv", stringsAsFactors = FALSE)

# Para fins de exemplo, vamos criar um data.frame aqui
tilapia_crescimento <- data.frame(
  Tratamento = factor(rep(c("A", "B", "C"), each = 10)),
  Semana = rep(1:10, times = 3),
  PesoMedio = rnorm(30, mean = 50, sd = 10) + rep(1:10, times = 3)*5,
  DataColeta = seq(as.Date("2023-01-01"), by = "week", length.out = 30)
)

# Verifique as classes
# str(tilapia_crescimento)

# IMPORTANTE: Certifique-se que os tipos estão corretos
# Ex: Se 'Tratamento' fosse character, converteria para factor:
# tilapia_crescimento$Tratamento <- as.factor(tilapia_crescimento$Tratamento)
# Ex: Se 'DataColeta' fosse character, converteria para Date:
# tilapia_crescimento$DataColeta <- as.Date(tilapia_crescimento$DataColeta, format="%Y-%m-%d")

# Salve o objeto de dados processado para o pacote
# O nome do objeto (tilapia_crescimento) será o nome que os usuários usarão
usethis::use_data(tilapia_crescimento, overwrite = TRUE)

# --- Outro conjunto de dados: Captura por Aparelho de Pesca ---
captura_petrechos <- data.frame(
  Especie = factor(sample(c("Sardinha", "Corvina", "Pescada"), 50, replace = TRUE)),
  Petrecho = factor(sample(c("Rede Emalhe", "Arrasto Fundo", "Linha Anzol"), 50, replace = TRUE)),
  CPUE = rpois(50, lambda = 5) # Captura por unidade de esforço
)
# str(captura_petrechos)
# dplyr::glimpse(captura_petrechos)
usethis::use_data(captura_petrechos, overwrite = TRUE)

# Repita para todos os seus conjuntos de dados
