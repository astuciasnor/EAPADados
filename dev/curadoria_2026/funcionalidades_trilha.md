# Funcionalidades da TRILHA para orientar a curadoria

- Consulta ao menu e ao código local da TRILHA em 10/10/2026.
- Disponível significa conectado ao menu e com implementação identificada. Este levantamento não é uma homologação de todos os fluxos pela interface nem teste de todas as bases.
- Em preparação significa tela informativa/placeholder no fluxo atual. Código legado ou arquivo isolado não foi contado como funcionalidade disponível.
- Planejamento de DBC, DQL, parcelas subdivididas ou BACI não implica disponibilidade de um motor específico de análise para todo esse desenho.
- Diagnósticos, pós-testes, gráficos e exportações variam por módulo e por dependências instaladas. Não há garantia de que todos os módulos participem do Projeto R integrado.
- A planilha é uma referência de funcionalidades. As decisões sobre os conjuntos continuam exclusivamente em curadoria_eapadados_revisao.xlsx; nenhum dado foi alterado.
- A estrutura indicada orienta a busca de exemplos; não constitui aprovação para remover linhas, criar dados sintéticos, imputar, recodificar ou incorporar conjuntos.

## O que priorizar na escolha de conjuntos

| Necessidade | Recursos atendidos | Estrutura que deve estar presente |
|---|---|---|
| Pares e seguimento | t pareado, Wilcoxon, McNemar, Friedman e medidas repetidas | ID estável, ocasiões/condições e respostas correspondentes; binárias e contínuas. |
| Hierarquia amostral | ANOVA com subamostras | Tratamento, unidade experimental e subunidades reais; réplicas independentes identificadas. |
| Dois fatores e covariáveis | ANOVA de dois fatores e ANCOVA | Fatorial com replicação; ou grupos com covariável contínua e sobreposição de valores. |
| Eventos e esforço | Logística binária, Poisson e binomial negativa | Eventos reais 0/1; contagens inteiras com zeros, exposição e preditores; sobredispersão documentada. |
| Tempo e sazonalidade | Séries, decomposição e ACF | Datas regulares, pelo menos dois ciclos anuais mensais, lacunas e esforço documentados. |
| Múltiplas variáveis | PCA e HCA | Unidades × medidas numéricas; ou presença/ausência com orientação explícita. |
| Espaço | Pontos, bolhas e coroplético | Coordenadas verificadas com indicador; ou UF e indicador comparável por estado. |
| Cadastros e delineamentos | Amostragem e planejamento | Lista completa de unidades, estratos, conglomerados, blocos e níveis de casualização. |

## Planejamento observacional

| Recurso | Situação | O que faz | Dados necessários | Atenção na curadoria |
|---|---|---|---|---|
| Transversal comparativo | Disponível | Planeja a comparação de grupos preexistentes em um período. | Grupos; unidades independentes; resposta; possíveis subunidades. | Preservar grupo e unidade amostral; distinguir indivíduo de pool. |
| Longitudinal comparativo | Disponível | Planeja o acompanhamento das mesmas unidades ao longo do tempo. | Identificador estável; grupo; ocasião; resposta em formato longo. | Identificadores e ocasiões são indispensáveis; não tratar visitas como réplicas independentes. |
| Estudo de gradiente | Disponível | Organiza observações ao longo de um gradiente contínuo. | Estação/unidade; variável de gradiente; resposta; possíveis subunidades. | Manter gradiente contínuo e identidade de estação; não criar grupos arbitrários. |
| Estudos de impacto: BA, CI e BACI | Disponível | Planeja antes/depois, controle/impacto e a combinação BACI. | Local; condição; período; unidade; resposta; replicação espacial e temporal. | Buscar desenho real completo; o planejamento não garante um motor geral de análise BACI. |

## Planejamento e coleta

| Recurso | Situação | O que faz | Dados necessários | Atenção na curadoria |
|---|---|---|---|---|
| Monitoramento e séries temporais | Disponível | Organiza o plano de acompanhamento temporal. | Indicador; unidade; frequência; datas; locais de acompanhamento. | Manter periodicidade, lacunas e mudanças no esforço de observação. |
| Variáveis e ficha de coleta | Disponível | Define variáveis e organiza a estrutura da coleta nos fluxos de planejamento. | Nomes, tipos, unidades e unidade observacional. | A ficha deve preservar a hierarquia amostral e separar identificação de resposta. |

