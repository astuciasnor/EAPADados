from pathlib import Path
import hashlib
import json
from reportlab.pdfgen import canvas
from reportlab.lib import colors
from reportlab.lib.pagesizes import A4
from reportlab.lib.styles import ParagraphStyle
from reportlab.platypus import Paragraph
from reportlab.pdfbase import pdfmetrics
from reportlab.pdfbase.ttfonts import TTFont
from pypdf import PdfReader

ROOT = Path(__file__).resolve().parent
OUT = ROOT / 'atividade_planejar_baci_enobieta.pdf'
SOURCE = ROOT.parent / 'enobieta_baci_organizado.xlsx'
before = hashlib.sha256(SOURCE.read_bytes()).hexdigest()
for name, file in [('Body', 'calibri.ttf'), ('Bold', 'calibrib.ttf'), ('Italic', 'calibrii.ttf')]:
    pdfmetrics.registerFont(TTFont(name, str(Path('C:/Windows/Fonts') / file)))
pdfmetrics.registerFontFamily('Body', normal='Body', bold='Bold', italic='Italic', boldItalic='Bold')
NAVY, TEAL, MINT = [colors.HexColor(x) for x in ['#0F3B5F', '#2E7D8F', '#EAF4F3']]
INK, GREY = colors.HexColor('#253748'), colors.HexColor('#D7E1E7')
W, H = A4
LEFT, RIGHT = 45, W - 45
WIDTH = RIGHT - LEFT
c = canvas.Canvas(str(OUT), pagesize=A4)
c.setTitle('Planejar antes de conhecer os resultados: atividade BACI em Enobieta')
c.setAuthor('EAPADados | proposta didática para revisão do professor')
styles = {
    'body': ParagraphStyle('body', fontName='Body', fontSize=11, leading=14.5, textColor=INK),
    'small': ParagraphStyle('small', fontName='Body', fontSize=9, leading=11.5, textColor=INK),
    'label': ParagraphStyle('label', fontName='Bold', fontSize=11.5, leading=15, textColor=NAVY),
    'white': ParagraphStyle('white', fontName='Bold', fontSize=10, leading=12, textColor=colors.white),
}
y = 0

def text(s, kind='body', gap=8, x=LEFT, width=WIDTH):
    global y
    p = Paragraph(s, styles[kind])
    _, h = p.wrap(width, H)
    if y - h < 48:
        raise ValueError(f'Conteúdo excedeu a página: {s[:70]}')
    p.drawOn(c, x, y-h)
    y -= h + gap

def lines(n=3):
    global y
    c.setStrokeColor(GREY)
    c.setLineWidth(.45)
    for _ in range(n):
        y -= 18
        c.line(LEFT, y, RIGHT, y)
    y -= 10

def box(s):
    global y
    p = Paragraph(s, styles['small'])
    _, h = p.wrap(WIDTH-24, H)
    c.setFillColor(MINT)
    c.roundRect(LEFT, y-h-22, WIDTH, h+22, 6, fill=1, stroke=0)
    p.drawOn(c, LEFT+12, y-h-10)
    y -= h+32

def question(n, s, nlines=2):
    text(f'<b>{n}.</b> {s}')
    lines(nlines)

def table(headers, rows, widths, rowheight=31):
    global y
    x = LEFT
    c.setFillColor(TEAL)
    c.rect(LEFT, y-rowheight, WIDTH, rowheight, fill=1, stroke=0)
    for h, w in zip(headers, widths):
        p = Paragraph(h, styles['white'])
        _, ph = p.wrap(w-12, rowheight)
        p.drawOn(c, x+6, y-(rowheight+ph)/2)
        x += w
    y -= rowheight
    for row in rows:
        x = LEFT
        for value, w in zip(row, widths):
            c.setStrokeColor(GREY)
            c.rect(x, y-rowheight, w, rowheight, fill=0, stroke=1)
            p = Paragraph(str(value), styles['small'])
            _, ph = p.wrap(w-12, rowheight)
            p.drawOn(c, x+6, y-(rowheight+ph)/2)
            x += w
        y -= rowheight
    y -= 12

