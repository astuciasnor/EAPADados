from pathlib import Path
import urllib.request, urllib.parse, json, hashlib
ROOT=Path(__file__).resolve().parent/'levantamento_tecnico'
BASE='https://datadryad.org'
def get(url):
    with urllib.request.urlopen(url,timeout=40) as r:return r.read()
def js(url):return json.loads(get(url))
def main():
    saida=[]
    for nome,doi in [('whitefish_salinidade','10.5061/dryad.bg79cnpph'),('mesocosmos_secagem','10.5061/dryad.hx3ffbgkn')]:
        dest=ROOT/'literatura'/nome;dest.mkdir(parents=True,exist_ok=True)
        try:
            d=js(BASE+'/api/v2/datasets/'+urllib.parse.quote('doi:'+doi,safe=''))
            version=js(BASE+d['_links']['stash:version']['href'])
            fs=js(BASE+version['_links']['stash:files']['href'])
            (dest/'metadados.json').write_text(json.dumps({'dataset':d,'versao':version,'arquivos':fs},ensure_ascii=False,indent=2),encoding='utf-8')
            for f in fs['_embedded']['stash:files']:
                fn=Path(f['path']).name
                if not fn.lower().endswith(('.csv','.xlsx','.txt','.md','.r')):continue
                if f.get('size',0)>20_000_000:continue
                url=BASE+f['_links']['stash:download']['href']
                p=dest/fn
                if not p.exists():p.write_bytes(get(url))
                saida.append({'conjunto':nome,'doi':doi,'arquivo':fn,'bytes':p.stat().st_size,'sha256':hashlib.sha256(p.read_bytes()).hexdigest(),'url':url,'status':'obtido'})
        except Exception as e:saida.append({'conjunto':nome,'doi':doi,'status':'pendente','erro':str(e)})
    (ROOT/'fontes_literatura.json').write_text(json.dumps(saida,ensure_ascii=False,indent=2),encoding='utf-8')
    print(json.dumps(saida,ensure_ascii=False,indent=2))
if __name__=='__main__':main()