## Planejamento experimental

| Recurso | Situação | O que faz | Dados necessários | Atenção na curadoria |
|---|---|---|---|---|
| DIC — inteiramente casualizado | Disponível | Planeja e casualiza tratamentos entre unidades experimentais. | Tratamento; repetição; unidade experimental; resposta futura. | Réplicas são unidades experimentais, não medições dentro de um tanque. |
| DBC — blocos casualizados | Disponível | Planeja tratamentos controlando a variação entre blocos. | Bloco; tratamento; unidade experimental. | Preservar blocos; não confundir disponibilidade do planejamento com análise específica de DBC. |
| DQL — quadrado latino | Disponível | Planeja tratamentos com controle por linhas e colunas. | Linha; coluna; tratamento; unidade experimental. | Manter as duas restrições de casualização; análise específica não aparece como módulo próprio. |
| Fatorial em DIC | Disponível | Planeja combinações de fatores e repetições. | Fatores; combinações; unidades experimentais. | Preferir cruzamento completo; não inventar combinações ausentes. |
| Parcelas subdivididas | Disponível | Planeja fatores aplicados em parcelas e subparcelas. | Parcela; subparcela; fatores; resposta. | Exige dois níveis de unidade/erro; não é sinônimo de ANOVA com subamostras. |

## Dimensionamento amostral

| Recurso | Situação | O que faz | Dados necessários | Atenção na curadoria |
|---|---|---|---|---|
| Uma média: precisão | Disponível | Dimensiona n a partir de variabilidade, confiança e margem de erro. | Estimativa de desvio-padrão e precisão desejada; população finita opcional. | Um conjunto piloto com unidade e escala documentadas é útil. |
| Uma proporção: precisão | Disponível | Dimensiona n para estimar uma proporção. | Proporção esperada; confiança; margem; população finita opcional. | Documentar sucesso, denominador e população-alvo. |
| Comparação de médias: poder | Disponível | Dimensiona duas médias por teste t ou três ou mais por ANOVA. | Efeito esperado; variabilidade; alfa; poder; número de grupos. | Dados piloto devem permitir estimar efeito e variabilidade entre unidades. |
| Comparação de proporções: poder | Disponível | Dimensiona a comparação de duas proporções. | Proporções esperadas; alfa; poder. | Escolher exemplo com eventos e denominadores claros. |
| Correlação: poder | Disponível | Dimensiona n para detectar associação por correlação. | Correlação esperada; alfa; poder. | Usar pares de medidas de unidades independentes. |

## Seleção da amostra

| Recurso | Situação | O que faz | Dados necessários | Atenção na curadoria |
|---|---|---|---|---|
| Amostragem aleatória simples | Disponível | Sorteia unidades a partir de um cadastro, com semente. | Cadastro da população e identificador único. | Preservar o cadastro completo; resposta medida não é necessária. |
| Amostragem estratificada proporcional | Disponível | Distribui a amostra proporcionalmente entre estratos e sorteia unidades. | Identificador; estrato de cada unidade. | Não remover estratos raros sem avaliar a alocação. |
| Amostragem sistemática | Disponível | Seleciona unidades de uma lista ordenada com intervalo de seleção. | Cadastro ordenado; identificador; tamanho da amostra. | A ordem do cadastro faz parte do desenho. |
| Amostragem por conglomerados | Disponível | Sorteia conglomerados em um estágio ou unidades dentro deles em dois estágios. | Conglomerado; identificador das unidades; cadastro. | Manter vínculo unidade–conglomerado; não contar indivíduos como conglomerados. |

## Importação e organização

| Recurso | Situação | O que faz | Dados necessários | Atenção na curadoria |
|---|---|---|---|---|
| Importar CSV ou Excel | Disponível | Lê CSV, XLSX e XLS; permite selecionar planilha e convenções de separador/decimal. | Arquivo tabular com cabeçalhos e tipos reconhecíveis. | Boa base para mostrar decimal com vírgula, cabeçalhos e dados ausentes. |
| Abrir conjuntos do EAPADados | Disponível | Seleciona conjuntos do pacote para exploração e análise. | Objeto disponível no pacote instalado. | A disponibilidade no seletor depende da versão instalada. |
| Empilhar colunas | Disponível | Converte dados de formato largo para longo. | Identificadores e várias colunas de medidas/ocasiões. | Exemplo útil para medidas repetidas; preservar os identificadores. |
| Alargar planilha | Disponível | Converte formato longo para largo. | Chaves de identificação; coluna de nomes; coluna de valores. | Conferir unicidade das combinações de chaves. |
| Separar colunas | Disponível | Desmembra informação composta em colunas. | Coluna textual com separador ou padrão reconhecível. | Manter a correspondência com o registro original. |

