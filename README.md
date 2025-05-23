
<div style="display:flex;align-items:center;margin-bottom:1em">

<img src="man/figures/logo_pacote_eapadados.png" width="120" alt="Logo EAPADados"/>
<p style="margin-left:1em;font-size:1.2em;line-height:1.4;">

<strong>EAPADados</strong> disponibiliza conjuntos de dados didáticos
para o livro <strong>Estatística Aplicada à Pesca e Aquicultura com
R</strong>. Cada dataset vem com documentação e exemplos prontos, ideal
para aulas, relatórios técnicos e pesquisa aplicada.
</p>

</div>

<!-- README.md is generated from README.Rmd. Please edit that file -->

# EAPADados

[![CRAN
version](https://www.r-pkg.org/badges/version/EAPADados)](https://CRAN.R-project.org/package=EAPADados)
[![R-universe
build](https://astuciasnor.r-universe.dev/badges/EAPADados)](https://astuciasnor.r-universe.dev)

<!-- badges: start -->

<!-- badges: end -->

## Instalação

``` r

# Para Windows (binário .zip), rode no R/RStudio:
install.packages("https://github.com/astuciasnor/EAPADados/releases/download/v0.1.1/EAPADados_0.1.1.zip",
                 repos = NULL,
                 type = "win.binary")

library(EAPADados)
head(tilapia_crescimento)
```

``` r
# Para Linux e MacOS (fonte .tar.gz)

install.packages("https://github.com/astuciasnor/EAPADados/releases/download/v0.1.1/EAPADados_0.1.1.tar.gz",
                 repos = NULL,
                 type = "source")

library(EAPADados)
head(tilapia_crescimento)
```

## Exemplo de Uso

A seguir, vamos visualizar a taxa média de crescimento diário das
artemias por tipo de ração, usando um gráfico de barras elegante com
ggplot2:

<img src="man/figures/README-example-1.png" width="80%" />
