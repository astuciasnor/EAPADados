# Qualidade dos conjuntos incorporados — 12/10/2026

Esta rodada não usa “limpo” como sinônimo de “pronto para qualquer análise”.
Cada conjunto foi lido em quatro dimensões: fonte e licença, fidelidade do
preparo, unidade/delineamento e utilidade didática. O estado abaixo orienta a
documentação e não substitui a ficha ou o artigo original.

| Grupo de qualidade | Conjuntos | Estado de uso | Limite que deve acompanhar o exemplo |
|---|---|---|---|
| Fonte rastreável e delineamento explícito | `bufalos_estrongilos`, `chinook_digestao`, `truta_acidos_graxos` | Prontos para exploração didática | Búfalos exigem pares pelo ID; Chinook é contagem com zeros e variância não constante; truta tem três aquários por dieta e respostas composicionais. |
| Série íntegra, com pendência de licença formal | `anchova_norte_california` | Pronta para explorar tendência, sazonalidade e autocorrelação | A série é mensal agregada, não abundância; a fonte permite uso e redistribuição, mas não declara licença Creative Commons. |
| Fonte rastreável, metadados semânticos pendentes | `secagem_beterraba_gengibre` | Útil para mostrar forma de decaimento, ainda não para comparar tratamentos | A fonte não identifica os códigos de produto/tratamento nem a unidade de `tempo_origem`. |

`truta_acidos_graxos` é a mesma adaptação usada na ClaRa como D18. O histórico
da substituição dos cabritos fica no controle de versão; a documentação ativa
explica que a semana 12 foi agregada por aquário, sem fabricar réplicas.

Antes de uma análise inferencial nova, confirme primeiro a linha que representa
a unidade independente. Ausências, zeros e valores extremos foram mantidos;
não são defeitos a eliminar automaticamente.
