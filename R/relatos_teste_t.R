# =============================================================================
# relatos_teste_t.R
# -----------------------------------------------------------------------------
# Motor de relato do teste t de Student (uma amostra, duas amostras
# independentes e amostras pareadas) para o ecossistema EAPA.
#
# calcular_*()  -> executa o teste e devolve UMA lista com as estatísticas.
# mostrar_*()   -> FORMATA a lista canônica como tabela (tibble).
# relatar_*()   -> FORMATA a lista canônica como frase em português.
# As strings de saída usam acentos escritos com escapes \uxxxx (código ASCII).
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

#' Cálculo canônico do teste t para uma amostra
#'
#' Executa o teste t de uma amostra e devolve uma lista com todas as
#' estatísticas (média, t, gl, p, IC, d de Cohen, efeito, significância).
#' É a fonte única consumida por \code{mostrar_teste_t} e \code{relatar_teste_t}.
#'
#' @param x vetor numérico.
#' @param mu valor de referência (média hipotética sob H0).
#' @param conf nível de confiança do IC (padrão 0,95).
#' @return Uma lista com as estatísticas do teste.
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
#' @param x vetor numérico.
#' @param mu valor de referência (média hipotética sob H0).
#' @param nome rótulo da variável.
#' @param conf nível de confiança do IC (padrão 0,95).
#' @return Um tibble de uma linha com os resultados.
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

#' Relato textual em português do teste t para uma amostra
#'
#' @param x vetor numérico.
#' @param mu valor de referência (média hipotética sob H0).
#' @param nome rótulo da variável.
#' @param conf nível de confiança do IC (padrão 0,95).
#' @return Uma string com marcação Markdown para itálico no docx.
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

#' Cálculo canônico do teste t para duas amostras independentes
#'
#' @param formula_obj fórmula y ~ x (ex.: peso ~ grupo).
#' @param data data.frame com as variáveis.
#' @param equal_var lógico; FALSE usa Welch (variâncias desiguais).
#' @param conf nível de confiança do IC (padrão 0,95).
#' @return Uma lista com as estatísticas do teste.
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
#' @return Um tibble de uma linha com os resultados.
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
#' @param label_y rótulo da variável de resposta.
#' @param label_x rótulo da variável de agrupamento.
#' @return Uma string com marcação Markdown para itálico no docx.
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

#' Cálculo canônico do teste t pareado
#'
#' @param x1 vetor numérico (momento 1 / antes).
#' @param x2 vetor numérico (momento 2 / depois).
#' @param conf nível de confiança do IC (padrão 0,95).
#' @return Uma lista com as estatísticas do teste.
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
#' @param x1 vetor numérico (momento 1 / antes).
#' @param x2 vetor numérico (momento 2 / depois).
#' @param nome1 rótulo do momento 1.
#' @param nome2 rótulo do momento 2.
#' @param conf nível de confiança do IC (padrão 0,95).
#' @return Um tibble de uma linha com os resultados.
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
#' @param x1 vetor numérico (momento 1 / antes).
#' @param x2 vetor numérico (momento 2 / depois).
#' @param nome1 rótulo do momento 1.
#' @param nome2 rótulo do momento 2.
#' @param conf nível de confiança do IC (padrão 0,95).
#' @param label_y rótulo da variável de interesse.
#' @return Uma string com marcação Markdown para itálico no docx.
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
#' Recebe o tibble de qualquer \code{mostrar_*} e devolve um flextable
#' formatado. Requer o pacote \pkg{flextable} (em Suggests).
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

#' Arruma o resultado de um teste t num data frame enxuto (em português)
#'
#' Recebe um objeto \code{htest} produzido por \code{\link[stats]{t.test}}
#' (uma amostra, duas amostras independentes ou pareado) e devolve um
#' \code{data.frame} de uma linha, em português, com as informações essenciais
#' do teste: médias, diferença, intervalo de confiança (num campo só), \emph{t},
#' gl, \emph{p}, além do método e da hipótese alternativa (traduzidos e
#' abreviados). Por ser um \code{data.frame} comum, imprime de forma crua e
#' limpa, sem os enfeites de tibble (\code{# A tibble}, \code{<dbl>}).
#'
#' Diferente de \code{mostrar_teste_t*()}, que recebem os dados e executam o
#' teste, esta função trabalha sobre um teste \strong{já calculado}.
#'
#' @param objeto objeto de classe \code{htest} (saída de \code{stats::t.test}).
#' @param dig casas decimais para arredondamento (padrão 3).
#' @return Um \code{data.frame} de uma linha, com colunas em português.
#' @examples
#' res <- t.test(extra ~ group, data = sleep)
#' arrumar_teste_t(res)
#' @export
arrumar_teste_t <- function(objeto, dig = 3) {
  if (!inherits(objeto, "htest")) {
    stop("'objeto' deve ser o resultado de stats::t.test().", call. = FALSE)
  }
  est    <- objeto$estimate
  ic     <- objeto$conf.int
  nivel  <- attr(ic, "conf.level"); if (is.null(nivel)) nivel <- 0.95
  rot_ic <- paste0("IC ", round(nivel * 100), "%")
  ic_txt <- paste0(round(ic[1], dig), " a ", round(ic[2], dig))
  t_val  <- round(unname(objeto$statistic), dig)
  gl_val <- round(unname(objeto$parameter), 1)
  p_val  <- round(objeto$p.value, dig)

  metodo <- if (grepl("Welch", objeto$method)) "Welch"
            else if (grepl("Paired", objeto$method)) "pareado"
            else if (grepl("One Sample", objeto$method)) "1 amostra"
            else "2 amostras"
  alt <- switch(objeto$alternative,
                "two.sided" = "bilateral",
                "less"      = "unilateral (<)",
                "greater"   = "unilateral (>)",
                objeto$alternative)

  if (length(est) == 2) {                       # duas amostras independentes
    nomes <- sub("^mean (in group|of) ", "", names(est))
    e <- unname(round(est, dig))
    out <- data.frame(
      e[1], e[2], round(e[1] - e[2], dig),
      t_val, gl_val, p_val, ic_txt, metodo, alt,
      check.names = FALSE, row.names = NULL, stringsAsFactors = FALSE
    )
    names(out) <- c(paste0("m\u00e9dia ", nomes[1]), paste0("m\u00e9dia ", nomes[2]),
                    "diferen\u00e7a", "t", "gl", "p", rot_ic, "m\u00e9todo", "Tipo")
  } else if (grepl("Paired", objeto$method)) {  # amostras pareadas
    out <- data.frame(
      round(unname(est), dig),
      t_val, gl_val, p_val, ic_txt, metodo, alt,
      check.names = FALSE, row.names = NULL, stringsAsFactors = FALSE
    )
    names(out) <- c("dif. m\u00e9dia", "t", "gl", "p", rot_ic, "m\u00e9todo", "Tipo")
  } else {                                      # uma amostra
    mu <- if (!is.null(objeto$null.value)) unname(objeto$null.value) else 0
    m  <- round(unname(est), dig)
    out <- data.frame(
      m, round(mu, dig), round(m - mu, dig),
      t_val, gl_val, p_val, ic_txt, metodo, alt,
      check.names = FALSE, row.names = NULL, stringsAsFactors = FALSE
    )
    names(out) <- c("m\u00e9dia", "m\u00e9dia H0", "diferen\u00e7a", "t", "gl", "p",
                    rot_ic, "m\u00e9todo", "Tipo")
  }
  class(out) <- c("arrumo_teste_t", "data.frame")
  out
}