## Tratamento dos dados

| Recurso | Situação | O que faz | Dados necessários | Atenção na curadoria |
|---|---|---|---|---|
| Organizar variáveis | Disponível | Seleciona, renomeia e ajusta tipos de variáveis na preparação. | Tabela com tipos e significados documentados. | Não descartar ID, bloco, unidade, tempo, esforço ou coordenadas por parecerem auxiliares. |
| Tratar valores ausentes | Disponível | Remove linhas ou imputa média, mediana, moda ou constante, conforme a opção. | Variável com NA e explicação de sua origem. | Imputação e exclusão não são limpezas neutras; dependem de aprovação na curadoria. |
| Remover duplicatas | Disponível | Mantém a primeira linha por combinação das colunas escolhidas. | Identificador ou chave que defina duplicação real. | Linhas iguais de indivíduos distintos não são duplicatas indevidas. |
| Padronizar texto | Disponível | Ajusta espaços e caixa: minúsculas, maiúsculas ou título. | Colunas textuais/categorias. | Conferir se rótulos distintos não serão fundidos inadvertidamente. |
| Filtrar linhas | Disponível | Recorta observações por condições numéricas ou categóricas. | Variável de filtro e critérios explícitos. | Registrar critério, n antes/depois e impacto na estrutura amostral. |
| Sortear subamostras | Disponível | Seleciona uma amostra de linhas, inclusive dentro de grupos. | Base com registros e grupos opcionais. | Não confundir sorteio didático com amostragem independente em dados hierárquicos. |
| Calcular variáveis | Disponível | Cria variáveis derivadas por expressões na receita de preparação. | Colunas necessárias ao cálculo. | Documentar fórmula, unidade e significado da nova variável. |
| Reescalar unidades | Disponível | Altera a escala de uma variável por conversão configurada. | Variável numérica; unidade original e unidade de destino. | Confirmar unidade original antes de converter ou renomear. |
| Padronizar valores numéricos | Disponível | Oferece z-score, centralização e escala min–max de 0 a 1. | Variáveis numéricas. | Preservar as medidas originais e explicar a escala derivada. |
| Criar classes | Disponível | Agrupa uma variável em intervalos de mesma largura ou por quantis. | Variável numérica. | Classes são derivadas; preservar a variável contínua. |
| Dicotomizar | Disponível | Cria 0/1 por limiar numérico ou seleção de categorias. | Variável numérica ou categórica. | Definir claramente o evento 1 e justificar o limiar. |
| Agrupar e sumarizar | Disponível | Produz resumos por combinações de grupos; encerra a receita dessa base. | Grupos; respostas numéricas; unidades identificadas. | Não substituir dados individuais por médias quando a análise precisa de réplicas. |
| Construir tabela de contingência | Disponível | Conta combinações categóricas e calcula percentuais por linha, coluna ou total. | Variáveis categóricas; unidades observacionais. | Conservar contagens; percentuais sozinhos não bastam para os testes. |

## Bases e reprodutibilidade

| Recurso | Situação | O que faz | Dados necessários | Atenção na curadoria |
|---|---|---|---|---|
| Base compartilhada e bases derivadas | Disponível | Mantém preparação comum e ramificações com receitas específicas de tratamento. | Uma base de origem e receitas ordenadas. | Derivações partem da base compartilhada; preservam contexto de preparação. |

## Exploração e gráficos

