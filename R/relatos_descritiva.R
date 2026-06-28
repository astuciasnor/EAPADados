# =============================================================================
# relatos_descritiva.R
# -----------------------------------------------------------------------------
# Motor de relato e estatística descritiva (global ou agrupada) para o
# ecossistema EAPA.
#
# calcular_descr() -> realiza os cálculos estatísticos brutos das variáveis.
# mostrar_descr()  -> formata os resultados estruturados em uma tabela (tibble).
# relatar_descr()  -> gera uma descrição narrativa estruturada em português.
# =============================================================================

#' Cálculo canônico de estatísticas descritivas
#'
#' Calcula as estatísticas descritivas (N, NAs, Média, Mediana, Desvio Padrão,
#' Variância, Mínimo, Máximo, Q25 e Q75) para um conjunto de variáveis numéricas,
#' globalmente ou agrupadas por um fator.
#'
#' @param dados data.frame/tibble com as variáveis.
#' @param vars vetor de caracteres contendo os nomes das variáveis numéricas.
#' @param grupo nome da variável categórica para agrupamento (padrão "none").
#' @return Uma lista contendo as variáveis selecionadas, o grupo e um tibble
#'   de resultados com os cálculos numéricos brutos.
#' @export
calcular_descr <- function(dados, vars, grupo = "none") {
  if (is.null(grupo) || grupo == "none") {
    res <- do.call(rbind, lapply(vars, function(v) {
      x <- dados[[v]]
      val_x <- x[!is.na(x)]
      
      if (length(val_x) == 0) {
        mean_val <- NA_real_; med_val <- NA_real_; sd_val <- NA_real_; var_val <- NA_real_
        min_val <- NA_real_; max_val <- NA_real_; q25_val <- NA_real_; q75_val <- NA_real_
      } else {
        mean_val <- mean(x, na.rm = TRUE)
        med_val <- stats::median(x, na.rm = TRUE)
        sd_val <- stats::sd(x, na.rm = TRUE)
        var_val <- stats::var(x, na.rm = TRUE)
        min_val <- min(x, na.rm = TRUE)
        max_val <- max(x, na.rm = TRUE)
        q25_val <- unname(stats::quantile(x, 0.25, na.rm = TRUE))
        q75_val <- unname(stats::quantile(x, 0.75, na.rm = TRUE))
      }
      
      tibble::tibble(
        Variavel      = v,
        Grupo         = NA_character_,
        N             = sum(!is.na(x)),
        NAs           = sum(is.na(x)),
        Media         = mean_val,
        Mediana       = med_val,
        Desvio_Padrao = sd_val,
        Variancia     = var_val,
        Minimo        = min_val,
        Maximo        = max_val,
        Q25           = q25_val,
        Q75           = q75_val
      )
    }))
  } else {
    g_factor <- as.factor(dados[[grupo]])
    levels_g <- levels(g_factor)
    
    res <- do.call(rbind, lapply(vars, function(v) {
      x <- dados[[v]]
      do.call(rbind, lapply(levels_g, function(lvl) {
        x_g <- x[g_factor == lvl]
        val_x <- x_g[!is.na(x_g)]
        
        if (length(val_x) == 0) {
          mean_val <- NA_real_; med_val <- NA_real_; sd_val <- NA_real_; var_val <- NA_real_
          min_val <- NA_real_; max_val <- NA_real_; q25_val <- NA_real_; q75_val <- NA_real_
        } else {
          mean_val <- mean(x_g, na.rm = TRUE)
          med_val <- stats::median(x_g, na.rm = TRUE)
          sd_val <- stats::sd(x_g, na.rm = TRUE)
          var_val <- stats::var(x_g, na.rm = TRUE)
          min_val <- min(x_g, na.rm = TRUE)
          max_val <- max(x_g, na.rm = TRUE)
          q25_val <- unname(stats::quantile(x_g, 0.25, na.rm = TRUE))
          q75_val <- unname(stats::quantile(x_g, 0.75, na.rm = TRUE))
        }
        
        tibble::tibble(
          Variavel      = v,
          Grupo         = lvl,
          N             = sum(!is.na(x_g)),
          NAs           = sum(is.na(x_g)),
          Media         = mean_val,
          Mediana       = med_val,
          Desvio_Padrao = sd_val,
          Variancia     = var_val,
          Minimo        = min_val,
          Maximo        = max_val,
          Q25           = q25_val,
          Q75           = q75_val
        )
      }))
    }))
  }
  
  list(
    vars = vars,
    grupo = grupo,
    resultados = res
  )
}