#' @export
print.arrumo_teste_t <- function(x, ...) {
  print.data.frame(x, right = FALSE, ...)
}

#' Formata um data.frame como tabela "saída de Viewer", sem linhas de grade
#'
#' Dá a impressão de uma saída de console, porém organizada: fonte
#' monoespaçada, fundo \strong{verde acinzentado} (sage), texto centralizado,
#' cabeçalho em negrito e \strong{sem linhas de grade}. O tom verde a distingue
#' de duas coisas: do fundo cinza dos blocos de código (que é "código") e das
#' tabelas referenciadas no tema Ocean (\code{flextable_ocean()}, que levam
#' legenda). Assim o leitor reconhece, de relance, uma \emph{exibição de
#' resultado no Viewer}. Recebe qualquer data.frame/tibble (por exemplo, a saída
#' de \code{arrumar_teste_t}) e devolve um flextable. Requer o pacote
#' \pkg{flextable} (em Suggests).
#'
#' @param tab um data.frame/tibble.
#' @param bg_corpo cor de fundo do corpo (padrão "#E7EFEA", verde sage claro).
#' @param bg_cabecalho cor de fundo do cabeçalho (padrão "#C5D8CF", sage médio).
#' @return Um objeto flextable.
#' @examples
#' res <- t.test(extra ~ group, data = sleep)
#' flextable_cinza(arrumar_teste_t(res))
#' @export
flextable_cinza <- function(tab, bg_corpo = "#E7EFEA", bg_cabecalho = "#C5D8CF") {
  if (!requireNamespace("flextable", quietly = TRUE)) {
    stop("O pacote 'flextable' e necessario para formatar a tabela.", call. = FALSE)
  }
  flextable::flextable(as.data.frame(tab)) |>
    flextable::border_remove() |>
    flextable::bg(bg = bg_corpo, part = "body") |>
    flextable::bg(bg = bg_cabecalho, part = "header") |>
    flextable::bold(part = "header") |>
    flextable::align(align = "center", part = "all") |>
    flextable::font(fontname = "Consolas", part = "all") |>   # monoespacada (cara de console)
    flextable::fontsize(size = 9, part = "all") |>
    flextable::padding(padding = 5, part = "all") |>
    flextable::autofit()
}

#' Exibe o resultado de um teste t como tabela "console organizado"
#'
#' Atalho de uma chamada para a saída-padrão do teste \emph{t} no corpo do
#' livro: arruma o teste e o formata no tema cinza. Equivale a
#' \code{arrumar_teste_t(objeto) |> flextable_cinza()}, mas numa função só.
#' Recebe um objeto \code{htest} \strong{já calculado} (saída de
#' \code{\link[stats]{t.test}}) e devolve um flextable \strong{já arrumado},
#' que abre no \emph{Viewer} do RStudio. O nome \code{exibir_*} deixa claro que
#' a saída já vem arrumada — diferente de \code{mostrar_*}, reservado às tabelas
#' que recebem dados crus e rodam o teste.
#'
#' @param objeto objeto de classe \code{htest} (saída de \code{stats::t.test}).
#' @param dig casas decimais para arredondamento (padrão 3).
#' @param ... argumentos extras repassados a \code{\link{flextable_cinza}}
#'   (por exemplo, \code{bg_corpo} e \code{bg_cabecalho}).
#' @return Um objeto flextable no tema cinza, pronto para o Viewer/relatório.
#' @seealso \code{\link{arrumar_teste_t}}, \code{\link{flextable_cinza}}
#' @examples
#' res <- t.test(extra ~ group, data = sleep)
#' exibir_teste_t(res)
#' @export
exibir_teste_t <- function(objeto, dig = 3, ...) {
  flextable_cinza(arrumar_teste_t(objeto, dig = dig), ...)
}
