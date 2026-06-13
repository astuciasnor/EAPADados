# =============================================================================
# relatos_teste_t.R
# -----------------------------------------------------------------------------
# Motor de relato do teste t de Student (uma amostra, duas amostras
# independentes e amostras pareadas) para o ecossistema EAPA.
#
# calcular_*()  -> executa o teste e devolve UMA lista com as estatisticas.
# mostrar_*()   -> FORMATA a lista canonica como tabela (tibble).
# relatar_*()   -> FORMATA a lista canonica como frase em portugues.
# As strings de SAIDA usam acentos escritos com escapes \uxxxx (ASCII no fonte).
# =============================================================================

fmt <- function(x, dig = 2) {
  if (is.null(x) || length(x) == 0 || is.na(x)) return("-")
  formatC(x, format = "f", digits = dig, decimal.mark = ",")
}

interpretar_d <- function(d) {
  if (is.null(d) || length(d) == 0 || is.na(d)) return("indefinido")
  a <- abs(d)
  if (a < 0.20)      "desprez\u00edvel"
  else if (a < 0.50) "pequeno"
  else if (a < 0.80) "moderado"
  else               "grande"
}

rotulo_ic <- function(conf = 0.95, sufixo = "") {
  paste0("IC ", round(conf * 100), "%", sufixo)
}

#' Calculo canonico do teste t para uma amostra
#'
#' @param x vetor numerico.
#' @param mu valor de referencia (media hipotetica sob H0).
#' @param conf nivel de confianca do IC (padrao 0,95).
#' @return Uma lista com as estatisticas do teste.
#' @export
calcular_teste_t <- function(x, mu = 0, conf = 0.95) {
  teste <- stats::t.test(x, mu = mu, conf.level = conf)
  m     <- unname(teste$estimate)
  d     <- (mean(x, na.rm = TRUE) - mu) / stats::sd(x, na.rm = TRUE)
  list(mu = mu, media = m, t = unname(teste$statistic), gl = unname(teste$parameter),
       p = teste$p.value, ic = unname(teste$conf.int), d = d, efeito = interpretar_d(d),
       conf = conf, significativo = teste$p.value < 0.05)
}

#' Tabela de resultados do teste t para uma amostra
#'
#' @param x vetor numerico.
#' @param mu valor de referencia.
#' @param nome rotulo da variavel.
#' @param conf nivel de confianca do IC.
#' @return Um tibble de uma linha.
#' @export
mostrar_teste_t <- function(x, mu = 0, nome = "Vari\u00e1vel", conf = 0.95) {
  r <- calcular_teste_t(x, mu = mu, conf = conf)
  tab <- tibble::tibble(
    "Vari\u00e1vel" = nome, "M\u00e9dia amostral" = round(r$media, 2),
    "M\u00e9dia hipot\u00e9tica" = r$mu, "t" = round(r$t, 3), "gl" = r$gl,
    "p-valor" = round(r$p, 4), "__IC__" = paste0(round(r$ic[1], 2), " a ", round(r$ic[2], 2)),
    "d de Cohen" = round(r$d, 2), "Tamanho do efeito" = r$efeito,
    "Conclus\u00e3o" = ifelse(r$significativo, "Diferen\u00e7a significativa", "Diferen\u00e7a n\u00e3o significativa")
  )
  names(tab)[names(tab) == "__IC__"] <- rotulo_ic(conf)
  tab
}