#' Tabela de estatísticas descritivas formatada
#'
#' Formata o resultado de \code{calcular_descr} em uma tabela estruturada (tibble)
#' pronta para visualização. Suporta compatibilidade retroativa passando o data.frame diretamente.
#'
#' @param r lista retornada por \code{calcular_descr} ou um data.frame contendo os dados brutos.
#' @param vars vetor de caracteres contendo os nomes das variáveis (usado apenas se \code{r} for data.frame).
#' @param grupo nome da variável categórica de agrupamento (usado apenas se \code{r} for data.frame).
#' @return Um tibble contendo as estatísticas descritivas com colunas formatadas e arredondadas.
#' @export
mostrar_descr <- function(r, vars = NULL, grupo = "none") {
  if (!is.list(r) || is.data.frame(r) || is.null(r$resultados)) {
    r <- calcular_descr(r, vars, grupo)
  }
  
  df <- r$resultados
  
  if (is.null(r$grupo) || r$grupo == "none") {
    tab <- tibble::tibble(
      "Vari\u00e1vel"      = df$Variavel,
      "N"             = df$N,
      "NAs"           = df$NAs,
      "M\u00e9dia"         = round(df$Media, 2),
      "Mediana"       = round(df$Mediana, 2),
      "Desvio Padr\u00e3o" = round(df$Desvio_Padrao, 2),
      "Vari\u00e2ncia"     = round(df$Variancia, 2),
      "M\u00ednimo"        = round(df$Minimo, 2),
      "M\u00e1ximo"        = round(df$Maximo, 2),
      "Q25"           = round(df$Q25, 2),
      "Q75"           = round(df$Q75, 2)
    )
  } else {
    tab <- tibble::tibble(
      "Vari\u00e1vel"      = df$Variavel,
      "Grupo"         = df$Grupo,
      "N"             = df$N,
      "NAs"           = df$NAs,
      "M\u00e9dia"         = round(df$Media, 2),
      "Mediana"       = round(df$Mediana, 2),
      "Desvio Padr\u00e3o" = round(df$Desvio_Padrao, 2),
      "Vari\u00e2ncia"     = round(df$Variancia, 2),
      "M\u00ednimo"        = round(df$Minimo, 2),
      "M\u00e1ximo"        = round(df$Maximo, 2),
      "Q25"           = round(df$Q25, 2),
      "Q75"           = round(df$Q75, 2)
    )
  }
  tab
}

#' Relato textual descritivo automatizado
#'
#' Gera um texto em português descrevendo as estatísticas resumo das variáveis.
#' Suporta compatibilidade retroativa passando o data.frame diretamente.
#'
#' @param r lista retornada por \code{calcular_descr} ou um data.frame contendo os dados brutos.
#' @param vars vetor de caracteres contendo os nomes das variáveis (usado apenas se \code{r} for data.frame).
#' @param grupo nome da variável categórica de agrupamento (usado apenas se \code{r} for data.frame).
#' @return Uma string de texto em português.
#' @export
relatar_descr <- function(r, vars = NULL, grupo = "none") {
  if (!is.list(r) || is.data.frame(r) || is.null(r$resultados)) {
    r <- calcular_descr(r, vars, grupo)
  }
  
  df <- r$resultados
  res_text <- c()
  
  if (is.null(r$grupo) || r$grupo == "none") {
    res_text <- c(res_text, "A an\u00e1lise descritiva global das vari\u00e1veis selecionadas revelou os seguintes padr\u00f5es:")
    for (i in seq_len(nrow(df))) {
      v <- df$Variavel[i]
      n <- df$N[i]
      m <- df$Media[i]
      s <- df$Desvio_Padrao[i]
      med <- df$Mediana[i]
      min_v <- df$Minimo[i]
      max_v <- df$Maximo[i]
      
      res_text <- c(res_text, sprintf(
        "A vari\u00e1vel **%s** (N = %d) apresentou uma m\u00e9dia amostral de %s (desvio padr\u00e3o = %s) e mediana de %s, com valores variando entre um m\u00ednimo de %s e um m\u00e1ximo de %s.",
        v, n, fmt(m, 2), fmt(s, 2), fmt(med, 2), fmt(min_v, 2), fmt(max_v, 2)
      ))
    }
  } else {
    res_text <- c(res_text, sprintf("A an\u00e1lise descritiva agrupada pela vari\u00e1vel de agrupamento **%s** revelou os seguintes resultados:", r$grupo))
    
    unique_vars <- unique(df$Variavel)
    for (v in unique_vars) {
      res_text <- c(res_text, sprintf("Para a vari\u00e1vel **%s**:", v))
      df_sub <- df[df$Variavel == v, ]
      for (i in seq_len(nrow(df_sub))) {
        lvl <- df_sub$Grupo[i]
        n <- df_sub$N[i]
        m <- df_sub$Media[i]
        s <- df_sub$Desvio_Padrao[i]
        med <- df_sub$Mediana[i]
        
        res_text <- c(res_text, sprintf(
          "- No grupo **%s** (N = %d), a m\u00e9dia foi de %s (desvio padr\u00e3o = %s) e a mediana foi de %s.",
          lvl, n, fmt(m, 2), fmt(s, 2), fmt(med, 2)
        ))
      }
    }
  }
  paste(res_text, collapse = "\n\n")
}
