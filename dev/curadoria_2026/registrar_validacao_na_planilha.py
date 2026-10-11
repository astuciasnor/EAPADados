"""Atualiza apenas fatos de validação novos, preservando campos de decisão."""
from pathlib import Path
import json,csv
from openpyxl import load_workbook
out=Path(__file__).resolve().parent
p=out/'curadoria_eapadados_revisao.xlsx'
wb=load_workbook(p)
rows=json.loads((out/'propostas.json').read_text(encoding='utf-8'))
changes={
'MASS::ships':dict(analise='Poisson; exposição/offset',avaliacao='40 células de frota. type/year/period/service/incidents → tipo_navio/periodo_construcao/periodo_operacao/servico_meses/incidentes. Filtrar seis células sem exposição apenas no ramo com offset. Construção 60/65/70/75 → 1960–1964/1965–1969/1970–1974/1975–1979; operação 60/75 → 1960–1974/1975–1979. Poisson: dispersão ≈ 1,69.',restricao='Contagens agregadas, não 40 navios. NB com tipo e períodos fatoriais atingiu limite de iterações de theta; não adotar como exemplo NB garantido. Usar InsectSprays como alternativa verificada.'),
'datasets::InsectSprays':dict(avaliacao='72 unidades e seis inseticidas. count/spray → contagem_insetos/inseticida; A…F → inseticida A…F, sem inventar composição. No motor da TRILHA: Poisson com dispersão ≈ 1,51; NB convergiu com theta ≈ 28,10. Manter observações.',restricao='Contagem não garante ANOVA normal. Exposição ausente na tabela: não inventar offset. Conferência de ajuste não dispensa diagnóstico.',prioridade='Alta')}
for r in rows:
    if r['nome'] not in changes:continue
    row=next(i for i in range(2,wb['Curadoria'].max_row+1) if wb['Curadoria'].cell(i,8).value==r['id'])
    # Se houve edição da avaliação pelo autor, não substituir.
    if wb['Curadoria'].cell(row,5).value!=r['avaliacao']:raise SystemExit('Avaliação editada: conciliar manualmente, sem sobrescrever.')
    r.update(changes[r['nome']])
    wb['Curadoria'].cell(row,3,r['analise']);wb['Curadoria'].cell(row,5,r['avaliacao']);wb['Curadoria'].cell(row,9,r['prioridade'])
    drow=next(i for i in range(2,wb['Diagnóstico'].max_row+1) if wb['Diagnóstico'].cell(i,1).value==r['id'])
    wb['Diagnóstico'].cell(drow,4,r['restricao'])
for row in wb['Cobertura'].iter_rows(min_row=2):
    if row[0].value=='Poisson; binomial negativa':
        row[4].value='ships: seis células sem exposição; NB com períodos em fatores emitiu aviso para theta. InsectSprays: NB convergiu. Diagnosticar antes de escolher modelo.'
wb.save(p)
(out/'propostas.json').write_text(json.dumps(rows,ensure_ascii=False,indent=2),encoding='utf-8')
headers=[c.value for c in wb['Curadoria'][1]]
with (out/'curadoria_resumo.csv').open('w',encoding='utf-8-sig',newline='') as f:
    writer=csv.writer(f,delimiter=';');writer.writerow(headers)
    for r in rows:writer.writerow([r['nome'],r['origem'],r['analise'],r['situacao'],r['avaliacao'],r['decisao'],r['autor'],r['id'],r['prioridade'],r['dimensao'],r['natureza']])
print('Fatos de validação registrados; decisões e ajustes do autor preservados.')
