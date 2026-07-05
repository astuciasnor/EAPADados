# =============================================================================
# relatos_crescimento.R
# -----------------------------------------------------------------------------
# Motor de relato e regressão não-linear (modelos de crescimento e alometria)
# para o ecossistema EAPA. Migrado de catalyser/.../templates/funcoes_crescimento.R.
#
# ajustar_curva()             -> realiza o ajuste nls ou glm correspondente.
# tipo_curva_label()         -> converte o slug do modelo para rótulo amigável.
# equacao_curva()            -> gera a representação em texto da curva ajustada.
# mostrar_coefs_curva()       -> formata tabela de parâmetros/coeficientes (tibble).
# mostrar_metricas_curva()    -> formata tabela de qualidade de ajuste (tibble).
# mostrar_normalidade_curva() -> formata tabela de Shapiro-Wilk (resíduos).
# curva_predita()             -> gera grid fina de pontos preditos para gráficos.
# relatar_curva()             -> gera descrição narrativa em português.
# =============================================================================

# ---- Valores iniciais robustos para os modelos ------------------------------

.start_potencia <- function(x, y) {
  ok <- x > 0 & y > 0
  if (sum(ok) >= 2) {
    lm0 <- stats::lm(log(y[ok]) ~ log(x[ok]))
    a0 <- exp(unname(stats::coef(lm0)[1]))
    b0 <- unname(stats::coef(lm0)[2])
    if (!is.finite(a0) || a0 <= 0) a0 <- 1e-3
    if (!is.finite(b0)) b0 <- 3
  } else {
    a0 <- 1e-3; b0 <- 3
  }
  list(a = a0, b = b0)
}

.start_vonbert <- function(x, y) {
  s <- tryCatch({
    m0 <- stats::nls(y ~ stats::SSasymp(x, Asym, R0, lrc))
    cc <- stats::coef(m0)
    Linf <- unname(cc["Asym"]); R0 <- unname(cc["R0"]); k <- exp(unname(cc["lrc"]))
    ratio <- 1 - R0 / Linf
    t0 <- if (is.finite(ratio) && ratio > 0 && k > 0) log(ratio) / k else 0
    list(Linf = Linf, k = k, t0 = t0)
  }, error = function(e) NULL)
  if (is.null(s)) s <- list(Linf = 1.05 * max(y), k = 0.3, t0 = 0)
  s
}

.start_logistico <- function(x, y) {
  s <- tryCatch({
    m0 <- stats::nls(y ~ stats::SSlogis(x, Asym, xmid, scal))
    cc <- stats::coef(m0)
    list(Linf = unname(cc["Asym"]), k = 1 / unname(cc["scal"]), tm = unname(cc["xmid"]))
  }, error = function(e) NULL)
  if (is.null(s)) s <- list(Linf = 1.05 * max(y), k = 1, tm = stats::median(x))
  s
}

.start_exponencial <- function(x, y) {
  ok <- y > 0
  if (sum(ok) >= 2) {
    lm0 <- stats::lm(log(y[ok]) ~ x[ok])
    a0 <- exp(unname(stats::coef(lm0)[1]))
    b0 <- unname(stats::coef(lm0)[2])
    if (!is.finite(a0) || a0 <= 0) a0 <- 1
    if (!is.finite(b0)) b0 <- 0.1
  } else {
    a0 <- 1; b0 <- 0.1
  }
  list(a = a0, b = b0)
}

.start_polinomial <- function(x, y) {
  lm0 <- stats::lm(y ~ x + I(x^2))
  cc <- stats::coef(lm0)
  list(b0 = unname(cc[1]), b1 = unname(cc[2]), b2 = unname(cc[3]))
}

.start_logaritmica <- function(x, y) {
  ok <- x > 0
  if (sum(ok) >= 2) {
    lm0 <- stats::lm(y[ok] ~ log(x[ok]))
    cc <- stats::coef(lm0)
    a0 <- unname(cc[1])
    b0 <- unname(cc[2])
  } else {
    a0 <- 0; b0 <- 1
  }
  list(a = a0, b = b0)
}

# ---- Funções Exportadas -----------------------------------------------------

#' Rótulo amigável do tipo de curva
#'
#' @param tipo string identificadora do tipo de curva ("potencia", "von_bertalanffy", "logistico", "exponencial", "polinomial", "logaritmica").
#' @return Uma string com o nome formatado do modelo em português.
#' @encoding UTF-8
#' @export
tipo_curva_label <- function(tipo) {
  switch(tipo,
    "potencia"        = "Modelo de Pot\u00eancia (W = a\u00b7L^b)",
    "von_bertalanffy" = "Von Bertalanffy",
    "logistico"       = "Log\u00edstico",
    "exponencial"     = "Curva Exponencial (Y = a\u00b7e^(b\u00b7X))",
    "polinomial"      = "Modelo Polinomial (Regress\u00e3o Quadr\u00e1tica)",
    "logaritmica"     = "Curva Logar\u00edtmica (Y = a + b\u00b7ln(X))",
    tipo)
}