| Recurso | Situação | O que faz | Dados necessários | Atenção na curadoria |
|---|---|---|---|---|
| Panorama do conjunto | Disponível | Apresenta dimensões, tipos e ausências para conhecer a base. | Tabela numérica e/ou categórica. | Exemplo deve permitir discutir significado das linhas e dados ausentes. |
| Resumo das variáveis | Disponível | Apresenta estatísticas descritivas, distribuições e frequências. | Variáveis numéricas e categóricas. | Incluir unidades e níveis compreensíveis. |
| Relações entre variáveis | Disponível | Explora associações e comparações conforme os tipos das variáveis. | Pares de variáveis e grupos opcionais. | Associação exploratória não define causalidade. |
| Pressupostos e valores extremos | Disponível | Ajuda a avaliar normalidade, gráficos Q–Q e observações extremas. | Variáveis numéricas; resíduos nos módulos de modelos. | Não excluir valores extremos automaticamente. |
| Comparar transformações | Disponível | Compara original, log, raiz quadrada e Box–Cox quando admissíveis. | Variável numérica; positividade conforme a transformação. | Exploração não altera a base; zeros e valores negativos restringem opções. |
| Histograma e densidade | Disponível | Mostra a distribuição de uma variável numérica. | Variável numérica. | Escolher exemplos com formas de distribuição distintas. |
| Gráfico de barras | Disponível | Mostra frequências e comparações categóricas. | Variável categórica e agrupamento quando pertinente. | Preservar níveis e denominadores. |
| Comparar grupos graficamente | Disponível | Oferece boxplot, violino, pontos e resumos com média, IC e n. | Resposta numérica; grupo. | Informar se n representa indivíduos, tanques ou outra unidade. |
| Dispersão e tendência | Disponível | Mostra pares numéricos, com reta linear, suavização LOESS ou sem tendência. | Duas variáveis numéricas; grupo opcional. | Buscar gradientes, não linearidade e amplitude útil. |
| Linhas em eixo ordenado | Disponível | Conecta medidas ao longo de um eixo ordenado. | Eixo ordenado; resposta; série/grupo se houver. | Conservar ordem e espaçamento; não confundir com análise formal temporal. |
| Matriz de dispersão | Disponível | Compara visualmente vários pares de variáveis numéricas. | Várias variáveis numéricas nas mesmas unidades. | Útil para biometria e qualidade da água. |
| Mapa de calor de correlações | Disponível | Resume correlações entre variáveis em uma matriz colorida. | Várias variáveis numéricas. | Correlações exigem observações correspondentes. |

## Frequências e proporções

| Recurso | Situação | O que faz | Dados necessários | Atenção na curadoria |
|---|---|---|---|---|
| Uma proporção | Disponível | Teste binomial exato contra uma proporção de referência, com IC. | Resposta binária por unidade independente. | Informar evento de sucesso e hipótese de referência. |
| Duas proporções independentes | Disponível | Compara proporções de dois grupos por prop.test; a receita também inclui Fisher. | Resposta binária e grupo com dois níveis. | Pares, blocos e agrupamentos não são atendidos por este procedimento. |
| Qui-quadrado de aderência | Disponível | Compara frequências observadas com proporções esperadas especificadas. | Resposta categórica e hipótese de distribuição esperada. | A distribuição esperada precisa ter justificativa substantiva. |
| Qui-quadrado de independência | Disponível | Avalia associação em tabela de contingência. | Duas categorias por observação ou tabela longa com frequência n. | Não entregar apenas percentuais; conferir contagens esperadas. |
| McNemar | Disponível | Compara respostas binárias pareadas. | Duas respostas binárias do mesmo par/unidade. | Preservar correspondência antes/depois; buscar pares com mudanças em ambas as direções. |

## Testes paramétricos