def page(number, label, title):
    global y
    c.setFillColor(NAVY)
    c.rect(0, H-46, W, 46, fill=1, stroke=0)
    c.setFillColor(colors.white)
    c.setFont('Bold', 10)
    c.drawString(LEFT, H-28, 'TRILHA  /  PLANEJAMENTO DA PESQUISA')
    c.setFillColor(TEAL)
    c.setFont('Bold', 10)
    c.drawString(LEFT, H-72, label.upper())
    c.setFillColor(NAVY)
    c.setFont('Bold', 23)
    c.drawString(LEFT, H-102, title)
    c.setStrokeColor(GREY)
    c.line(LEFT, 37, RIGHT, 37)
    c.setFont('Body', 8)
    c.setFillColor(INK)
    c.drawString(LEFT, 24, 'EAPADados | Enobieta | proposta para revisão didática')
    c.drawRightString(RIGHT, 24, f'{number} / 4')
    y = H-122

page(1, '01 / O problema', 'Planejar antes de saber')
text('Atividade BACI: antes/depois, controle/impacto', 'label')
text('Equipe: __________________________________  Turma: __________  Data: __________', 'small', gap=14)
box('<b>O tempo da atividade é o tempo do planejamento.</b> Você integra a equipe que precisa definir o monitoramento antes do esvaziamento do reservatório de Enobieta, no norte da Espanha. O caso é real; esta situação de decisão é uma reencenação didática. As escolhas futuras da equipe são propostas, não registros do que ocorreu.')
text('O desafio', 'label')
text('O esvaziamento poderá mobilizar sedimentos e alterar o habitat a jusante. A equipe quer investigar mudanças nos macroinvertebrados do riacho e no substrato. Uma mudança depois da intervenção, sozinha, não resolve a pergunta: também pode haver variação natural ao longo do tempo.')
text('Sua entrega', 'label')
text('Prepare um protocolo com pergunta, locais, calendário, unidades amostrais, respostas e plano de comparação. Use o módulo de planejamento observacional da TRILHA como apoio. Registre as decisões nas páginas seguintes antes de consultar os resultados do estudo.')
question(1, 'Formule uma pergunta que compare a mudança temporal nos locais de impacto com a mudança nos controles.', 3)
question(2, 'Escolha uma resposta principal: riqueza de táxons, densidade de indivíduos ou outro indicador justificado. Escreva a hipótese e explique que mudança seria ecologicamente relevante.', 3)
text('BACI = Before-After / Control-Impact. Nesta atividade, controle não significa necessariamente rio intocado: significa uma referência adequada para a comparação proposta.', 'small')
c.showPage()

page(2, '02 / Espaço e unidades', 'Onde e em que nível coletar?')
text('Pontos de partida do caso real', 'label')
table(['Locais candidatos', 'Posição e papel a avaliar'], [
    ['C1', 'Montante da barragem.'],
    ['C2, C3 e C4', 'Tributários livres da influência direta da barragem.'],
    ['I1, I2, I3 e I4', 'Distâncias crescentes a jusante.'],
], [120, WIDTH-120], 34)
question(3, 'Justifique quais locais usaria como controles e quais como impacto. Que informações prévias sobre habitat, conectividade e outras pressões precisaria conferir?', 3)
question(4, 'Desenhe a barragem, o sentido da água, os tributários e os locais escolhidos. Use apenas posições relativas; este é um esquema, não um mapa georreferenciado.', 5)
question(5, 'Identifique: (a) a unidade que recebe a intervenção; (b) o local acompanhado; (c) a subamostra dentro do local. Quais observações podem compartilhar a mesma influência?', 3)
box('<b>Decisão para defender:</b> instalar mais estações a jusante de uma mesma barragem produz novas intervenções independentes? Explique o alcance da inferência que seu desenho permitirá.')
c.showPage()

