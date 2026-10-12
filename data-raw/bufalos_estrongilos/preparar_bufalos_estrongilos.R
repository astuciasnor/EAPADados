# =============================================================================
# Búfalos-africanos: presença de ovos de estrongilídeos antes/depois de tratamento
#
# Fonte bruta (CC0): Ezenwa & Jolles (2015), Zenodo 10.5061/dryad.q2m38.
# Os dois CSVs em fonte/ são cópias sem alteração dos arquivos do repositório.
# Este script escolhe, para cada animal, a primeira recaptura válida até 180
# dias. O limite evita misturar a primeira aplicação às redoses posteriores.
# =============================================================================

if (!requireNamespace("usethis", quietly = TRUE)) {
  stop("Instale o pacote 'usethis' para gerar o arquivo de dados.", call. = FALSE)
}

pasta <- "data-raw/bufalos_estrongilos"
fonte <- file.path(pasta, "fonte")

antes <- utils::read.csv(
  file.path(fonte, "pre-treatment_worms.csv"),
  na.strings = c("", "NA"), stringsAsFactors = FALSE
)
depois_todas <- utils::read.csv(
  file.path(fonte, "worms.csv"),
  na.strings = c("", "NA"), stringsAsFactors = FALSE
)

# Só a primeira recaptura com resultado binário na janela didática.
depois_validas <- depois_todas[
  !is.na(depois_todas$worms_yn) & depois_todas$captureinterval <= 180,
]
# Empates de intervalo permanecem na ordem do arquivo-fonte: ele é a única
# ordem observada quando duas recapturas receberam o mesmo intervalo em dias.
depois_validas <- depois_validas[
  order(depois_validas$animalID, depois_validas$captureinterval),
]
depois_primeira <- depois_validas[!duplicated(depois_validas$animalID), ]
indice_depois <- match(antes$animalID, depois_primeira$animalID)

traduzir_grupo <- function(x) ifelse(x == "bolus", "fenbendazol", "controle")

linhas_antes <- data.frame(
  id_bufalo = antes$animalID,
  id_captura = antes$captureID,
  tratamento = traduzir_grupo(antes$trt),
  momento = "antes",
  presenca_ovos_estrongilos = as.integer(antes$worms_yn),
  dias_apos_intervencao = 0L,
  stringsAsFactors = FALSE
)

tem_depois <- !is.na(indice_depois)
linhas_depois <- data.frame(
  id_bufalo = antes$animalID[tem_depois],
  id_captura = depois_primeira$captureID[indice_depois[tem_depois]],
  tratamento = traduzir_grupo(antes$trt[tem_depois]),
  momento = "depois",
  presenca_ovos_estrongilos = as.integer(
    depois_primeira$worms_yn[indice_depois[tem_depois]]
  ),
  dias_apos_intervencao = as.integer(
    depois_primeira$captureinterval[indice_depois[tem_depois]]
  ),
  stringsAsFactors = FALSE
)

bufalos_estrongilos <- rbind(linhas_antes, linhas_depois)
bufalos_estrongilos <- bufalos_estrongilos[
  order(bufalos_estrongilos$id_bufalo,
        match(bufalos_estrongilos$momento, c("antes", "depois"))),
]
row.names(bufalos_estrongilos) <- NULL
bufalos_estrongilos$tratamento <- factor(
  bufalos_estrongilos$tratamento,
  levels = c("controle", "fenbendazol")
)
bufalos_estrongilos$momento <- factor(
  bufalos_estrongilos$momento,
  levels = c("antes", "depois")
)

# Cópia traduzida e legível antes de criar o .rda do pacote.
utils::write.csv(
  bufalos_estrongilos,
  file.path(pasta, "bufalos_estrongilos.csv"),
  row.names = FALSE, na = ""
)

stopifnot(
  nrow(bufalos_estrongilos) == 418L,
  length(unique(bufalos_estrongilos$id_bufalo)) == 216L,
  sum(bufalos_estrongilos$momento == "antes") == 216L,
  sum(bufalos_estrongilos$momento == "depois") == 202L
)

# Só 196 animais têm os dois resultados binários e podem entrar no McNemar.
largo <- reshape(
  bufalos_estrongilos[, c("id_bufalo", "momento", "presenca_ovos_estrongilos")],
  idvar = "id_bufalo", timevar = "momento", direction = "wide"
)
pares_completos <- stats::complete.cases(largo)
grupo_por_id <- bufalos_estrongilos$tratamento[
  match(largo$id_bufalo, bufalos_estrongilos$id_bufalo)
]
tabela_fenbendazol <- table(
  largo$presenca_ovos_estrongilos.antes[
    pares_completos & grupo_por_id == "fenbendazol"
  ],
  largo$presenca_ovos_estrongilos.depois[
    pares_completos & grupo_por_id == "fenbendazol"
  ]
)
tabela_controle <- table(
  largo$presenca_ovos_estrongilos.antes[
    pares_completos & grupo_por_id == "controle"
  ],
  largo$presenca_ovos_estrongilos.depois[
    pares_completos & grupo_por_id == "controle"
  ]
)
stopifnot(
  sum(pares_completos) == 196L,
  identical(as.integer(tabela_fenbendazol), c(47L, 45L, 2L, 4L)),
  identical(as.integer(tabela_controle), c(27L, 16L, 16L, 39L))
)

usethis::use_data(bufalos_estrongilos, overwrite = TRUE)