| Recurso | Situação | O que faz | Dados necessários | Atenção na curadoria |
|---|---|---|---|---|
| Teste t: uma amostra | Disponível | Compara uma média com valor de referência. | Resposta numérica de unidades independentes. | Documentar a referência e a unidade da resposta. |
| Teste t: dois grupos independentes | Disponível | Compara duas médias; Welch ou Student com variâncias iguais. | Resposta numérica; grupo com dois níveis. | Não converter dados pareados em independentes. |
| Teste t pareado | Disponível | Compara duas medidas correspondentes. | Duas medidas numéricas por unidade/par. | ID e pareamento não podem se perder no recorte. |
| ANOVA de um fator | Disponível | Compara grupos; opção clássica/Tukey ou Welch/Games–Howell. | Resposta numérica; fator; réplicas independentes. | Médias, DP e n não substituem as observações para este fluxo. |
| ANOVA com subamostras | Disponível | Separa unidades e subunidades, com efeito aleatório da unidade; contrasta abordagens didáticas. | Tratamento; unidade experimental; subunidade; resposta. | Prioridade de curadoria: dados hierárquicos reais e documentação da unidade experimental. |
| ANOVA de medidas repetidas | Disponível | Compara momentos das mesmas unidades no fluxo de um fator temporal. | ID; momento; resposta em formato longo; grade completa. | Buscar seguimento real; não assumir suporte geral a desenhos longitudinais mistos. |
| ANOVA de dois fatores | Disponível | Estima efeitos de dois fatores e sua interação. | Dois fatores; resposta; réplicas nas combinações. | Preferir fatorial completo; verificar células vazias e controles externos ao fatorial. |
| ANCOVA | Disponível | Compara grupos ajustando por covariável numérica. | Fator; covariável contínua; resposta numérica. | Buscar sobreposição da covariável entre grupos e relação interpretável. |
| Uma variância: qui-quadrado | Disponível | Testa uma variância contra valor de referência. | Resposta numérica e variância de referência. | Referência deve usar a unidade ao quadrado; pressuposto de normalidade. |
| Duas variâncias: teste F | Disponível | Compara variâncias de dois grupos. | Resposta numérica; dois grupos independentes. | Exemplo deve permitir discutir sensibilidade à não normalidade. |

## Testes não paramétricos

| Recurso | Situação | O que faz | Dados necessários | Atenção na curadoria |
|---|---|---|---|---|
| Mann–Whitney | Disponível | Compara dois grupos independentes por postos. | Resposta numérica/ordenável; dois grupos. | Preservar observações individuais e empates. |
| Wilcoxon pareado | Disponível | Testa diferenças entre pares por postos sinalizados. | Duas medidas correspondentes por unidade. | Manter pares e diferenças nulas; não reordenar as colunas separadamente. |
| Kruskal–Wallis e Dunn | Disponível | Compara vários grupos independentes e oferece pós-teste de Dunn com ajustes. | Resposta ordenável; fator com três ou mais grupos. | Pós-teste depende dos pacotes auxiliares disponíveis. |
| Friedman | Disponível | Compara condições pareadas; comparações Wilcoxon com ajuste de Holm. | Unidade/bloco; condição; resposta; grade completa. | Prioridade: medidas repetidas reais sem perda de identificação. |

## Correlação e regressão

| Recurso | Situação | O que faz | Dados necessários | Atenção na curadoria |
|---|---|---|---|---|
| Correlação de Pearson, Spearman e Kendall | Disponível | Quantifica associação entre duas variáveis com alternativas paramétrica e por postos. | Duas variáveis correspondentes por unidade. | Incluir exemplos com empates, relação monotônica e valores extremos. |
| Regressão linear simples | Disponível | Ajusta resposta numérica por um preditor numérico e apresenta diagnósticos. | Resposta contínua; preditor numérico. | Priorizar amplitude do preditor e unidades independentes. |
| Regressão logística binária | Disponível | Modela probabilidade de resposta 0/1. | Resposta binária; preditor(es) admitidos pelo módulo. | Conferir sucesso/fracasso e evitar separação completa. |

## Modelos de contagem

| Recurso | Situação | O que faz | Dados necessários | Atenção na curadoria |
|---|---|---|---|---|
| Regressão de Poisson | Disponível | Modela contagens; permite múltiplos preditores e exposição positiva como offset. | Contagem inteira não negativa; preditores; esforço/exposição opcional. | Preservar zeros e esforço; CPUE contínua não substitui a contagem com offset. |
| Regressão binomial negativa | Disponível | Modela contagens com sobredispersão; aceita exposição como offset. | Contagem; preditores; exposição opcional. | Buscar sobredispersão real; não produzir contagens artificiais por arredondamento. |

## Curvas e crescimento