#' Relato textual do teste t para uma amostra
#'
#' @param x vetor numerico.
#' @param mu valor de referencia.
#' @param nome rotulo da variavel.
#' @param conf nivel de confianca do IC.
#' @return Uma string com marcacao Markdown.
#' @export
relatar_teste_t <- function(x, mu = 0, nome = "a vari\u00e1vel", conf = 0.95) {
  r <- calcular_teste_t(x, mu = mu, conf = conf)
  nivel <- paste0(round(conf * 100), "%")
  p_txt <- if (r$p < 0.001) "p < 0,001" else paste0("p = ", fmt(r$p, 3))
  signif_txt <- if (r$significativo)
    "indicaram uma diferen\u00e7a estatisticamente significativa em rela\u00e7\u00e3o ao valor de refer\u00eancia"
  else
    "n\u00e3o indicaram diferen\u00e7a estatisticamente significativa em rela\u00e7\u00e3o ao valor de refer\u00eancia"
  direcao <- if (r$media < r$mu) "inferior" else if (r$media > r$mu) "superior" else "igual"
  paste0(
    "Foi conduzido um teste *t* para uma amostra com o objetivo de comparar a m\u00e9dia de ",
    nome, " com o valor de refer\u00eancia de ", fmt(r$mu), ". A m\u00e9dia amostral foi de ",
    fmt(r$media), " (IC ", nivel, " [", fmt(r$ic[1]), "; ", fmt(r$ic[2]), "]). Os resultados ",
    signif_txt, ", *t*(", r$gl, ") = ", fmt(r$t, 3), ", ", p_txt,
    ", sendo a m\u00e9dia amostral ", direcao, " ao valor hipot\u00e9tico. ",
    "O tamanho do efeito, estimado pelo *d* de Cohen, foi de ", fmt(r$d),
    ", correspondendo a um efeito ", r$efeito, "."
  )
}

#' Calculo canonico do teste t para duas amostras independentes
#'
#' @param formula_obj formula y ~ x.
#' @param data data.frame.
#' @param equal_var logico; FALSE usa Welch.
#' @param conf nivel de confianca do IC.
#' @return Uma lista com as estatisticas.
#' @export
calcular_teste_t_ind <- function(formula_obj, data, equal_var = FALSE, conf = 0.95) {
  teste <- stats::t.test(formula_obj, data = data, var.equal = equal_var, conf.level = conf)
  vars <- all.vars(formula_obj)
  y <- data[[vars[1]]]; x <- as.factor(data[[vars[2]]])
  levels_x <- levels(x)
  if (length(levels_x) < 2) levels_x <- c(levels_x, "Grupo 2")
  y1 <- y[x == levels_x[1]]; y2 <- y[x == levels_x[2]]
  n1 <- sum(!is.na(y1)); n2 <- sum(!is.na(y2))
  m1 <- mean(y1, na.rm = TRUE); m2 <- mean(y2, na.rm = TRUE)
  v1 <- stats::var(y1, na.rm = TRUE); v2 <- stats::var(y2, na.rm = TRUE)
  sd_pooled <- sqrt(((n1 - 1) * v1 + (n2 - 1) * v2) / (n1 + n2 - 2))
  d <- (m1 - m2) / sd_pooled
  list(levels_x = levels_x, m1 = m1, m2 = m2, n1 = n1, n2 = n2,
       t = unname(teste$statistic), gl = unname(teste$parameter), p = teste$p.value,
       ic = unname(teste$conf.int), d = d, efeito = interpretar_d(d),
       equal_var = equal_var, conf = conf, significativo = teste$p.value < 0.05)
}

#' Tabela do teste t para duas amostras independentes
#'
#' @inheritParams calcular_teste_t_ind
#' @return Um tibble de uma linha.
#' @export
mostrar_teste_t_ind <- function(formula_obj, data, equal_var = FALSE, conf = 0.95) {
  r <- calcular_teste_t_ind(formula_obj, data = data, equal_var = equal_var, conf = conf)
  tab <- tibble::tibble(
    "Grupo 1" = r$levels_x[1], "M\u00e9dia G1" = round(r$m1, 2),
    "Grupo 2" = r$levels_x[2], "M\u00e9dia G2" = round(r$m2, 2),
    "t" = round(r$t, 3), "gl" = round(r$gl, 2), "p-valor" = round(r$p, 4),
    "__IC__" = paste0(round(r$ic[1], 2), " a ", round(r$ic[2], 2)),
    "d de Cohen" = round(r$d, 2), "Tamanho do efeito" = r$efeito,
    "Conclus\u00e3o" = ifelse(r$significativo, "Diferen\u00e7a significativa", "Diferen\u00e7a n\u00e3o significativa")
  )
  names(tab)[names(tab) == "__IC__"] <- rotulo_ic(conf, " (Diferen\u00e7a)")
  tab
}

