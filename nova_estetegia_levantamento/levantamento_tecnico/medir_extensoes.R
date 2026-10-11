# Mede somente fontes extras às 54 fontes R do medicao_conjuntos.json.
# Não adapta nem altera os dados; resultados e cópias ficam no estágio.
Sys.setlocale("LC_CTYPE", "Portuguese_Brazil.utf8")
root <- "D:/Claude/EAPA-Ecossistema/EAPADados/nova_estetegia_levantamento/levantamento_tecnico"
extras <- file.path(root, "fontes_extraidas")
literatura <- file.path(root, "literatura")
dest <- file.path(root, "serializados_extras_xz")
dir.create(dest, recursive = TRUE, showWarnings = FALSE)
resultado <- list()

medir <- function(chave, objeto) {
  env <- new.env(parent = emptyenv())
  assign("x", objeto, envir = env)
  arquivo <- file.path(dest, paste0(gsub("[^A-Za-z0-9_-]", "_", chave), ".rda"))
  save("x", envir = env, file = arquivo, compress = "xz", version = 3)
  list(chave = chave, classe = class(objeto), linhas = NROW(objeto),
       colunas = NCOL(objeto), bytes_xz = unname(file.info(arquivo)$size))
}

# Os conjuntos do FESta vieram da versão 1.0.2 do tarball CRAN; mede todos
# porque ainda falta escolher qual estrutura de CPUE serve melhor ao objetivo.
fe_dir <- file.path(extras, "FESta", "data")
for (arquivo in list.files(fe_dir, pattern = "\\.rda$", full.names = TRUE)) {
  env <- new.env(parent = emptyenv())
  objetos <- load(arquivo, envir = env)
  for (nome in objetos) resultado[[paste0("FESta::", nome)]] <- medir(
    paste0("FESta__", nome), get(nome, envir = env, inherits = FALSE))
}
fsa_path <- file.path(extras, "FSAdata", "data", "YPerchRL.rdata")
if (file.exists(fsa_path)) {
  env <- new.env(parent = emptyenv())
  load(fsa_path, envir = env)
  for (nome in ls(env)) resultado[[paste0("FSAdata::", nome)]] <- medir(
    paste0("FSAdata__", nome), get(nome, envir = env, inherits = FALSE))
}

# CSVs do whitefish e do experimento com Artemia permanecem sem recodificação.
csvs <- c(
  file.path(literatura, "whitefish_salinidade", paste0("File_", LETTERS[1:4], ".csv")),
  file.path(literatura, "artemia_fitos_esterols", "Artemia_growth_sterols.csv")
)
for (arquivo in csvs) if (file.exists(arquivo)) {
  nome <- basename(arquivo)
  objeto <- read.csv(arquivo, check.names = FALSE, na.strings = c("", "NA"))
  resultado[[nome]] <- medir(nome, objeto)
}

# Arquivos tabulares do Dryad de mesocosmos; apenas folhas de dados, cada
# planilha é medida como um conjunto separado, sem remover colunas/linhas.
if (requireNamespace("readxl", quietly = TRUE)) {
  arquivos <- list.files(file.path(literatura, "mesocosmos_secagem"),
                         pattern = "_Dryad\\.xlsx$", full.names = TRUE)
  for (arquivo in arquivos) {
    objeto <- as.data.frame(readxl::read_excel(arquivo))
    nome <- basename(arquivo)
    resultado[[nome]] <- medir(nome, objeto)
  }
  xlsx <- readxl::readxl_example("datasets.xlsx")
  resultado[["readxl_example::datasets.xlsx"]] <- list(
    chave = "readxl_example::datasets.xlsx", classe = "arquivo Excel para exercício de importação",
    bytes_original = unname(file.info(xlsx)$size), bytes_xz = NA_integer_)
}

# Recomprime os objetos já publicados de forma uniforme, apenas para comparação.
atual <- list.files("D:/Claude/EAPA-Ecossistema/EAPADados/data",
                    pattern = "\\.rda$", full.names = TRUE)
bytes_atual_xz <- 0
for (arquivo in atual) {
  env <- new.env(parent = emptyenv())
  objetos <- load(arquivo, envir = env)
  for (nome in objetos) {
    chave <- paste0("atual__", tools::file_path_sans_ext(basename(arquivo)), "__", nome)
    env2 <- new.env(parent = emptyenv())
    assign("x", get(nome, envir = env, inherits = FALSE), envir = env2)
    gravado <- file.path(dest, paste0(gsub("[^A-Za-z0-9_-]", "_", chave), ".rda"))
    save("x", envir = env2, file = gravado, compress = "xz", version = 3)
    bytes_atual_xz <- bytes_atual_xz + file.info(gravado)$size
  }
}

jsonlite::write_json(resultado, file.path(root, "medicao_fontes_extras.json"),
                     pretty = TRUE, auto_unbox = TRUE, na = "null")
cat("fontes extras:", length(resultado), "\n")
cat("bytes serializados xz:", sum(vapply(resultado, function(x)
  if (is.null(x$bytes_xz) || is.na(x$bytes_xz)) 0 else x$bytes_xz, numeric(1))), "\n")
cat("objetos atuais em RData xz:", bytes_atual_xz, "\n")
