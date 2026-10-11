# Curadoria EAPADados — levantamento de 10/10/2026

Para subsidiar a escolha dos conjuntos, consulte o **[catálogo de funcionalidades da TRILHA](funcionalidades_trilha.md)** ou sua **[planilha filtrável](funcionalidades_trilha.xlsx)**. O catálogo reúne 105 entradas de consulta: 93 com implementação conectada ao menu e 12 entradas agrupadas em preparação. Não representa 105 análises distintas nem uma homologação completa da interface. A aba **Escolha dos dados** relaciona recursos e estruturas amostrais; esse arquivo é apenas referência e não substitui a planilha de decisões abaixo.

Abra **[curadoria_eapadados_revisao.xlsx](curadoria_eapadados_revisao.xlsx)**. É a versão para decidir: 43 objetos atuais e 15 candidatos, reunidos na aba **Curadoria**. O arquivo `curadoria_eapadados.xlsx` é o primeiro rascunho, preservado sem substituição; não o use para iniciar a revisão.

1. Na coluna **Decisão**, escolha **Aprovar proposta**, **Aprovar com ajustes**, **Recusar** ou **Adiar**. Tudo começa **Pendente**.
2. Escreva ajustes em **Avaliação final do autor**. A proposta original fica preservada para comparação.
3. Nas abas **Variáveis** e **Categorias**, os itens **Herdar do conjunto** seguem sua decisão principal. Altere apenas exceções: assim você não precisa aprovar centenas de células. Nomes/unidades com pendência técnica não são liberados por uma aprovação geral.
4. Salve com **Ctrl+S** no Excel ou OnlyOffice e avise no chat. Posso ler as escolhas diretamente deste XLSX salvo. Não é necessário executar scripts.

As cinco primeiras colunas são as solicitadas. Filtros, cabeçalhos congelados, campos editáveis azuis e listas de decisão estão disponíveis. **Pronto** nos candidatos de pacotes R significa pronto **na origem**, sem aprovação implícita da tradução, recorte ou incorporação. Literatura e bases abertas aparecem antes; todos os candidatos de pacotes R ficam no final.

**Nenhum dado foi alterado.** Os arquivos criados estão somente em `EAPADados/dev/curadoria_2026/`. Não houve incorporação na ClaRa, mudança em TRILHA, exclusão de linhas, renomeação de colunas, imputação ou instalação de pacotes.

## Documentação obrigatória de cada adaptação

Exigência do autor: toda adaptação aprovada e efetivamente aplicada deve ser acompanhada da atualização da documentação do conjunto. Isso vale também quando a única mudança for a padronização dos nomes ou dos níveis dos fatores.

- Declarar explicitamente que os dados foram **adaptados da fonte original**, distinguindo medições reais, dados agregados, reconstruções e os dois treinos sintéticos autorizados.
- Identificar a fonte original: autores, título, ano, DOI/URL e, quando vier de pacote R, pacote, objeto e versão. Preservar os créditos e informar a licença disponível; não inventar referências ausentes.
- Resumir as adaptações realizadas: colunas removidas e motivo; filtros de linhas, critérios e número de registros antes/depois; nomes de variáveis e categorias alterados, com de-para. Quando não houver exclusão de linhas, declarar sua preservação.
- Informar mudanças de formato, unidades ou cálculos derivados, se houver, e apontar o script de preparação que permite reproduzir a adaptação. Preservar o histórico de adaptações anteriores que continuar relevante.
- Atualizar a descrição, dimensões, dicionário e exemplos para corresponderem ao objeto final. Editar a fonte roxygen em `R/` e regenerar `man/`, em vez de editar apenas o `.Rd` gerado.

A documentação deve descrever o que **foi feito**, não apresentar propostas pendentes como alterações concluídas. Nenhuma adaptação estará concluída sem essa conferência. Nesta fase, apenas a exigência fica registrada; os conjuntos e sua documentação publicada permanecem intactos até a aprovação da curadoria.

## Achados do levantamento

- Os 43 objetos em `data/` somam 337.401 bytes. O principal ganho é clareza e documentação, não armazenamento. Identificadores, estratos e unidades amostrais devem ser preservados.
- Assumi que os dois sintéticos autorizados são `treino_coletas` e `treino_desembarque`. Estão destacados como **DADOS SINTÉTICOS DE TREINO**. Seis extras já existentes foram encontrados: `artemia`, `captura_petrechos`, `estacoes_ictiofauna`, `ocorrencias_peixes`, `sst_costa_norte`, `tilapia_crescimento`. Sua retirada é somente uma proposta.
- Na pescada limpa, `cpue_pescada` está inteiramente vazia e `cpue` tem um único valor. São candidatas à retirada; as 252 viagens permanecem. Não excluir 239 viagens por ausência de `dias_ao_mar`.
- Repetições completas de linhas não provam duplicação indevida: `camaroes_sexo` tem 170 indivíduos representados por duas categorias, e apenas quatro combinações possíveis. Aplicar `distinct()` destruiria as frequências.
- `gammarus_dieta_temperatura_resumo` tem médias, DP e n; não contém réplicas para recalcular ANOVA. `tilapia_microalgas` tem 15 tanques e controle sem cruzamento completo de doses. Não fabricar réplicas ou níveis.
- `qfasa_acidos_graxos` é um data.frame de 39 × 1, apesar de documentado como vetor. Painéis de presas/predadores diferem; padronização química precisa conferir equivalências. Biópsias não são animais independentes.
- Unidades ausentes e códigos anatômicos sem tradução foram deixados pendentes, em vez de receber nomes presumidos. Bases com fonte incompleta não foram classificadas como reais confirmadas.

