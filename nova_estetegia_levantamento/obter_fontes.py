"""Baixa fontes CRAN; extrai apenas dados e documentação, sem instalar pacotes."""
from pathlib import Path, PurePosixPath
from concurrent.futures import ThreadPoolExecutor
import urllib.request, gzip, tarfile, json, hashlib
from openpyxl import load_workbook

ROOT=Path(__file__).resolve().parent
DEST=ROOT/'levantamento_tecnico'
DEST.mkdir(exist_ok=True)
def fetch(url):
    with urllib.request.urlopen(url, timeout=45) as r:
        return r.read()
def main():
    for f in ROOT.glob('*.xlsx'):
        if f.name not in ['levantamento_conjuntos_trilha.xlsx','curadoria_eapadados_revisao1.xlsx']: continue
        w=load_workbook(f,data_only=True)
        payload={s.title:list(s.values) for s in w}
        (DEST/(f.stem+'.json')).write_text(json.dumps(payload,ensure_ascii=False,indent=2,default=str),encoding='utf-8')
    base='https://cloud.r-project.org'
    raw=gzip.decompress(fetch(base+'/src/contrib/PACKAGES.gz')).decode()
    indice={}
    for bloco in raw.split('\n\n'):
        d={line.split(': ',1)[0]:line.split(': ',1)[1] for line in bloco.splitlines() if ': ' in line and not line.startswith(' ')}
        if 'Package' in d: indice[d['Package']]=d
    def obter(pkg):
        try:
            info=indice[pkg]; v=info['Version']; url=f'{base}/src/contrib/{pkg}_{v}.tar.gz'
            p=DEST/'fontes'/f'{pkg}_{v}.tar.gz'; p.parent.mkdir(exist_ok=True)
            if not p.exists(): p.write_bytes(fetch(url))
            out=DEST/'fontes_extraidas'; out.mkdir(exist_ok=True)
            count=0
            with tarfile.open(p,'r:gz') as tar:
                for member in tar.getmembers():
                    parts=PurePosixPath(member.name).parts
                    if not member.isfile() or '..' in parts or not parts or parts[0]!=pkg: continue
                    if len(parts)<2 or not (parts[1] in ['data','man'] or parts[1].startswith('LICENSE') or parts[1]=='DESCRIPTION' or '/'.join(parts[1:])=='R/sysdata.rda'): continue
                    target=out.joinpath(*parts); target.parent.mkdir(parents=True,exist_ok=True)
                    with tar.extractfile(member) as stream: target.write_bytes(stream.read())
                    count+=1
            return dict(pacote=pkg,versao=v,url=url,bytes_download=p.stat().st_size,sha256=hashlib.sha256(p.read_bytes()).hexdigest(),arquivos_extraidos=count,status='obtido')
        except Exception as e: return dict(pacote=pkg,status='pendente',erro=str(e))
    with ThreadPoolExecutor(max_workers=4) as pool:
        registros=list(pool.map(obter,['FSAdata','astsa','agridat','nsm3data','palmerpenguins','SensoMineR','ClustBlock']))
    (DEST/'fontes_cran.json').write_text(json.dumps(registros,ensure_ascii=False,indent=2),encoding='utf-8')
    for r in registros: print(r)
if __name__=='__main__':main()
