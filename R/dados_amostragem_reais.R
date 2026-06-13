#' Dados biológicos de Walleye do Lago Erie
#'
#' Conjunto de dados real com informações biológicas de Walleye
#' (*Sander vitreus*) coletados no Lago Erie entre 2003 e 2014.
#' A base foi preparada para fins didáticos em amostragem aleatória
#' simples e amostragem estratificada proporcional.
#'
#' @format Um data frame com variáveis em português:
#' \describe{
#'   \item{id_peixe}{Identificador sequencial do peixe.}
#'   \item{id_lance_rede}{Identificador do lance ou conjunto de rede.}
#'   \item{codigo_local}{Código original do local regional.}
#'   \item{local_regional}{Descrição regional do local de coleta.}
#'   \item{grade_amostral}{Grade amostral de coleta.}
#'   \item{ano}{Ano de coleta.}
#'   \item{comprimento_total_mm}{Comprimento total, em milímetros.}
#'   \item{peso_g}{Peso corporal, em gramas.}
#'   \item{sexo}{Sexo do peixe.}
#'   \item{maturidade}{Condição de maturidade.}
#'   \item{idade_anos}{Idade estimada, em anos.}
#'   \item{classe_comprimento}{Classe de comprimento criada por quartis.}
#' }
#'
#' @source FSAdata::WalleyeErie2. Título original: "Biological data for Walleye from Lake Erie, 2003-2014."
"walleye_erie"

#' Dados de idade e comprimento de Snapper
#'
#' Conjunto de dados real preparado a partir de FSAdata::SnapperHG1,
#' contendo registros de Snapper (*Pagrus auratus*) com idade atribuída
#' por otólitos e comprimento medido. Por padrão, foram mantidos apenas
#' os registros com idade atribuída, evitando os registros sem idade que
#' a documentação informa terem sido recriados a partir de tabela.
#'
#' @format Um data frame com variáveis em português:
#' \describe{
#'   \item{id_peixe}{Identificador sequencial do peixe.}
#'   \item{levantamento}{Código do levantamento/local de amostragem.}
#'   \item{comprimento_cm}{Comprimento medido, em centímetros.}
#'   \item{idade_anos}{Idade atribuída por otólitos, em anos.}
#'   \item{tem_idade_atribuida}{Indica se o registro possui idade atribuída.}
#'   \item{classe_comprimento}{Classe de comprimento criada por quartis.}
#' }
#'
#' @source FSAdata::SnapperHG1. Título original: "Age (subsample) and length (all fish) of Snapper from two survey locations."
#' Davies, N.M. and C. Walsh. 2002. "Snapper age and length samples from Kaharoa research trawl surveys KAH8810 and KAH0012 of the Hauraki Gulf."
"snapper_hg"

#' Medidas morfométricas de caranguejos Leptograpsus
#'
#' Conjunto de dados real com medidas morfométricas de caranguejos
#' *Leptograpsus variegatus*, preparado com nomes de variáveis em
#' português para uso didático em amostragem aleatória simples e
#' amostragem estratificada proporcional.
#'
#' @format Um data frame com variáveis em português:
#' \describe{
#'   \item{id_caranguejo}{Identificador sequencial do caranguejo.}
#'   \item{forma_cor}{Forma de cor: azul ou laranja.}
#'   \item{sexo}{Sexo do caranguejo.}
#'   \item{indice_no_grupo}{Índice dentro de cada grupo original.}
#'   \item{largura_lobo_frontal_mm}{Largura do lobo frontal, em milímetros.}
#'   \item{largura_posterior_mm}{Largura posterior, em milímetros.}
#'   \item{comprimento_carapaca_mm}{Comprimento da carapaça, em milímetros.}
#'   \item{largura_carapaca_mm}{Largura da carapaça, em milímetros.}
#'   \item{profundidade_corpo_mm}{Profundidade do corpo, em milímetros.}
#'   \item{classe_largura_carapaca}{Classe de largura da carapaça criada por quartis.}
#' }
#'
#' @source MASS::crabs. Título original: "Morphological Measurements on Leptograpsus Crabs."
#' Venables, W. N. and Ripley, B. D. (2002). "Modern Applied Statistics with S." Fourth edition. Springer.
"crabs_morfometria"