#' Ajuste canônico de modelos de regressão não-linear
#'
#' Ajusta um modelo não-linear (potência, Von Bertalanffy, logístico, exponencial,
#' polinomial quadrático ou logarítmico) a partir de um conjunto de dados.
#'
#' @param dados data.frame/tibble com as variáveis.
#' @param var_y nome da variável dependente (string).
#' @param var_x nome da variável independente (string).
#' @param tipo tipo do modelo a ser ajustado (padrão "potencia").
#' @return Uma lista estruturada com o modelo ajustado (nls), coeficientes,
#'   métricas de ajuste (pseudo-R², RSE, AIC) e validação de normalidade dos resíduos.
#' @encoding UTF-8
#' @export
ajustar_curva <- function(dados, var_y, var_x,
                          tipo = c("potencia", "von_bertalanffy", "logistico", "exponencial", "polinomial", "logaritmica")) {
  tipo <- match.arg(tipo)
  df <- stats::na.omit(dados[, c(var_x, var_y), drop = FALSE])
  x <- as.numeric(df[[var_x]])
  y <- as.numeric(df[[var_y]])
  if (length(y) < 3) {
    stop("Dados insuficientes para o ajuste n\u00e3o-linear (m\u00ednimo 3 pontos).")
  }
  df2 <- data.frame(x = x, y = y)

  ctrl <- stats::nls.control(maxiter = 200, warnOnly = TRUE, minFactor = 1e-10)

  fit <- switch(tipo,
    "potencia" = {
      st <- .start_potencia(x, y)
      tryCatch(stats::nls(y ~ a * x^b, data = df2, start = st, control = ctrl),
               error = function(e) NULL)
    },
    "von_bertalanffy" = {
      st <- .start_vonbert(x, y)
      tryCatch(stats::nls(y ~ Linf * (1 - exp(-k * (x - t0))), data = df2,
                          start = st, control = ctrl),
               error = function(e) NULL)
    },
    "logistico" = {
      st <- .start_logistico(x, y)
      tryCatch(stats::nls(y ~ Linf / (1 + exp(-k * (x - tm))), data = df2,
                          start = st, control = ctrl),
               error = function(e) NULL)
    },
    "exponencial" = {
      st <- .start_exponencial(x, y)
      tryCatch(stats::nls(y ~ a * exp(b * x), data = df2, start = st, control = ctrl),
               error = function(e) NULL)
    },
    "polinomial" = {
      st <- .start_polinomial(x, y)
      tryCatch(stats::nls(y ~ b0 + b1 * x + b2 * x^2, data = df2, start = st, control = ctrl),
               error = function(e) NULL)
    },
    "logaritmica" = {
      st <- .start_logaritmica(x, y)
      tryCatch(stats::nls(y ~ a + b * log(x), data = df2, start = st, control = ctrl),
               error = function(e) NULL)
    }
  )

  if (is.null(fit)) {
    stop(paste0("N\u00e3o foi poss\u00edvel ajustar o modelo ", tipo_curva_label(tipo),
                " aos dados. Verifique as vari\u00e1veis escolhidas."))
  }

  sum_fit <- summary(fit)
  coef_matrix <- sum_fit$coefficients
  resid <- stats::residuals(fit)
  ss_res <- sum(resid^2)
  ss_tot <- sum((y - mean(y))^2)
  pseudo_r2 <- if (ss_tot > 0) 1 - ss_res / ss_tot else NA_real_
  n <- length(y)
  n_par <- length(stats::coef(fit))
  rse <- if (n > n_par) sqrt(ss_res / (n - n_par)) else NA_real_
  aic <- tryCatch(stats::AIC(fit), error = function(e) NA_real_)

  # Normalidade dos resíduos (Shapiro-Wilk)
  sh <- if (n >= 3 && n <= 5000) {
    tryCatch(stats::shapiro.test(resid), error = function(e) NULL)
  } else {
    NULL
  }

  list(
    modelo = fit, tipo = tipo, var_y = var_y, var_x = var_x,
    coefs = coef_matrix, params = stats::coef(fit),
    pseudo_r2 = pseudo_r2, rse = rse, aic = aic, n = n,
    sh_stat = if (!is.null(sh)) unname(sh$statistic) else NA_real_,
    sh_p    = if (!is.null(sh)) sh$p.value else NA_real_,
    x = x, y = y
  )
}

