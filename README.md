
<!-- layout com imagem e descrição lado a lado -->

<div style="display: flex; align-items: center;">

<img src="man/figures/logo_pacote_eapadados.png" width="150" alt="Logo EAPADados"/>

<div style="margin-left: 20px; font-size: 1.2em; line-height: 1.4;">

    **EAPADados** disponibiliza conjuntos de dados didáticos para  
    **Estatística Aplicada à Pesca e Aquicultura** com R.  
    Cada dataset inclui documentação e exemplos de análise,  
    ideal para ensino e pesquisa aplicada.

</div>

</div>

<!-- README.md is generated from README.Rmd. Please edit that file -->

# EAPADados

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

This is a basic example which shows you how to solve a common problem:

``` r
library(EAPADados)
## basic example code
```
