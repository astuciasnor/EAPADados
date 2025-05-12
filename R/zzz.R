#' Garanta o carregamento dos datasets na namespace
#'
#' @noRd
#' @importFrom utils data
.onLoad <- function(libname, pkgname) {
  data(
    list    = c(
      "captura_petrechos",
      "morfometria_caranguejos",
      "tilapia_crescimento"
    ),
    package = pkgname,
    envir   = asNamespace(pkgname)
  )
}
