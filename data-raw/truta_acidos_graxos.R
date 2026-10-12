pasta_fonte <- "data-raw/truta_acidos_graxos"
# Semana final do ensaio. Cada aquário recebeu uma única dieta sorteada.
# Os peixes são subamostras; a média de cada aquário dá uma linha por UE.
arquivo <- file.path(pasta_fonte, "The Full Dataset.xlsx")
hash <- digest::digest(file = arquivo, algo = "sha256")
stopifnot(identical(hash, "587d6acba9d95b0abc0ec900a6a2990ab56209b5c78fbe39ac7e10528efd2314"))
brutos <- as.data.frame(readxl::read_excel(arquivo, sheet = "FAS as percentage"))
names(brutos) <- trimws(names(brutos))
semana <- suppressWarnings(as.numeric(brutos$Week))
peixes <- brutos[!is.na(semana) & semana == 12, ]
acidos_originais <- c("C12:0", "C14:0", "C15:0", "C16:0", "C16:1n-9", "C16:1n-7", "C17:0", "C17:1", "C18:0", "C18:1n-9", "C18:1n-7", "C18:2n-6", "C18:3n-3", "C18:4n-3", "C20:0", "C20:1", "C20:2n-6", "C20:3n-6", "C20:4n-6", "C20:3n-3", "C20:4n-3", "C20:5n-3", "C22:0", "C22:4n-6", "C22:5n-6", "C22:5n-3", "C22:6n-3")
nomes_acidos <- c("c12_0_pct", "c14_0_pct", "c15_0_pct", "c16_0_pct", "c16_1n9_pct", "c16_1n7_pct", "c17_0_pct", "c17_1_pct", "c18_0_pct", "c18_1n9_pct", "c18_1n7_pct", "c18_2n6_pct", "c18_3n3_pct", "c18_4n3_pct", "c20_0_pct", "c20_1_pct", "c20_2n6_pct", "c20_3n6_pct", "c20_4n6_pct", "c20_3n3_pct", "c20_4n3_pct", "c20_5n3_pct", "c22_0_pct", "c22_4n6_pct", "c22_5n6_pct", "c22_5n3_pct", "c22_6n3_pct")
stopifnot(nrow(peixes) == 60L, !anyDuplicated(peixes[["Sample Name"]]),
          !anyNA(peixes[acidos_originais]),
          all(as.matrix(peixes[acidos_originais]) >= 0))
aquarios <- sort(unique(as.integer(peixes$Aquarium)))
medias <- do.call(rbind, lapply(aquarios, function(id) {
  amostras <- peixes[peixes$Aquarium == id, ]
  stopifnot(length(unique(amostras[["Diet Abbv."]])) == 1L)
  colMeans(amostras[acidos_originais])
}))
colnames(medias) <- nomes_acidos
siglas <- c("B", "D", "S", "B:D", "B:S", "S:D", "B:S:D")
rotulos <- c("quironomideos", "dafnias", "camaroes", "quironomideos_dafnias",
             "quironomideos_camaroes", "dafnias_camaroes", "tres_presas")
dieta_aquario <- vapply(aquarios, function(id) {
  unique(peixes[["Diet Abbv."]][peixes$Aquarium == id])
}, character(1))
truta_acidos_graxos <- data.frame(
  id_aquario = as.character(aquarios),
  dieta = factor(dieta_aquario, levels = siglas, labels = rotulos),
  semana = rep(12L, length(aquarios)),
  n_peixes = vapply(aquarios, function(id) sum(peixes$Aquarium == id), integer(1)),
  medias, check.names = FALSE
)
# O valor extremo TL10884v continua incluído na média do aquário 39.
stopifnot(identical(dim(truta_acidos_graxos), c(21L, 31L)),
          !anyNA(truta_acidos_graxos),
          identical(as.integer(table(truta_acidos_graxos$dieta)), rep(3L, 7)),
          sum(truta_acidos_graxos$n_peixes) == 60L,
          max(abs(rowSums(truta_acidos_graxos[nomes_acidos]) - 100)) < 1e-10)
save(truta_acidos_graxos, file = "data/truta_acidos_graxos.rda", compress = "xz")
