# xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
#   PREPARAÇÃO DO DATASET: anchova_norte_california
#   Desembarques mensais da categoria de mercado anchova-do-norte,
#   Califórnia, janeiro de 1971 a dezembro de 1991. DADOS REAIS.
#
#   A fonte ERDDAP registra o mês no dia 16. Aqui `data` é o primeiro dia
#   do mês, para representar o período mensal; `desembarque_lb` não é
#   convertido nem estimado. A categoria de mercado não é uma medida direta
#   de abundância ou um estoque biológico puro.
#
#   Rode a partir da raiz do pacote EAPADados:
#       source("data-raw/anchova_norte_california.R")
# xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

arquivo <- "data-raw/anchova_norte_california_fonte.csv"
bruto <- utils::read.csv(arquivo, stringsAsFactors = FALSE, check.names = FALSE)

# A primeira linha depois do cabeçalho traz as unidades do ERDDAP; não é dado.
unidades <- bruto[1, ]
bruto <- bruto[-1, ]

stopifnot(
  identical(unidades$time, "UTC"),
  identical(unidades$landings, "pounds"),
  nrow(bruto) == 252L,
  all(bruto$fish == "Anchovy, Northern"),
  all(bruto$port == "All")
)

data_fonte <- as.Date(sub("T.*$", "", bruto$time))
data_mes <- as.Date(format(data_fonte, "%Y-%m-01"))
meses <- c(
  "janeiro", "fevereiro", "marco", "abril", "maio", "junho",
  "julho", "agosto", "setembro", "outubro", "novembro", "dezembro"
)

anchova_norte_california <- data.frame(
  data = data_mes,
  ano = as.integer(format(data_mes, "%Y")),
  mes = factor(meses[as.integer(format(data_mes, "%m"))],
               levels = meses, ordered = TRUE),
  categoria_mercado = factor("anchova-do-norte"),
  porto = factor("todos_os_portos"),
  desembarque_lb = as.numeric(bruto$landings),
  check.names = FALSE
)

datas_esperadas <- seq.Date(as.Date("1971-01-01"), as.Date("1991-12-01"), by = "month")
stopifnot(
  identical(anchova_norte_california$data, datas_esperadas),
  all(anchova_norte_california$ano == as.integer(bruto$year)),
  !anyNA(anchova_norte_california),
  all(anchova_norte_california$desembarque_lb > 0)
)

usethis::use_data(anchova_norte_california, overwrite = TRUE)
cat("OK: data/anchova_norte_california.rda gerado (",
    nrow(anchova_norte_california), " meses).\n", sep = "")
