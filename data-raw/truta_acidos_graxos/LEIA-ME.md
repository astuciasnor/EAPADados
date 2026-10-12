# D18 — Truta-do-lago: dietas e ácidos graxos

Substituição de `cabritos_acidos_graxos`/`cabritos_fa_coltro` aprovada pelo autor em 12/10/2026. Objeto atual nos dois pacotes: `truta_acidos_graxos`. O catálogo da ClaRa permanece com 60 entradas.

## Fonte e adaptação

Happel, Austin; Pike, Jeremy; Rinchard, Jacques; Czesny, Sergiusz (2021). *Testing Fatty Acid Based Diet Estimation Models using Diets Composed of Natural Prey Items*. Mendeley Data, V2. DOI: https://doi.org/10.17632/n6nmfpkpc5.2 . Licença CC BY 4.0. Arquivo original `The Full Dataset.xlsx`, sem alterações, com hash em `SHA256.txt`.

Sete dietas com quironomídeos, dáfnias e camarões: presas isoladas, misturas 1:1 e mistura 1:1:1 em massa seca. Cada dieta foi sorteada para três aquários. Recorte didático: semana 12; 60 peixes agregados por média aritmética nos 21 aquários. 31 colunas: ID, dieta, semana, número de peixes e 27 ácidos em porcentagem. Não misturar os tempos como novas UEs nem incluir metadados na PCA.

O preparo R confere o hash e as dimensões, preserva todos os peixes da semana 12 e verifica as somas de porcentagens. Não há imputação, correção de extremos ou seleção de ácidos pela separação dos grupos. `n_peixes` informa subamostragem desigual, não novas réplicas. Dicionário completo na ajuda `?truta_acidos_graxos`.

Limitações: três UEs por dieta, sobrevivência baixa/desigual, porcentagens composicionais e valor extremo TL10884v mantido na média do aquário 39. A base não comprova diferença estatística entre os sete tratamentos. Fonte aberta não substitui validação dos cromatogramas.

## Biplot aprovado e próximo trabalho

O autor aprovou visualmente o biplot exploratório da semana 12 e pediu tentar reproduzi-lo em R quando for feita a análise. Referência: `APOIO/curadoria-acidos-graxos/avaliacao-20261012/pca-truta/biplot_semana12.png`, na raiz do ecossistema; detalhes em `parecer-pca.md` na mesma pasta.

Receita da referência: PCA dos 27 ácidos em porcentagem, com centralização e escala por desvio-padrão; 21 médias de aquários; cores e formas por dieta, nenhuma amostra excluída. PC1 = 46,5339677%, PC2 = 21,7363185%. Exibir oito setas com maior cos² no plano sem retirar as demais variáveis do cálculo. Escores divididos pelo DP de cada PC; setas de correlação multiplicadas por 1,7; não usar elipses com três UEs por grupo. Sinais dos eixos são arbitrários. Paleta Ocean ampliada para sete dietas; rótulos EPA, DPA n-3 e DHA.

O gráfico definitivo em R fica para o trabalho de análise, conforme solicitado. A inclusão dos dados usa R e sua PCA foi conferida com `prcomp()`.
