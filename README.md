
<div style="display:flex;align-items:center;margin-bottom:1em">

<img src="man/figures/logo_pacote_eapadados.png" width="120" alt="Logo EAPADados"/>
<p style="margin-left:1em;font-size:1.2em;line-height:1.4;">

<strong>EAPADados</strong> disponibiliza conjuntos de dados didáticos
para <strong>Estatística Aplicada à Pesca e Aquicultura</strong> em R.
Cada dataset vem com documentação e exemplos prontos, ideal para aulas,
relatórios técnicos e pesquisa aplicada.
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

# No console R (substitua pela URL correta):
install.packages("https://github.com/astuciasnor/EAPADados/releases/download/v0.1.1/EAPADados_0.1.1.zip",
                 repos = NULL,
                 type = "win.binary")

library(EAPADados)
head(tilapia_crescimento)
```

## Exemplo de Uso

A seguir, vamos visualizar a taxa média de crescimento diário das
artemias por tipo de ração, usando um gráfico de barras elegante com
ggplot2:

    #> 
    #> Anexando pacote: 'dplyr'
    #> Os seguintes objetos são mascarados por 'package:stats':
    #> 
    #>     filter, lag
    #> Os seguintes objetos são mascarados por 'package:base':
    #> 
    #>     intersect, setdiff, setequal, union

<img src="man/figures/README-example-1.png" width="100%" />
