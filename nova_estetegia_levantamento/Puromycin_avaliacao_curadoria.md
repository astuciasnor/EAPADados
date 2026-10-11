# Puromycin: registro de candidatura

Arquivo fornecido pelo professor: `Puromycin_documentado.xlsx`. Conferido em 10/10/2026, preservado integralmente. Contém os 23 registros distribuídos no R e uma aba de documentação.

## Encaixe proposto

- **Uso principal: curva de saturação Michaelis-Menten**, `rate = Vmax * conc / (Km + conc)`. A documentação oficial do R exemplifica esse ajuste separadamente para as condições tratada e não tratada. Não é uma curva logística.
- **Uso complementar: modelo logarítmico**, `rate = a + b * ln(conc)`, como aproximação empírica no intervalo de 0,02 a 1,10 ppm e comparação entre formas de curva. O modelo logarítmico não tem assíntota horizontal e não representa o mecanismo de saturação. Não extrapolar.
- Conjunto elegível para curadoria. A busca ampla pode ser encerrada com este candidato para demonstrar o ajuste logarítmico; não o apresentar como evidência de que a relação biológica verdadeira seja logarítmica. Faltam a avaliação completa dos resíduos e a aprovação do uso didático.
- A TRILHA oferece ajuste logarítmico no catálogo consultado. Saturação Michaelis-Menten é um uso adicional possível dos dados, sem implicar que esse modelo esteja implementado no menu atual.

## Conferência numérica do ajuste logarítmico

Mínimos quadrados por condição, com todas as linhas dessa condição. Verificação realizada sobre os valores da aba Dados, sem alterações. R² é descritivo e não confirma pressupostos ou independência.

| Condição | Observações | Concentrações distintas | R² logarítmico |
|---|---:|---:|---:|
| treated | 12 | 6 | 0.9652 |
| untreated | 11 | 6 | 0.9613 |

## Limites e propostas para aprovação

O experimento foi realizado uma vez por condição, segundo a ajuda oficial. As medições na mesma concentração não devem ser chamadas de réplicas biológicas independentes; não há identificação de preparação/unidade biológica. O índice `rownames` não identifica uma unidade experimental. Há seis concentrações distintas em cada condição, abaixo da preferência inicial de dez; isso limita a avaliação da forma da curva, mas não impede a demonstração didática.

Nomes sugeridos, ainda não aplicados: `conc` → `concentracao_ppm`; `rate` → `velocidade_contagens_min2` (equivale a counts/min/min, confirmar a apresentação didática da unidade); `state` → `condicao`; níveis `treated` → `com_puromicina`, `untreated` → `sem_puromicina`. Propor retirar apenas `rownames` da futura versão de análise, preservando-o na cópia de origem. Nenhuma remoção, renomeação ou incorporação foi aplicada.

## Procedência

Treloar, M. A. (1974). Effects of Puromycin on Galactosyltransferase in Golgi Membranes. Dissertação de mestrado, University of Toronto. Também distribuído por Bates e Watts (1988), Nonlinear Regression Analysis and Its Applications, apêndice A1.3, e pelo pacote datasets do R.

Documentação oficial: https://stat.ethz.ch/R-manual/R-devel/library/datasets/html/Puromycin.html

O R é distribuído sob GPL-2 | GPL-3; a ajuda não declara uma licença CC separada para estas observações. Conferir os termos de redistribuição na incorporação. Documentar fonte, origem da cópia e todas as adaptações aprovadas.

SHA256 da planilha preservada: `825be8d7daa861988d9301c7e2fda62246b67bbee4ac43cb6bd0e2262e670d3e`.
