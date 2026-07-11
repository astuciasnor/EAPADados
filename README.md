
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

Instale a versão atual direto do GitHub:

``` r
if (!requireNamespace("remotes", quietly = TRUE)) install.packages("remotes")
remotes::install_github("astuciasnor/EAPADados")

library(EAPADados)
head(tilapia_crescimento)
```

O EAPADados é 100% R (só dados e funções), mas ele usa `flextable` e
`dplyr`, que têm dependências com código compilado. Por isso:

**Windows** — instala direto: as dependências vêm como **binário do
CRAN** (não precisam compilar). Funciona com ou sem Rtools; com o Rtools
instalado, também.

**Linux** — as dependências **compilam da fonte**. O caminho mais fácil
é usar os binários do Posit Package Manager (sem compilar, sem
bibliotecas de sistema) — troque o codinome da distro (`jammy`, `noble`,
`bookworm`…):

``` r
options(repos = c(CRAN = "https://packagemanager.posit.co/cran/__linux__/jammy/latest"))
if (!requireNamespace("remotes", quietly = TRUE)) install.packages("remotes")
remotes::install_github("astuciasnor/EAPADados")
```

Alternativamente, para compilar da fonte, instale antes as bibliotecas
de sistema (Debian/Ubuntu):

``` bash
sudo apt-get install -y build-essential libfontconfig1-dev libfreetype6-dev \
  libharfbuzz-dev libfribidi-dev libpng-dev libtiff5-dev libjpeg-dev libcairo2-dev
```

## Exemplo de Uso

A seguir, vamos visualizar a taxa média de crescimento diário das
artemias por tipo de ração, usando um gráfico de barras elegante com
ggplot2:

<img src="man/figures/README-example-1.png" alt="" width="80%" />
