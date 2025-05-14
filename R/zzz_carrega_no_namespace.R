#' Garanta o carregamento dos datasets na namespace
#' Caso queira que apareca o nome do dataset no namespace
#' Este arquivo nao gera arquivo .Rd
#'
#' @noRd
#' @importFrom utils data
.onLoad <- function(libname, pkgname) {
  data(
    list    = c(
      "captura_petrechos",
      "biometria_caranguejos",
      "tilapia_crescimento"
    ),
    package = pkgname,
    envir   = asNamespace(pkgname)
  )
}