| Recurso | Situação | O que faz | Dados necessários | Atenção na curadoria |
|---|---|---|---|---|
| Descobrindo o modelo | Disponível | Apoia a exploração de formas de relação e escolha de curva. | Pares de variáveis numéricas. | Escolher exemplo com mecanismo e domínio conhecidos. |
| Modelo exponencial | Disponível | Ajusta Y = a × exp(bX). | X e Y numéricos; domínio apropriado. | Dados reais com amplitude suficiente para identificar a curvatura. |
| Modelo de potência / alometria | Disponível | Ajusta Y = a × X^b; inclui relação peso–comprimento. | Comprimento e peso, ou outro par positivo. | Confirmar unidades, espécies, estágios e possíveis grupos. |
| Crescimento de von Bertalanffy | Disponível | Ajusta curva de crescimento por idade/tempo. | Idade/tempo e tamanho; cobertura de idades. | Buscar medidas reais; poucos indivíduos jovens não identificam bem a assíntota. |
| Modelo logístico de crescimento | Disponível | Ajusta curva sigmoidal contínua. | Tempo e tamanho/biomassa com fases da curva. | É crescimento logístico, diferente da regressão logística de resposta binária. |
| Modelo polinomial quadrático | Disponível | Ajusta relação com termo de segundo grau. | X e Y numéricos. | Não extrapolar além do domínio observado. |
| Modelo logarítmico | Disponível | Ajusta Y = a + b × ln(X). | X positivo; Y numérico. | Não deslocar zeros arbitrariamente para permitir o ajuste. |

## Séries temporais

| Recurso | Situação | O que faz | Dados necessários | Atenção na curadoria |
|---|---|---|---|---|
| Visualizar e suavizar séries | Disponível | Mostra a evolução, agrega por médias mensais/anuais e aplica média móvel. | Data; resposta numérica; série identificada. | Conservar datas, lacunas, periodicidade e significado da agregação. |
| Decomposição aditiva | Disponível | Separa tendência, sazonalidade e resíduos de séries mensais. | Série mensal com pelo menos 24 meses. | O módulo usa interpolação temporária para lacunas; não altera a base original. |
| Autocorrelação — ACF | Disponível | Examina dependência entre observações defasadas. | Série temporal ordenada e espaçamento regular. | Evitar tratar as observações como unidades independentes; conferir tratamento das lacunas. |

## Análise multivariada

| Recurso | Situação | O que faz | Dados necessários | Atenção na curadoria |
|---|---|---|---|---|
| PCA — componentes principais | Disponível | Resume várias variáveis numéricas; padronização, componentes e biplots; opção de imputação. | Matriz de unidades × variáveis numéricas; grupo opcional. | Conferir escalas, ausências e unidade da linha; imputação via missMDA é opcional. |
| Agrupamento hierárquico — HCA | Disponível | Agrupa linhas; distâncias euclidiana, Manhattan e binária/Jaccard; ligações Ward, completa, simples e média. | Matriz numérica; presença/ausência para distância binária. | A orientação da matriz define quem é agrupado; Jaccard/binária não usa z-score. |

## Mapas

| Recurso | Situação | O que faz | Dados necessários | Atenção na curadoria |
|---|---|---|---|---|
| Mapa de pontos / onde amostrar | Disponível | Localiza estações e unidades por latitude/longitude. | Latitude; longitude; identificação do local. | Conferir datum, sinal e convenção de longitude; sorteio espacial ainda não é recurso disponível. |
| Mapa de bolhas proporcionais | Disponível | Representa magnitude por tamanho de bolha; permite grupos e rótulos. | Coordenadas e magnitude numérica não negativa. | Prioridade: dados reais georreferenciados com metadados e variável mapeável. |
| Mapa coroplético por UF | Disponível | Colore unidades federativas do Brasil por indicador. | UF reconhecível e valor por estado. | Compatibilizar códigos de UF e ano; evitar misturar total e taxa. |

## Laboratório de conceitos

| Recurso | Situação | O que faz | Dados necessários | Atenção na curadoria |
|---|---|---|---|---|
| Teorema do Limite Central: médias | Disponível | Simula distribuições de médias amostrais. | Parâmetros da simulação; não exige conjunto empírico. | Simulação didática interna não corresponde à incorporação de novo conjunto sintético. |
| Simuladores de teste t e ANOVA | Disponível | Exploram resultados por simulação nos painéis de testes. | Parâmetros de grupos, variabilidade e tamanho amostral. | Não exige novos conjuntos de dados para o pacote. |

## Comunicação dos resultados