#' Equação formatada do modelo ajustado
#'
#' @param r lista retornada por \code{ajustar_curva}.
#' @return Uma string com a equação matemática estimada em português.
#' @encoding UTF-8
#' @export
equacao_curva <- function(r) {
  p <- r$params
  if (r$tipo == "potencia") {
    sprintf("Y = %s \u00b7 X^%s", fmt(unname(p["a"]), 5), fmt(unname(p["b"]), 4))
  } else if (r$tipo == "von_bertalanffy") {
    sprintf("L(t) = %s \u00b7 (1 \u2212 e^(\u2212%s(t \u2212 %s)))",
            fmt(unname(p["Linf"]), 2), fmt(unname(p["k"]), 4), fmt(unname(p["t0"]), 4))
  } else if (r$tipo == "logistico") {
    sprintf("L(t) = %s / (1 + e^(\u2212%s(t \u2212 %s)))",
            fmt(unname(p["Linf"]), 2), fmt(unname(p["k"]), 4), fmt(unname(p["tm"]), 4))
  } else if (r$tipo == "exponencial") {
    sprintf("Y = %s \u00b7 e^(%s \u00b7 X)", fmt(unname(p["a"]), 4), fmt(unname(p["b"]), 4))
  } else if (r$tipo == "polinomial") {
    sprintf("Y = %s + (%s) \u00b7 X + (%s) \u00b7 X\u00b2", fmt(unname(p["b0"]), 4), fmt(unname(p["b1"]), 4), fmt(unname(p["b2"]), 4))
  } else if (r$tipo == "logaritmica") {
    sprintf("Y = %s + (%s) \u00b7 ln(X)", fmt(unname(p["a"]), 4), fmt(unname(p["b"]), 4))
  } else {
    "Equa\u00e7\u00e3o n\u00e3o suportada"
  }
}

#' Tabela de coeficientes do modelo ajustado
#'
#' @param r lista retornada por \code{ajustar_curva}.
#' @return Um tibble com os parâmetros estimadores da curva.
#' @encoding UTF-8
#' @export
mostrar_coefs_curva <- function(r) {
  if (!is.list(r) || is.null(r$coefs)) {
    stop("Objeto de ajuste inv\u00e1lido.")
  }
  cm <- as.data.frame(r$coefs)
  tibble::tibble(
    "Par\u00e2metro"     = rownames(r$coefs),
    "Estimativa"        = round(cm[[1]], 5),
    "Erro Padr\u00e3o"   = round(cm[[2]], 5),
    "Valor t"           = round(cm[[3]], 3),
    "p-valor"           = round(cm[[4]], 4)
  )
}

#' Tabela de métricas globais de ajuste
#'
#' @param r lista retornada por \code{ajustar_curva}.
#' @return Um tibble com as estatísticas descritivas de qualidade global do ajuste.
#' @encoding UTF-8
#' @export
mostrar_metricas_curva <- function(r) {
  tibble::tibble(
    "M\u00e9trica de Ajuste" = c(
      "Modelo", "Pseudo-R\u00b2", "Erro Padr\u00e3o Residual (RSE)",
      "AIC", "N observa\u00e7\u00f5es"
    ),
    "Valor" = c(
      tipo_curva_label(r$tipo),
      if (is.na(r$pseudo_r2)) "-" else paste0(fmt(r$pseudo_r2, 4), " (", fmt(r$pseudo_r2 * 100, 2), "%)"),
      fmt(r$rse, 4),
      if (is.na(r$aic)) "-" else fmt(r$aic, 2),
      as.character(r$n)
    )
  )
}

#' Tabela de normalidade dos resíduos (Shapiro-Wilk)
#'
#' @param r lista retornada por \code{ajustar_curva}.
#' @return Um tibble de uma linha com o teste de Shapiro-Wilk.
#' @encoding UTF-8
#' @export
mostrar_normalidade_curva <- function(r) {
  tibble::tibble(
    "Teste" = "Shapiro-Wilk",
    "Estat\u00edstica W" = if (is.na(r$sh_stat)) "-" else fmt(r$sh_stat, 4),
    "p-valor" = if (is.na(r$sh_p)) "-" else fmt(r$sh_p, 4),
    "Resultado" = if (is.na(r$sh_p)) "N/A" else ifelse(
      r$sh_p >= 0.05,
      "Res\u00edduos normais (H0 mantida)",
      "Desvio de normalidade (H0 rejeitada)"
    )
  )
}

#' Tabela de pressupostos da curva (Alias)
#'
#' @param r lista retornada por \code{ajustar_curva}.
#' @return Um tibble de uma linha com o teste de Shapiro-Wilk.
#' @encoding UTF-8
#' @export
mostrar_pressupostos_curva <- mostrar_normalidade_curva

