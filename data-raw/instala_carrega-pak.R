# Função enxuta para instalar (se necessário) e carregar pacotes
garantir_pacotes <- function(pacotes) {
  for (pacote_nome_str in pacotes) {
    # Tenta carregar o pacote silenciosamente
    if (!require(pacote_nome_str, character.only = TRUE, quietly = TRUE)) {
      # Se não conseguir carregar, instala
      message(paste("Instalando pacote:", pacote_nome_str))
      install.packages(pacote_nome_str, dependencies = TRUE)
      # Tenta carregar novamente após a instalação
      if (!require(pacote_nome_str, character.only = TRUE, quietly = TRUE)) {
        # Se ainda não conseguir carregar, para com erro
        stop(paste("Falha ao instalar ou carregar o pacote:", pacote_nome_str), call. = FALSE)
      }
      message(paste("Pacote", pacote_nome_str, "instalado e carregado."))
    } else {
      # Se já estava instalado e carregou com sucesso na primeira tentativa
      message(paste("Pacote", pacote_nome_str, "ja esta disponivel e carregado."))
    }
  }
  invisible(TRUE) # Retorna TRUE invisivelmente se tudo correu bem
}