#' Relato do teste t para duas amostras independentes
#'
#' @inheritParams calcular_teste_t_ind
#' @param label_y rotulo da variavel de resposta.
#' @param label_x rotulo da variavel de agrupamento.
#' @return Uma string com marcacao Markdown.
#' @export
relatar_teste_t_ind <- function(formula_obj, data, equal_var = FALSE, conf = 0.95,
                                label_y = "a vari\u00e1vel de resposta", label_x = "a vari\u00e1vel de agrupamento") {
  r <- calcular_teste_t_ind(formula_obj, data = data, equal_var = equal_var, conf = conf)
  levels_x <- r$levels_x
  nivel <- paste0(round(conf * 100), "%")
  p_txt <- if (r$p < 0.001) "p < 0,001" else paste0("p = ", fmt(r$p, 3))
  signif_txt <- if (r$significativo)
    "indicaram uma diferen\u00e7a estatisticamente significativa entre as m\u00e9dias dos grupos"
  else
    "n\u00e3o indicaram diferen\u00e7a estatisticamente significativa entre as m\u00e9dias dos grupos"
  direcao <- if (r$m1 < r$m2) "inferior" else if (r$m1 > r$m2) "superior" else "igual"
  tipo_teste <- if (r$equal_var) "para vari\u00e2ncias iguais" else "de Welch (para vari\u00e2ncias desiguais)"
  paste0(
    "Foi conduzido um teste *t* de Student para duas amostras independentes ", tipo_teste,
    " para comparar a vari\u00e1vel ", label_y, " entre os grupos definidos por ", label_x,
    " (", levels_x[1], " vs ", levels_x[2], "). A m\u00e9dia no grupo ", levels_x[1],
    " foi de ", fmt(r$m1), " e a m\u00e9dia no grupo ", levels_x[2], " foi de ", fmt(r$m2),
    " (IC ", nivel, " da diferen\u00e7a [", fmt(r$ic[1]), "; ", fmt(r$ic[2]), "]). ",
    "Os resultados ", signif_txt, ", *t*(", fmt(r$gl, 1), ") = ", fmt(r$t, 3),
    ", ", p_txt, ", sendo a m\u00e9dia amostral do grupo ", levels_x[1], " ", direcao, " \u00e0 m\u00e9dia do grupo ", levels_x[2],
    ". O tamanho do efeito, estimado pelo *d* de Cohen, foi de ", fmt(r$d),
    ", correspondendo a um efeito ", r$efeito, "."
  )
}

#' Calculo canonico do teste t pareado
#'
#' @param x1 vetor numerico (antes).
#' @param x2 vetor numerico (depois).
#' @param conf nivel de confianca do IC.
#' @return Uma lista com as estatisticas.
#' @export
calcular_teste_t_pareado <- function(x1, x2, conf = 0.95) {
  teste <- stats::t.test(x1, x2, paired = TRUE, conf.level = conf)
  dif <- x1 - x2; m_dif <- mean(dif, na.rm = TRUE); sd_dif <- stats::sd(dif, na.rm = TRUE)
  d <- m_dif / sd_dif
  list(m1 = mean(x1, na.rm = TRUE), m2 = mean(x2, na.rm = TRUE), m_dif = m_dif,
       t = unname(teste$statistic), gl = unname(teste$parameter), p = teste$p.value,
       ic = unname(teste$conf.int), d = d, efeito = interpretar_d(d),
       conf = conf, significativo = teste$p.value < 0.05)
}

