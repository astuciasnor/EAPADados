# =============================================================================
# relatos_anova.R
# -----------------------------------------------------------------------------
# Motor de relato da ANOVA unifatorial (Delineamento Inteiramente Casualizado)
# para o ecossistema EAPA. Migrado de catalyser/.../templates/funcoes_anova.R.
#
# calcular_anova()       -> ajusta o modelo aov, pressupostos e Tukey HSD;
#                           devolve UMA lista canonica com todas as estatisticas.
# mostrar_anova()        -> FORMATA a tabela ANOVA (tibble).
# mostrar_pressupostos() -> FORMATA Shapiro-Wilk (residuos) e Bartlett.
# mostrar_tukey()        -> FORMATA as comparacoes multiplas de Tukey HSD.
# relatar_anova()        -> FORMATA o relato em portugues (frase cientifica).
#
# As funcoes mostrar_/relatar_ consomem a lista devolvida por calcular_anova(),
# garantindo fonte unica de calculo. Reutilizam os utilitarios fmt() e
# flextable_ocean() ja definidos em relatos_teste_t.R (mesmo namespace).
# As strings de saida usam acentos escritos com escapes \uxxxx.
# =============================================================================

#' Cálculo canônico da ANOVA unifatorial (DIC)
#'
#' Ajusta uma ANOVA de um fator (\code{aov}), avalia os pressupostos
#' (normalidade dos resíduos por Shapiro-Wilk e homogeneidade de variâncias
#' por Bartlett) e executa o pós-teste de Tukey HSD. É a fonte única consumida
#' por \code{mostrar_anova}, \code{mostrar_pressupostos}, \code{mostrar_tukey}
#' e \code{relatar_anova}.
#'
#' @param df data.frame com os dados.
#' @param dep_var nome (string) da variável resposta (numérica).
#' @param ind_var nome (string) do fator (variável categórica).
#' @param conf nível de confiança dos intervalos de Tukey (padrão 0,95).
#' @return Uma lista com a tabela ANOVA, pressupostos, Tukey e estatísticas
#'   auxiliares (resíduos e valores ajustados para gráficos diagnósticos).
#' @encoding UTF-8
#' @export
#' @examples
#' data(isoproteica_bagre)
#' r <- calcular_anova(isoproteica_bagre, "peso_g", "racao")
#' r$f_anova; r$p_anova
calcular_anova <- function(df, dep_var, ind_var, conf = 0.95) {
  # Preparar variaveis
  y <- df[[dep_var]]
  x <- as.factor(df[[ind_var]])

  # Ajustar modelo aov
  fit <- stats::aov(y ~ x)
  anova_summary <- summary(fit)[[1]]

  # Tabela ANOVA estruturada
  anova_df <- data.frame(
    Fonte = c("Entre Grupos (Fator)", "Dentro dos Grupos (Resíduos)", "Total"),
    Df = c(anova_summary$Df[1], anova_summary$Df[2], sum(anova_summary$Df)),
    Soma_Quadrados = c(anova_summary$`Sum Sq`[1], anova_summary$`Sum Sq`[2],
                       sum(anova_summary$`Sum Sq`)),
    Quadrados_Medios = c(anova_summary$`Mean Sq`[1], anova_summary$`Mean Sq`[2], NA),
    F_valor = c(anova_summary$`F value`[1], NA, NA),
    p_valor = c(anova_summary$`Pr(>F)`[1], NA, NA),
    stringsAsFactors = FALSE
  )

  # Pressupostos
  # 1. Normalidade dos residuos (Shapiro-Wilk)
  residuos <- stats::residuals(fit)
  sh_test <- if (length(residuos) >= 3 && length(residuos) <= 5000)
    stats::shapiro.test(residuos) else list(statistic = NA, p.value = NA)

  # 2. Homocedasticidade (Bartlett)
  bt_test <- tryCatch(stats::bartlett.test(y ~ x),
                      error = function(e) list(statistic = NA, p.value = NA))

  # Pos-teste de Tukey HSD
  tukey_res <- stats::TukeyHSD(fit, conf.level = conf)
  tukey_data <- as.data.frame(tukey_res[[1]])
  tukey_df <- data.frame(
    Comparacao = rownames(tukey_data),
    Diferenca = tukey_data$diff,
    Lwr = tukey_data$lwr,
    Upr = tukey_data$upr,
    p_adj = tukey_data$`p adj`,
    Significativo = tukey_data$`p adj` < 0.05,
    stringsAsFactors = FALSE
  )

  list(
    dep_var = dep_var,
    ind_var = ind_var,
    conf = conf,
    anova_df = anova_df,
    sh_stat = unname(sh_test$statistic),
    sh_p = sh_test$p.value,
    bt_stat = unname(bt_test$statistic),
    bt_p = bt_test$p.value,
    tukey_df = tukey_df,
    p_anova = anova_summary$`Pr(>F)`[1],
    f_anova = anova_summary$`F value`[1],
    df_entre = anova_summary$Df[1],
    df_dentro = anova_summary$Df[2],
    residuals = residuos,
    fitted = stats::fitted(fit)
  )
}