#' Grade fina de pontos preditos para gráficos
#'
#' @param r lista retornada por \code{ajustar_curva}.
#' @param n número de pontos na grade (padrão 200).
#' @return Um data.frame contendo as colunas de X e Y com os valores estimados da curva.
#' @encoding UTF-8
#' @export
curva_predita <- function(r, n = 200) {
  xr <- range(r$x, na.rm = TRUE)
  grid <- data.frame(x = seq(xr[1], xr[2], length.out = n))
  grid$y <- as.numeric(stats::predict(r$modelo, newdata = grid))
  stats::setNames(grid, c(r$var_x, r$var_y))
}

#' Relato textual automatizado em português
#'
#' @param r lista retornada por \code{ajustar_curva}.
#' @param label_y descrição da variável dependente (opcional).
#' @param label_x descrição da variável independente (opcional).
#' @return Uma string com o relato estatístico interpretativo formatado em Markdown.
#' @encoding UTF-8
#' @export
relatar_curva <- function(r, label_y = NULL, label_x = NULL) {
  if (is.null(label_y)) label_y <- paste0("a vari\u00e1vel ", r$var_y)
  if (is.null(label_x)) label_x <- paste0("a vari\u00e1vel ", r$var_x)
  p <- r$params
  r2txt <- if (is.na(r$pseudo_r2)) {
    "indispon\u00edvel"
  } else {
    paste0(fmt(r$pseudo_r2, 4), " (", fmt(r$pseudo_r2 * 100, 2), "%)")
  }

  base <- sprintf(
    paste0("Foi ajustado um %s para descrever %s em fun\u00e7\u00e3o de %s, pelo m\u00e9todo ",
           "dos m\u00ednimos quadrados n\u00e3o-lineares. A equa\u00e7\u00e3o estimada foi: *%s*. ",
           "O modelo alcan\u00e7ou um pseudo-R\u00b2 de %s e erro padr\u00e3o residual (RSE) de %s."),
    tipo_curva_label(r$tipo), label_y, label_x, equacao_curva(r), r2txt, fmt(r$rse, 4))

  if (r$tipo == "potencia") {
    b <- unname(p["b"])
    alom <- if (abs(b - 3) <= 0.1) {
      "isometria (b \u2248 3), com crescimento aproximadamente proporcional"
    } else if (b < 3) {
      "alometria negativa (b < 3): o corpo tende a alongar mais do que engordar"
    } else {
      "alometria positiva (b > 3): o corpo tende a engordar mais do que alongar"
    }
    extra <- sprintf(" O expoente estimado foi *b* = %s, caracterizando %s.", fmt(b, 4), alom)
  } else if (r$tipo == "von_bertalanffy") {
    extra <- sprintf(paste0(" O comprimento assint\u00f3tico estimado foi L\u221e = %s e a taxa de ",
                            "crescimento *k* = %s por unidade de idade (t\u2080 = %s)."),
                     fmt(unname(p["Linf"]), 2), fmt(unname(p["k"]), 4), fmt(unname(p["t0"]), 4))
  } else if (r$tipo == "logistico") {
    extra <- sprintf(paste0(" O valor assint\u00f3tico estimado foi L\u221e = %s, com taxa *k* = %s ",
                            "e ponto de inflex\u00e3o em t = %s."),
                     fmt(unname(p["Linf"]), 2), fmt(unname(p["k"]), 4), fmt(unname(p["tm"]), 4))
  } else if (r$tipo == "exponencial") {
    extra <- sprintf(" O coeficiente de crescimento estimado foi *b* = %s (com intercepto *a* = %s).",
                     fmt(unname(p["b"]), 4), fmt(unname(p["a"]), 4))
  } else if (r$tipo == "polinomial") {
    b1 <- unname(p["b1"])
    b2 <- unname(p["b2"])
    x_otimo <- -b1 / (2 * b2)
    otimo_txt <- if (b2 < 0) "ponto de m\u00e1ximo" else "ponto de m\u00ednimo"
    extra <- sprintf(" O modelo quadr\u00e1tico apresentou os coeficientes b1 = %s e b2 = %s, indicando um %s em X = %s.",
                     fmt(b1, 4), fmt(b2, 4), otimo_txt, fmt(x_otimo, 4))
  } else if (r$tipo == "logaritmica") {
    extra <- sprintf(" O coeficiente associado ao logaritmo foi *b* = %s (com intercepto *a* = %s).",
                     fmt(unname(p["b"]), 4), fmt(unname(p["a"]), 4))
  } else {
    extra <- ""
  }
  paste0(base, extra)
}