#' Tabela do teste t pareado
#'
#' @param x1 vetor numerico (antes).
#' @param x2 vetor numerico (depois).
#' @param nome1 rotulo do momento 1.
#' @param nome2 rotulo do momento 2.
#' @param conf nivel de confianca do IC.
#' @return Um tibble de uma linha.
#' @export
mostrar_teste_t_pareado <- function(x1, x2, nome1 = "Antes", nome2 = "Depois", conf = 0.95) {
  r <- calcular_teste_t_pareado(x1, x2, conf = conf)
  tab <- tibble::tibble(
    "Vari\u00e1vel 1" = nome1, "M\u00e9dia V1" = round(r$m1, 2),
    "Vari\u00e1vel 2" = nome2, "M\u00e9dia V2" = round(r$m2, 2),
    "Diferen\u00e7a M\u00e9dia" = round(r$m_dif, 2), "t" = round(r$t, 3), "gl" = r$gl,
    "p-valor" = round(r$p, 4), "__IC__" = paste0(round(r$ic[1], 2), " a ", round(r$ic[2], 2)),
    "d de Cohen" = round(r$d, 2), "Tamanho do efeito" = r$efeito,
    "Conclus\u00e3o" = ifelse(r$significativo, "Diferen\u00e7a significativa", "Diferen\u00e7a n\u00e3o significativa")
  )
  names(tab)[names(tab) == "__IC__"] <- rotulo_ic(conf, " (Diferen\u00e7a)")
  tab
}

#' Relato do teste t pareado
#'
#' @param x1 vetor numerico (antes).
#' @param x2 vetor numerico (depois).
#' @param nome1 rotulo do momento 1.
#' @param nome2 rotulo do momento 2.
#' @param conf nivel de confianca do IC.
#' @param label_y rotulo da variavel de interesse.
#' @return Uma string com marcacao Markdown.
#' @export
relatar_teste_t_pareado <- function(x1, x2, nome1 = "Antes", nome2 = "Depois", conf = 0.95, label_y = "a vari\u00e1vel de interesse") {
  r <- calcular_teste_t_pareado(x1, x2, conf = conf)
  nivel <- paste0(round(conf * 100), "%")
  p_txt <- if (r$p < 0.001) "p < 0,001" else paste0("p = ", fmt(r$p, 3))
  signif_txt <- if (r$significativo)
    "indicaram uma diferen\u00e7a estatisticamente significativa entre os momentos pareados"
  else
    "n\u00e3o indicaram diferen\u00e7a estatisticamente significativa entre os momentos pareados"
  direcao <- if (r$m_dif < 0) "inferior (redu\u00e7\u00e3o)" else if (r$m_dif > 0) "superior (aumento)" else "igual"
  paste0(
    "Foi conduzido um teste *t* pareado para comparar a m\u00e9dia de ", label_y, " entre os momentos ", nome1, " e ", nome2,
    ". A m\u00e9dia no momento ", nome1, " foi de ", fmt(r$m1), " e a m\u00e9dia no momento ", nome2,
    " foi de ", fmt(r$m2), ", resultando em uma diferen\u00e7a m\u00e9dia de ", fmt(r$m_dif),
    " (IC ", nivel, " da diferen\u00e7a [", fmt(r$ic[1]), "; ", fmt(r$ic[2]), "]). Os resultados ",
    signif_txt, ", *t*(", r$gl, ") = ", fmt(r$t, 3), ", ", p_txt,
    ", sendo a m\u00e9dia de ", nome1, " caracterizada como ", direcao, " em rela\u00e7\u00e3o a ", nome2,
    ". O tamanho do efeito, estimado pelo *d* de Cohen pareado, foi de ", fmt(r$d),
    ", correspondendo a um efeito ", r$efeito, "."
  )
}

#' Formata um tibble na identidade visual Ocean Gradient (flextable, docx)
#'
#' @param tab um data.frame/tibble.
#' @return Um objeto flextable formatado.
#' @export
flextable_ocean <- function(tab) {
  if (!requireNamespace("flextable", quietly = TRUE)) {
    stop("O pacote 'flextable' e necessario para formatar a tabela.", call. = FALSE)
  }
  flextable::flextable(tab) |>
    flextable::theme_booktabs() |>
    flextable::bg(part = "header", bg = "#0F3B5F") |>
    flextable::color(part = "header", color = "white") |>
    flextable::bold(part = "header") |>
    flextable::font(fontname = "Times New Roman", part = "all") |>
    flextable::fontsize(size = 9, part = "all") |>
    flextable::align(align = "center", part = "all") |>
    flextable::align(j = 1, align = "left", part = "all") |>
    flextable::padding(padding = 4, part = "all") |>
    flextable::autofit()
}
