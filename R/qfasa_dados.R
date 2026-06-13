#' Assinaturas de ácidos graxos de presas para estudos de dieta por QFASA
#'
#' Conjunto de dados derivado do objeto `preyFAs` do pacote `QFASA`.
#' Cada linha representa uma assinatura de ácidos graxos de uma presa,
#' com informações de identificação nas primeiras colunas e proporções
#' de ácidos graxos nas demais colunas.
#'
#' O conjunto é adequado para exercícios de análise exploratória multivariada,
#' incluindo Análise de Componentes Principais (PCA), Análise de Agrupamento
#' Hierárquico (AAH), estudo de dados composicionais e discussão sobre
#' assinaturas lipídicas em ecologia trófica.
#'
#' @format Um data frame com amostras de presas nas linhas e variáveis de
#' identificação e ácidos graxos nas colunas.
#'
#' @source Dados de exemplo do pacote `QFASA`.
#'
#' @references
#' Stewart, C., Iverson, S. J., Field, C., Bowen, W. D., & Budge, S. M.
#' QFASA: Quantitative Fatty Acid Signature Analysis.
#' Pacote R `QFASA`, disponível no CRAN.
#'
#' @examples
#' data(qfasa_presas)
#' head(qfasa_presas)
#'
#' # Exemplo simples para PCA, selecionando apenas colunas numéricas
#' dados_num <- qfasa_presas[sapply(qfasa_presas, is.numeric)]
#' pca <- prcomp(dados_num, scale. = TRUE)
#' summary(pca)
"qfasa_presas"


#' Assinaturas de ácidos graxos de predadores para estudos de dieta por QFASA
#'
#' Conjunto de dados derivado do objeto `predatorFAs` do pacote `QFASA`.
#' Cada linha representa uma assinatura de ácidos graxos de um predador,
#' com proporções de ácidos graxos em colunas.
#'
#' O conjunto pode ser usado para contextualizar estudos de dieta de predadores
#' por meio de assinaturas de ácidos graxos, em associação com dados de presas
#' e coeficientes de calibração.
#'
#' Para fins didáticos no EAPADados, este conjunto permite discutir a aplicação
#' ecológica da composição de ácidos graxos em organismos aquáticos e marinhos.
#'
#' @format Um data frame com assinaturas de predadores nas linhas e ácidos
#' graxos nas colunas.
#'
#' @source Dados de exemplo do pacote `QFASA`.
#'
#' @references
#' Stewart, C., Iverson, S. J., Field, C., Bowen, W. D., & Budge, S. M.
#' QFASA: Quantitative Fatty Acid Signature Analysis.
#' Pacote R `QFASA`, disponível no CRAN.
#'
#' @examples
#' data(qfasa_predadores)
#' head(qfasa_predadores)
"qfasa_predadores"


#' Lista de ácidos graxos usados nos dados de exemplo do QFASA
#'
#' Vetor de nomes dos ácidos graxos usados nos conjuntos `qfasa_presas`
#' e `qfasa_predadores`, derivado do objeto `FAset` do pacote `QFASA`.
#'
#' Este objeto é útil para selecionar apenas as colunas de ácidos graxos
#' nas análises multivariadas, evitando incluir colunas de identificação
#' ou metadados.
#'
#' @format Um vetor de caracteres com os nomes dos ácidos graxos.
#'
#' @source Dados de exemplo do pacote `QFASA`.
#'
#' @examples
#' data(qfasa_acidos_graxos)
#' qfasa_acidos_graxos
"qfasa_acidos_graxos"
