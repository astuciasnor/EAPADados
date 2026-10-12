#' Truta-do-lago: ácidos graxos sob sete dietas experimentais
#'
#' Perfis de ácidos graxos de juvenis de Salvelinus namaycush, na semana 12
#' de um ensaio alimentar. Cada linha representa a média de um aquário,
#' a unidade experimental que recebeu a dieta; peixes são subamostras.
#'
#' @format Um data.frame com 21 linhas e 31 colunas:
#' \describe{
#'   \item{id_aquario}{Identificador original do aquário, como texto; unidade experimental.}
#'   \item{dieta}{Fator com sete dietas; nomes e composições descritos nos detalhes.}
#'   \item{semana}{Semana 12, final do ensaio; inteiro constante para identificar o recorte.}
#'   \item{n_peixes}{Número de peixes analisados no aquário, de 1 a 4; subamostras, não UEs adicionais.}
#'   \item{c12_0_pct}{Média de C12:0, em porcentagem dos ácidos graxos quantificados no corpo inteiro dos peixes.}
#'   \item{c14_0_pct}{Média de C14:0, em porcentagem dos ácidos graxos quantificados no corpo inteiro dos peixes.}
#'   \item{c15_0_pct}{Média de C15:0, em porcentagem dos ácidos graxos quantificados no corpo inteiro dos peixes.}
#'   \item{c16_0_pct}{Média de C16:0, em porcentagem dos ácidos graxos quantificados no corpo inteiro dos peixes.}
#'   \item{c16_1n9_pct}{Média de C16:1n-9, em porcentagem dos ácidos graxos quantificados no corpo inteiro dos peixes.}
#'   \item{c16_1n7_pct}{Média de C16:1n-7, em porcentagem dos ácidos graxos quantificados no corpo inteiro dos peixes.}
#'   \item{c17_0_pct}{Média de C17:0, em porcentagem dos ácidos graxos quantificados no corpo inteiro dos peixes.}
#'   \item{c17_1_pct}{Média de C17:1, em porcentagem dos ácidos graxos quantificados no corpo inteiro dos peixes.}
#'   \item{c18_0_pct}{Média de C18:0, em porcentagem dos ácidos graxos quantificados no corpo inteiro dos peixes.}
#'   \item{c18_1n9_pct}{Média de C18:1n-9, em porcentagem dos ácidos graxos quantificados no corpo inteiro dos peixes.}
#'   \item{c18_1n7_pct}{Média de C18:1n-7, em porcentagem dos ácidos graxos quantificados no corpo inteiro dos peixes.}
#'   \item{c18_2n6_pct}{Média de C18:2n-6, em porcentagem dos ácidos graxos quantificados no corpo inteiro dos peixes.}
#'   \item{c18_3n3_pct}{Média de C18:3n-3, em porcentagem dos ácidos graxos quantificados no corpo inteiro dos peixes.}
#'   \item{c18_4n3_pct}{Média de C18:4n-3, em porcentagem dos ácidos graxos quantificados no corpo inteiro dos peixes.}
#'   \item{c20_0_pct}{Média de C20:0, em porcentagem dos ácidos graxos quantificados no corpo inteiro dos peixes.}
#'   \item{c20_1_pct}{Média de C20:1, em porcentagem dos ácidos graxos quantificados no corpo inteiro dos peixes.}
#'   \item{c20_2n6_pct}{Média de C20:2n-6, em porcentagem dos ácidos graxos quantificados no corpo inteiro dos peixes.}
#'   \item{c20_3n6_pct}{Média de C20:3n-6, em porcentagem dos ácidos graxos quantificados no corpo inteiro dos peixes.}
#'   \item{c20_4n6_pct}{Média de C20:4n-6, em porcentagem dos ácidos graxos quantificados no corpo inteiro dos peixes.}
#'   \item{c20_3n3_pct}{Média de C20:3n-3, em porcentagem dos ácidos graxos quantificados no corpo inteiro dos peixes.}
#'   \item{c20_4n3_pct}{Média de C20:4n-3, em porcentagem dos ácidos graxos quantificados no corpo inteiro dos peixes.}
#'   \item{c20_5n3_pct}{Média de C20:5n-3 (EPA), em porcentagem dos ácidos graxos quantificados no corpo inteiro dos peixes.}
#'   \item{c22_0_pct}{Média de C22:0, em porcentagem dos ácidos graxos quantificados no corpo inteiro dos peixes.}
#'   \item{c22_4n6_pct}{Média de C22:4n-6, em porcentagem dos ácidos graxos quantificados no corpo inteiro dos peixes.}
#'   \item{c22_5n6_pct}{Média de C22:5n-6, em porcentagem dos ácidos graxos quantificados no corpo inteiro dos peixes.}
#'   \item{c22_5n3_pct}{Média de C22:5n-3 (DPA n-3), em porcentagem dos ácidos graxos quantificados no corpo inteiro dos peixes.}
#'   \item{c22_6n3_pct}{Média de C22:6n-3 (DHA), em porcentagem dos ácidos graxos quantificados no corpo inteiro dos peixes.}
#' }
#'
#' @details
#' Sete dietas foram sorteadas entre 21 aquários, três por dieta. As dietas
#' são quironomideos (B), dafnias (D), camaroes (S), quironomideos_dafnias
#' (B:D), quironomideos_camaroes (B:S), dafnias_camaroes (S:D) e tres_presas
#' (B:S:D). As misturas de duas presas têm proporção 1:1 e a de três, 1:1:1,
#' em massa seca. B designa larvas de Chironomus spp.; D, Daphnia spp.;
#' S, Palaemonetes spp. As presas foram moídas e peletizadas.
#'
#' A fonte contém 236 perfis: 21 amostras de dietas, 30 peixes iniciais e 185
#' peixes tratados. Esta adaptação seleciona os 60 peixes da semana 12 e
#' calcula as médias aritméticas dos 27 ácidos por aquário. Não houve
#' exclusão de amostras, imputação ou renormalização. O valor extremo de
#' C20:3n-3 em TL10884v foi mantido na média do aquário 39.
#'
#' A sobrevivência foi baixa e desigual; os perfis finais descrevem os
#' sobreviventes. Há somente três UEs por dieta. A análise de porcentagens
#' requer atenção à natureza composicional. Para PCA, selecionar somente
#' os 27 ácidos (colunas terminadas em _pct), nunca semana, n_peixes ou ID.
#' Uma PCA padronizada deste recorte representa 46,53 e 21,74 por cento
#' da variância nos dois primeiros componentes, respectivamente.
#'
#' @source
#' Happel, A.; Pike, J.; Rinchard, J.; Czesny, S. (2021). Testing Fatty Acid
#' Based Diet Estimation Models using Diets Composed of Natural Prey Items.
#' Mendeley Data, versão 2. DOI: 10.17632/n6nmfpkpc5.2.
#' https://data.mendeley.com/datasets/n6nmfpkpc5/2
#' Dados sob CC BY 4.0: https://creativecommons.org/licenses/by/4.0/ .
#' Adaptação didática EAPA: recorte da semana 12, médias por aquário,
#' tradução das dietas e padronização dos nomes de variáveis.
#'
#' @examples
#' data(truta_acidos_graxos)
#' acidos <- grep("_pct$", names(truta_acidos_graxos), value = TRUE)
#' pca <- prcomp(truta_acidos_graxos[acidos], scale. = TRUE)
#' summary(pca)
#'
#' @docType data
#' @keywords datasets
"truta_acidos_graxos"
