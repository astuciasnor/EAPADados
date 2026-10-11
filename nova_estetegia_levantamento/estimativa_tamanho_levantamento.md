# Estimativa de tamanho do levantamento

## Resultado preliminar

Sim. Com os conjuntos atuais e os candidatos cuja origem e natureza empírica foram confirmadas, a estimativa é de **628.501 bytes (0,629 MB)**. O cálculo mantém os 43 arquivos `.rda` atuais no tamanho em disco e soma os candidatos serializados com compressão xz. Isso deixa cerca de **371.499 bytes** até 1 MB.

Se também for incorporada a planilha de exemplo do pacote `readxl` (44.265 bytes), a estimativa sobe para **672.766 bytes (0,673 MB)**. Ela é opcional: os dois conjuntos sintéticos de treino já existentes podem servir ao exercício de importação de planilhas.

| Componente | Tamanho estimado |
|---|---:|
| 43 conjuntos atualmente em `data/` (tamanho atual) | 337.401 bytes |
| 54 objetos candidatos de pacotes R, serializados em xz | 193.300 bytes |
| Fontes adicionais empíricas confirmadas: FSAdata, FESta `StdEffort_dataset`, quatro tabelas de whitefish, Artemia e seis tabelas de mesocosmo | 97.800 bytes |
| **Total elegível preliminar** | **628.501 bytes (0,629 MB)** |
| Planilha opcional de exemplo do `readxl` | +44.265 bytes |
| **Total com a planilha opcional** | **672.766 bytes (0,673 MB)** |

Para comparação, recomprimir também os dados atuais em xz reduziria o total elegível estimado para **616.648 bytes** (ou **660.913 bytes** com a planilha opcional). Isso é apenas uma comparação de formato, não uma recomendação para alterar os objetos agora.

## O que a conta inclui e o que não inclui

- O inventário ainda mantém alternativas e sobreposições entre conjuntos; portanto, é uma estimativa conservadora antes da curadoria e não uma previsão do tamanho final.
- Os 43 conjuntos atuais foram mantidos integralmente. Entre eles há seis conjuntos sintéticos adicionais (6.329 bytes) ainda sujeitos à avaliação da curadoria; não foram removidos. Os dois conjuntos sintéticos de treino autorizados já estão incluídos no tamanho atual (552 e 679 bytes) e devem ser identificados como sintéticos.
- A conta principal inclui apenas o `StdEffort_dataset` do FESta, cuja documentação identifica a fonte. Oito outros objetos desse pacote ficam de fora: três são explicitamente simulados e cinco ainda não têm procedência suficientemente clara.
- A conta exclui arquivos compactados dos pacotes, documentação/metadados de fontes, dependências e fontes ainda pendentes (BACI, dados brutos sensoriais do estudo de pó de peixe, recorte regional do NOAA e itens com procedência não confirmada). Assim, “menos de 1 MB” é uma resposta afirmativa para o inventário elegível atualmente medido, mas ainda não um limite garantido para o acervo completo futuro.
- Nenhum dado foi adaptado, renomeado, filtrado ou copiado para `data/`; esta estimativa não aplica cortes.

## Fontes adicionais confirmadas

- **Artemia** — experimento de suplementação de fitosteróis, em béqueres de 4 L com três réplicas por tratamento; 69 linhas e cinco colunas. É um estudo empírico apropriado para tratamentos de alimentação e respostas de crescimento/biomassa. A licença informada pela fonte é CC BY 4.0. [Registro BCO-DMO](https://www.bco-dmo.org/dataset/724179/description).
- **Whitefish e salinidade** — quatro arquivos tabulares do estudo Dryad. A documentação informa que os peixes não foram identificados individualmente; não se deve interpretar as medições como observações repetidas pareadas dos mesmos indivíduos. [Registro Dryad](https://datadryad.org/dataset/doi:10.5061/dryad.bg79cnpph).
- **Mesocosmos e secagem** — seis planilhas de um experimento em 64 tanques, com desenho cruzando fatores tróficos e secagem. A documentação de origem explica a exclusão de um tanque para medidas específicas. [Registro Dryad](https://datadryad.org/dataset/doi:10.5061/dryad.hx3ffbgkn).
- **Dados sensoriais de mingau com pó de peixe** — o artigo informa que os dados brutos serão disponibilizados pelos autores mediante solicitação; não foi localizado arquivo público para baixar. Ficou pendente, sem contato com os autores. [Artigo](https://www.frontiersin.org/journals/nutrition/articles/10.3389/fnut.2026.1839118/full).

Os arquivos de origem e as medições detalhadas estão na pasta `levantamento_tecnico`, separada dos dados do pacote. Qualquer incorporação futura deverá documentar a fonte e as adaptações (colunas removidas, linhas filtradas e nomes alterados).