#' Tabela de ANOVA formatada
#'
#' @param r lista devolvida por \code{calcular_anova}.
#' @return Um tibble com a tabela ANOVA (fonte, gl, SQ, QM, F, p).
#' @encoding UTF-8
#' @export
mostrar_anova <- function(r) {
  tibble::tibble(
    "Fonte de Variação" = r$anova_df$Fonte,
    "Graus de Liberdade (gl)" = r$anova_df$Df,
    "Soma dos Quadrados (SQ)" = round(r$anova_df$Soma_Quadrados, 2),
    "Quadrado Médio (QM)" = sapply(r$anova_df$Quadrados_Medios,
      function(x) if (is.na(x)) "-" else as.character(round(x, 2))),
    "F" = sapply(r$anova_df$F_valor,
      function(x) if (is.na(x)) "-" else as.character(round(x, 3))),
    "p-valor" = sapply(r$anova_df$p_valor,
      function(x) if (is.na(x)) "-" else as.character(round(x, 4)))
  )
}

#' Tabela de validação dos pressupostos da ANOVA
#'
#' @param r lista devolvida por \code{calcular_anova}.
#' @return Um tibble com os testes de Shapiro-Wilk e Bartlett.
#' @encoding UTF-8
#' @export
mostrar_pressupostos <- function(r) {
  tibble::tibble(
    "Pressuposto" = c("Normalidade dos Resíduos (Shapiro-Wilk)",
                      "Homocedasticidade das Variâncias (Bartlett)"),
    "Estatística de Teste" = c(round(r$sh_stat, 4), round(r$bt_stat, 3)),
    "p-valor" = c(round(r$sh_p, 4), round(r$bt_p, 4)),
    "Resultado" = c(
      ifelse(r$sh_p >= 0.05, "Resíduos Normais (H0 mantida)",
             "Resíduos Não Normais (H0 rejeitada)"),
      ifelse(r$bt_p >= 0.05, "Variâncias Homogêneas (H0 mantida)",
             "Variâncias Heterogêneas (H0 rejeitada)")
    )
  )
}

#' Tabela de comparações múltiplas de Tukey HSD
#'
#' @param r lista devolvida por \code{calcular_anova}.
#' @return Um tibble com as comparações par a par de Tukey HSD.
#' @encoding UTF-8
#' @export
mostrar_tukey <- function(r) {
  nivel <- round(r$conf * 100)
  tibble::tibble(
    "Comparação Par a Par" = r$tukey_df$Comparacao,
    "Diferença de Médias" = round(r$tukey_df$Diferenca, 2),
    "__LWR__" = round(r$tukey_df$Lwr, 2),
    "__UPR__" = round(r$tukey_df$Upr, 2),
    "p-valor ajustado" = round(r$tukey_df$p_adj, 4),
    "Significância (p < 0,05)" = ifelse(r$tukey_df$Significativo,
      "Diferença Significativa", "Não Significativa")
  ) -> tab
  names(tab)[names(tab) == "__LWR__"] <- paste0("IC ", nivel, "% Inferior")
  names(tab)[names(tab) == "__UPR__"] <- paste0("IC ", nivel, "% Superior")
  tab
}

#' Relato estatístico formal da ANOVA em português
#'
#' Sintetiza, em uma frase científica, o resultado da ANOVA, a validação dos
#' pressupostos e os pares significativos do pós-teste de Tukey HSD.
#'
#' @param r lista devolvida por \code{calcular_anova}.
#' @return Uma string com marcação Markdown (itálico) para o docx.
#' @encoding UTF-8
#' @export
relatar_anova <- function(r) {
  p_txt <- if (r$p_anova < 0.001) "p < 0,001" else paste0("p = ", fmt(r$p_anova, 3))

  sh_txt <- if (r$sh_p >= 0.05) "passou na validação de normalidade"
            else "apresentou desvio de normalidade"
  bt_txt <- if (r$bt_p >= 0.05) "passou na validação de homocedasticidade"
            else "apresentou desvio de homocedasticidade"

  relato_base <- paste0(
    "Foi realizada uma análise de variância (ANOVA) unifatorial para avaliar o efeito do fator categórico '",
    r$ind_var, "' sobre a variável numérica '", r$dep_var,
    "'. Os resíduos do modelo foram avaliados e o teste de Shapiro-Wilk (W = ",
    fmt(r$sh_stat, 4), ", p = ", fmt(r$sh_p, 4), ") ", sh_txt,
    ", enquanto o teste de Bartlett (K² = ", fmt(r$bt_stat, 3), ", p = ",
    fmt(r$bt_p, 4), ") ", bt_txt, ". "
  )

  if (r$p_anova < 0.05) {
    sig_pairs <- r$tukey_df$Comparacao[r$tukey_df$Significativo]
    sig_txt <- if (length(sig_pairs) > 0)
      paste0("O pós-teste de comparações múltiplas de Tukey HSD identificou diferenças significativas nos pares: ",
             paste(sig_pairs, collapse = "; "), ".")
    else
      "Contudo, o pós-teste de Tukey HSD não revelou pares com diferenças estatisticamente significativas."
    paste0(
      relato_base,
      "A ANOVA indicou um efeito estatisticamente significativo do fator sobre a resposta, F(",
      r$df_entre, ", ", r$df_dentro, ") = ", fmt(r$f_anova, 2), ", ", p_txt, ". ", sig_txt
    )
  } else {
    paste0(
      relato_base,
      "A ANOVA não indicou efeito estatisticamente significativo do fator sobre a resposta, F(",
      r$df_entre, ", ", r$df_dentro, ") = ", fmt(r$f_anova, 2), ", ", p_txt,
      ", não havendo justificativa estatística para a interpretação de pós-testes."
    )
  }
}