## Fontes novas e encaixe metodológico

Foram consultados manuais oficiais de R/CRAN, repositórios de dados científicos e NOAA. Onze candidatos foram carregados de pacotes já instalados e tiveram documentação/dimensões conferidas. `agridat::grover.rcb.subsample` foi conferido no [manual oficial](https://search.r-project.org/CRAN/refmans/agridat/html/grover.rcb.subsample.html), mas não instalado: possui blocos e contagens, que a tela atual de subamostras não representa integralmente.

- [nlme::Orthodont](https://stat.ethz.ch/R-manual/R-devel/library/nlme/html/Orthodont.html): 27 sujeitos × quatro idades completos; candidato para Friedman e medidas repetidas.
- [MASS::bacteria](https://stat.ethz.ch/R-manual/R-devel/library/MASS/html/bacteria.html): 44 pares completos entre semanas 0/11, com seis perdas documentadas; candidato para McNemar após alargar por ID.
- [MASS::ships](https://stat.ethz.ch/R-manual/R-devel/library/MASS/html/ships.html): contagens agregadas com exposição em meses; seis células sem exposição ficam fora apenas do ramo com offset. Poisson foi executado no motor da TRILHA. O ajuste binomial negativo com tipo e períodos fatoriais emitiu aviso de limite de iterações de theta; não foi adotado como exemplo NB garantido.
- [datasets::InsectSprays](https://stat.ethz.ch/R-manual/R-devel/library/datasets/html/InsectSprays.html): alternativa de contagem sem offset, com Poisson e binomial negativa conferidos no motor.
- [datasets::quakes](https://stat.ethz.ch/R-manual/R-devel/library/datasets/html/quakes.html): alternativa real para pontos/bolhas, com ressalvas de fundo cartográfico e longitude. Ainda falta uma base pesqueira georreferenciada validada.
- [Whitefish em salinidades](https://doi.org/10.5061/dryad.bg79cnpph) e [mesocosmos sob secagem](https://doi.org/10.5061/dryad.hx3ffbgkn): candidatos reais de literatura, sem download dos arquivos nesta fase. Replicação, licença, unidades e estrutura final precisam ser conferidas antes da incorporação. Whitefish não possui marcação individual para pareamento longitudinal.
- [NOAA ERSSTv6](https://www.ncei.noaa.gov/products/extended-reconstructed-sst): produto ambiental reconstruído de observações, sem fabricação de dados nesta curadoria. O recorte espacial/temporal permanece proposta; não fornece clorofila ou profundidade.

As demais fontes específicas e propostas de tradução estão na planilha. A aba **Cobertura** cruza análises atuais, lacunas e limites do menu. Os motores e testes de TRILHA foram lidos; funções centrais de Friedman, medidas repetidas, McNemar e contagens foram exercitadas com candidatos reais. A disponibilidade na ClaRa foi conferida no README e código: médias e medianas disponíveis; outros verbos ainda planejados. Isso não certifica integração de nenhum candidato à ClaRa.

## Rastreabilidade e leitura das decisões

- `inventariar.R` e `inventario_tecnico.json`: inventário por objeto/coluna, dimensões, classes, níveis, NA e repetições. O script carrega cada `.rda` em ambiente isolado; não executa scripts de preparação.
- `verificar_candidatos.R`, `candidatos_r_verificados.json` e `fonte_*.txt`: objetos/versões/documentação dos pacotes instalados.
- `validar_encaixe_trilha.R` e `validacao_encaixe_trilha.json`: conferência de entrada/cálculo nos motores, sem garantia de pressupostos científicos.
- `propostas.json` e `curadoria_resumo.csv`: fotografia das propostas originais. **O CSV não guarda suas decisões posteriores do XLSX.**
- `manifesto_sha256.json`: hashes dos arquivos originais de dados, documentação, preparo e `inst/` para detectar mudanças antes da execução futura.
- `exportar_decisoes.py`: lê o XLSX, verifica IDs/decisões, herança, pendências e hashes, e gera **somente** `decisoes_lidas.json`. Não executa remoções/renomeações. Um ajuste textual ou conflito continua exigindo interpretação.
- `montar_curadoria.py`: gerador do material; recusa sobrescrever a versão de revisão existente para preservar decisões.

Para conferir a leitura opcional, execute `python dev/curadoria_2026/exportar_decisoes.py` da raiz do EAPADados. O ambiente deve ter `openpyxl`. Todas as bases recusadas, adiadas ou pendentes continuam excluídas da execução, mesmo que haja uma aprovação isolada de variável. As pendências técnicas e licenças não se resolvem automaticamente.