| Recurso | Situação | O que faz | Dados necessários | Atenção na curadoria |
|---|---|---|---|---|
| Projeto R e relatório reproduzível | Disponível | Seleciona execuções integradas, organiza texto/componentes e exporta projeto ZIP com código e Quarto. | Análises registradas e suas bases/receitas. | Word e HTML são gerados ao renderizar no RStudio; nem todo módulo está integrado ao registro. |

## Recursos em preparação

| Recurso | Situação | O que faz | Dados necessários | Atenção na curadoria |
|---|---|---|---|---|
| Regressão linear múltipla | Em preparação | Entrada de menu ainda apresenta módulo em desenvolvimento. | Resposta numérica e múltiplos preditores, quando implementado. | Distinguir da regressão de contagem, que já aceita múltiplos preditores. |
| Previsão de séries temporais | Em preparação | Tela introdutória em preparação; não há fluxo de previsão pronto. | Série regular suficientemente longa, quando implementado. | Não escolher dados pressupondo ARIMA/ETS já disponíveis. |
| K-means | Em preparação | Entrada de menu em preparação. | Matriz numérica, quando implementado. | Pode ser atendido futuramente por dados já adequados à PCA/HCA. |
| PERMANOVA | Em preparação | Entrada de menu em preparação. | Matriz multivariada e desenho/grupos, quando implementado. | Conservar desenho amostral e matriz original para uso futuro. |
| Densidade de ocorrências | Em preparação | Tela de mapa em preparação; arquivo de módulo existente não equivale a integração ativa. | Ocorrências georreferenciadas, quando implementado. | Não classificar o recurso como operacional apenas por existir arquivo de código. |
| Dependência espacial | Em preparação | Tela em preparação. | Dados espaciais e definição de vizinhança, quando implementado. | Não há fluxo ativo de análise espacial nesse item. |
| Ambiente nos pontos | Em preparação | Tela em preparação. | Pontos e dados ambientais/raster, quando implementado. | Extração ambiental/raster não está disponível nesse fluxo de menu. |

## Laboratório em preparação

| Recurso | Situação | O que faz | Dados necessários | Atenção na curadoria |
|---|---|---|---|---|
| LLN, IC e TLC para proporções | Em preparação | Lei dos Grandes Números, cobertura de IC e TLC de proporções são telas em construção. | Simulações futuras. | Não exigem novos conjuntos empíricos. |
| Distribuições de probabilidade | Em preparação | Visualizadores Normal, binomial, Poisson, t, F e qui-quadrado estão em construção neste laboratório. | Parâmetros de distribuição. | Isto não impede o uso dessas distribuições nos testes já implementados. |
| P-valor, permutação, erros e poder | Em preparação | Visualizadores conceituais em construção. | Simulações futuras. | Dimensionamento amostral por poder já existe em outro módulo. |
| Simuladores qui-quadrado e correlação | Em preparação | Abas em construção; simuladores t e ANOVA já estão disponíveis. | Simulações futuras. | Testes reais de qui-quadrado e correlação já existem em outros menus. |
| Anscombe/Datasaurus, teste de fila e dispersão | Em preparação | Painéis conceituais de visualização em construção. | Exemplos pedagógicos futuros. | Não confundir presença no catálogo com ferramenta executável. |

## Fontes locais

A situação de cada recurso foi confrontada com o menu atual em [app.R](D:/Claude/EAPA-Ecossistema/TRILHA/inst/app/app.R). Os registros de tratamento e de execução ajudam a distinguir o que é calculado e o que entra no relatório integrado.