page(3, '03 / Tempo e protocolo', 'Quando e como repetir?')
text('Um protocolo de campo disponível', 'label')
text('O estudo de origem usou amostras aleatórias com rede Surber de 0,09 m² e malha de 500 µm, além da caracterização do substrato. Use esse protocolo como referência para elaborar sua proposta; justifique adaptações e preserve a comparabilidade entre locais e campanhas.')
question(6, 'Proponha quantas campanhas faria antes, durante e depois. Como distribuiria as datas para lidar com sazonalidade, tendências anteriores e recuperação? Defina também o marco da intervenção.', 3)
table(['Fase', 'Nº de campanhas', 'Épocas / intervalo', 'Justificativa'], [
    ['Antes', '', '', ''], ['Durante (se incluída)', '', '', ''], ['Depois', '', '', ''],
], [98, 102, 142, WIDTH-342], 40)
question(7, 'Defina o número de subamostras por local e campanha, sua distribuição aleatória e como evitar amostrar repetidamente o mesmo trecho perturbado pela coleta.', 3)
text('Dimensione o trabalho', 'label')
text('Total de amostras Surber = soma, em todas as campanhas, do número de locais visitados multiplicado pelas subamostras em cada local. Registre o total previsto e discuta a viabilidade de campo e laboratório.', 'small')
lines(2)
question(8, 'Com menos recursos, que redução faria primeiro e qual informação perderia? Explique por que aumentar subamostras não substitui ampliar locais ou datas independentes.', 2)
c.showPage()

page(4, '04 / Registro e comparação', 'Como o plano vira evidência?')
text('A ficha de coleta vem antes da análise', 'label')
text('Proponha uma linha por amostra Surber. Inclua identificadores de amostra e local, condição, data, fase, área amostrada, resposta e unidade. Se acompanhar uma unidade permanente, defina seu identificador; não presuma pareamento pelo número da subamostra.')
question(9, 'Escreva os nomes das colunas e defina como registrar ausência de coleta, valor ausente e zero observado. Não preencha medições fictícias.', 3)
text('A comparação central', 'label')
box('<b>Contraste BACI:</b> (média depois nos locais de impacto - média antes nos locais de impacto) - (média depois nos controles - média antes nos controles). É uma descrição da comparação; o cálculo da incerteza deve respeitar locais, datas, subamostras e a distribuição da resposta.')
question(10, 'Descreva o gráfico que faria e como representaria condição, tempo e local. Por que testar apenas o antes/depois nos locais de impacto não responde à pergunta BACI?', 2)
question(11, 'Explique como a análise preservaria as medidas repetidas nos locais e as subamostras. Discuta a interação condição × período; não trate todas as linhas como réplicas independentes.', 2)
text('Conferência antes de entregar', 'label')
text('Confira se o plano tem: controles justificáveis; observações anteriores; calendário comparável; unidades identificadas; esforço documentado; resposta principal; tratamento de perdas; limites de inferência. Apresente uma ameaça à atribuição do efeito à intervenção e como tentaria reduzi-la.', 'small')
lines(2)
text('<b>Próxima etapa, após entregar o plano:</b> o professor poderá liberar os dados de Enobieta para comparar seu desenho com o que foi possível executar. Resultados futuros não devem orientar retroativamente a hipótese desta entrega.', 'small')
text('Fonte do caso: Atristain et al. (2024). Dados: DOI 10.5061/dryad.w3r2280ws. Artigo: DOI 10.1111/1365-2664.14656. Consulte as fontes completas após registrar seu plano.', 'small', gap=0)
c.linkURL('https://doi.org/10.5061/dryad.w3r2280ws', (LEFT, y, RIGHT, y+25), relative=0)
c.save()
reader = PdfReader(OUT)
assert len(reader.pages) == 4
for i, page_ in enumerate(reader.pages):
    content = page_.extract_text()
    assert len(content) > 900, (i, len(content))
assert before == hashlib.sha256(SOURCE.read_bytes()).hexdigest(), 'A planilha de origem foi alterada'
(ROOT / 'validacao_pdf.json').write_text(json.dumps({
    'paginas': 4, 'planilha_preservada_sha256': before,
    'bytes_pdf': OUT.stat().st_size,
    'texto_por_pagina': [len(p.extract_text()) for p in reader.pages],
}, ensure_ascii=False, indent=2), encoding='utf-8')
print(OUT)
print(OUT.stat().st_size)
