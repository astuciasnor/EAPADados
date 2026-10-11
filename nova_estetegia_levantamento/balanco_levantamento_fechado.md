# Fechamento do levantamento e proposta de núcleo para a Fase 2

Fotografia de 10/10/2026. Busca ampla encerrada; nenhuma incorporação ou corte aplicado.

## Número proposto: 60 conjuntos

| Grupo | Entradas |
|---|---:|
| Conjuntos atuais indicados para a curadoria analítica | 34 |
| Fontes novas de literatura/bases abertas | 5 |
| Candidatos de pacotes R para o núcleo | 21 |
| **Núcleo proposto para a Fase 2** | **60** |

Os 34 atuais correspondem a 43 objetos existentes menos seis sintéticos extras e três objetos de apoio. Essa é uma classificação da proposta, não remoção. Os dois treinos sintéticos autorizados estão entre os 34. Os cinco novos estudos/fontes são whitefish, mesocosmos, Artemia, tilápia sensorial e Enobieta. Os 21 candidatos R estão listados na planilha, com Puromycin incluído uma única vez, como conjunto do R fornecido em XLSX.

## Inventário completo preservado: 105 entradas

43 atuais + 5 literatura/bases abertas + 57 fontes R = 105. Sua distribuição de prioridade é: 60 no núcleo proposto, 36 em reserva, três de apoio e seis sintéticos extras para decisão. Os arquivos dos oito outros objetos FESta, o exemplo readxl e fontes ainda não obtidas não entram nessas 105 entradas.

Uma entrada é um objeto/conjunto proposto, não um artigo ou estudo independente. Whitefish reúne quatro tabelas; mesocosmos reúne seis; Enobieta reúne duas. BGHRsample e BGHRfish são dois objetos relacionados. Existem sobreposições como pinguins/penguins e doubs_ambiente/doubs: ficam visíveis para escolher formatos e usos na curadoria, sem alegar novos estudos independentes.

## Cobertura e qualidade

Há candidatos para as 93 entradas disponíveis do catálogo da TRILHA, agrupadas em 20 famílias na aba Cobertura. O catálogo inclui planejamento, preparo, exploração, análises, conceitos e exportação; não representa 93 testes diferentes. As 12 entradas em preparação não entram nessa conclusão. Isso certifica a identificação de candidatos e estruturas, não pressupostos nem homologação completa dos fluxos.

- **McNemar:** MASS::bacteria, com 44 pares completos semanas 0/11 e perdas documentadas. Cálculo conferido anteriormente no motor da TRILHA.
- **Friedman sensorial:** tilápia, 122 avaliadores com três tratamentos e dois atributos. Confirmar o significado e o sentido da escala antes de interpretar aceitação.
- **BACI:** Enobieta cobre o estudo de caso e a atividade prospectiva de planejamento. Uma intervenção e uma campanha por fase limitam inferência; as subamostras não são barragens independentes.
- **Logarítmico:** Puromycin cobre a aproximação empírica no intervalo observado; Michaelis-Menten é o uso principal de saturação. O ajuste logarítmico não tem assíntota.
- **Contagens e exposição:** InsectSprays, ships, Insurance e quine fornecem alternativas. Captura FESta em toneladas não é contagem Poisson. O ajuste NB específico de ships teve limite de iterações, registrado na curadoria.
- **Mapas e séries:** quakes, aquicultura_br e rec cobrem os usos atuais. NOAA e base pesqueira georreferenciada adicional são enriquecimentos opcionais.
- **Fontes e licenças:** bases com origem incompleta, resultados agregados e alertas de possível simulação/digitalização continuam sinalizadas. Alerta automático não equivale a confirmação; aprovação de nomes não resolve procedência.

## Tamanho

| Escopo | Bytes | MB decimal |
|---|---:|---:|
| Núcleo proposto de 60 | 663,967 | 0.664 |
| Inventário completo de 105 | 841,447 | 0.841 |

Critério: arquivos atuais `.rda` no tamanho real; candidatos previamente medidos como `.rda` em xz; tilápia, Enobieta e Puromycin contados como XLSX completos, incluindo documentação. Nenhum arquivo foi recomprimido agora. É uma estimativa mista conservadora para os dados reunidos, não o tamanho instalado ou compactado de um pacote final. Não inclui scripts, documentação do pacote, dependências, tarballs de origem, PDF da atividade ou fontes opcionais futuras. O inventário de dados medido fica 158,553 bytes abaixo de 1 MB.

## Revisão e integridade

Abra `balanco_fase2_60_conjuntos.xlsx`. A aba Núcleo 60 apresenta a proposta; a aba Inventário preserva também reservas, apoio e sintéticos extras, com campos azuis de Decisão Fase 2/Avaliação final do autor. Decisões anteriores e comentários foram copiados por nome somente como referência; a planilha original não foi sobrescrita. A nova seleção não cancela aprovações anteriores nem autoriza mudanças ainda não aprovadas.

203 arquivos do manifesto original conferidos, zero divergências. As cinco planilhas de entrada foram preservadas por SHA256. A Fase 2 começa pela revisão deste núcleo e dos limites científicos; qualquer adaptação aplicada depois deve informar fonte, licença e alterações de nomes, categorias, unidades, colunas e linhas.