- [R/descrevendo_dados.R](D:/Claude/EAPA-Ecossistema/TRILHA/R/descrevendo_dados.R)
- [inst/app/app.R](D:/Claude/EAPA-Ecossistema/TRILHA/inst/app/app.R)
- [inst/app/modules/mod_bases_derivadas.R](D:/Claude/EAPA-Ecossistema/TRILHA/inst/app/modules/mod_bases_derivadas.R)
- [inst/app/modules/mod_comunicacao.R](D:/Claude/EAPA-Ecossistema/TRILHA/inst/app/modules/mod_comunicacao.R)
- [inst/app/modules/mod_correlacao.R](D:/Claude/EAPA-Ecossistema/TRILHA/inst/app/modules/mod_correlacao.R)
- [inst/app/modules/mod_descrevendo_dados.R](D:/Claude/EAPA-Ecossistema/TRILHA/inst/app/modules/mod_descrevendo_dados.R)
- [inst/app/modules/mod_experimental_design.R](D:/Claude/EAPA-Ecossistema/TRILHA/inst/app/modules/mod_experimental_design.R)
- [inst/app/modules/mod_hca.R](D:/Claude/EAPA-Ecossistema/TRILHA/inst/app/modules/mod_hca.R)
- [inst/app/modules/mod_laboratorio.R](D:/Claude/EAPA-Ecossistema/TRILHA/inst/app/modules/mod_laboratorio.R)
- [inst/app/modules/mod_mapa.R](D:/Claude/EAPA-Ecossistema/TRILHA/inst/app/modules/mod_mapa.R)
- [inst/app/modules/mod_mapa_pontos.R](D:/Claude/EAPA-Ecossistema/TRILHA/inst/app/modules/mod_mapa_pontos.R)
- [inst/app/modules/mod_monitoramento.R](D:/Claude/EAPA-Ecossistema/TRILHA/inst/app/modules/mod_monitoramento.R)
- [inst/app/modules/mod_n_poder.R](D:/Claude/EAPA-Ecossistema/TRILHA/inst/app/modules/mod_n_poder.R)
- [inst/app/modules/mod_nonlinear.R](D:/Claude/EAPA-Ecossistema/TRILHA/inst/app/modules/mod_nonlinear.R)
- [inst/app/modules/mod_nonparametric.R](D:/Claude/EAPA-Ecossistema/TRILHA/inst/app/modules/mod_nonparametric.R)
- [inst/app/modules/mod_pca.R](D:/Claude/EAPA-Ecossistema/TRILHA/inst/app/modules/mod_pca.R)
- [inst/app/modules/mod_planejamento_observacional.R](D:/Claude/EAPA-Ecossistema/TRILHA/inst/app/modules/mod_planejamento_observacional.R)
- [inst/app/modules/mod_planejamento_variaveis.R](D:/Claude/EAPA-Ecossistema/TRILHA/inst/app/modules/mod_planejamento_variaveis.R)
- [inst/app/modules/mod_proporcoes.R](D:/Claude/EAPA-Ecossistema/TRILHA/inst/app/modules/mod_proporcoes.R)
- [inst/app/modules/mod_regressao_contagem.R](D:/Claude/EAPA-Ecossistema/TRILHA/inst/app/modules/mod_regressao_contagem.R)
- [inst/app/modules/mod_regression.R](D:/Claude/EAPA-Ecossistema/TRILHA/inst/app/modules/mod_regression.R)
- [inst/app/modules/mod_sampling.R](D:/Claude/EAPA-Ecossistema/TRILHA/inst/app/modules/mod_sampling.R)
- [inst/app/modules/mod_series_temporais.R](D:/Claude/EAPA-Ecossistema/TRILHA/inst/app/modules/mod_series_temporais.R)
- [inst/app/modules/registro_execucoes.R](D:/Claude/EAPA-Ecossistema/TRILHA/inst/app/modules/registro_execucoes.R)
- [inst/app/modules/registro_tratamentos.R](D:/Claude/EAPA-Ecossistema/TRILHA/inst/app/modules/registro_tratamentos.R)

## Observações de interpretação

- O teste de uma proporção usa `binom.test`; duas proporções usam `prop.test`, e a receita também contém `fisher.test`. Fisher não foi contado como uma entrada independente de menu.
- A comparação exploratória de transformações inclui Box–Cox, respeitando o domínio dos dados. Ela não aplica a transformação à base.
- Polinomial é a opção quadrática identificada no módulo de curvas; não foi generalizada para seleção livre de qualquer grau.
- A ANOVA de medidas repetidas oferece o fluxo simples por momento e unidade; não foi tratada como solução geral para modelos longitudinais, dados faltantes ou estruturas de covariância.
- Mapas de pontos não incluem sorteio espacial de estações. Densidade, dependência espacial, extração ambiental e raster não foram listados como fluxos operacionais.
- As simulações didáticas internas do laboratório não propõem a entrada de outros conjuntos sintéticos no EAPADados.
- Antes de uma incorporação aprovada, testar o conjunto no módulo pretendido. A adequação estatística depende do desenho, e não apenas dos tipos das colunas.
