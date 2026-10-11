Sys.setlocale('LC_CTYPE','Portuguese_Brazil.utf8')
root <- 'D:/Claude/EAPA-Ecossistema/EAPADados'
dest <- file.path(root,'nova_estetegia_levantamento/levantamento_tecnico')
extra <- file.path(dest,'fontes_extraidas')
dir.create(file.path(dest,'objetos_originais'),showWarnings=FALSE)
dir.create(file.path(dest,'documentacao'),showWarnings=FALSE)
dir.create(file.path(dest,'csv_originais'),showWarnings=FALSE)
spec <- list(
 datasets=c('PlantGrowth','npk','ToothGrowth','ChickWeight','UCBAdmissions','HairEyeColor','sleep','warpbreaks','CO2','InsectSprays','airquality','cars','nottem','Nile','quakes','Orange','co2','chickwts'),
 MASS=c('oats','immer','quine','Insurance','wtloss','ships','bacteria'),
 FSA=c('ChinookArg','WhitefishLC','SpotVA1'),
 FSAdata=c('WhiteGrunt2','Cabezon','RuffeSLRH92','BGHRsample','BGHRfish','YERockfish','BlackDrum2001'),
 ade4='doubs',tidyr=c('fish_encounters','who2','billboard'),
 palmerpenguins=c('penguins','penguins_raw'),astsa=c('rec','soi'),
 agridat=c('cochran.latin','grover.rcb.subsample'),lme4='Pastes',
 carData='USPop',vegan='dune',nsm3data='tuna',
 SensoMineR=c('hedochoc','sensochoc'),ClustBlock='fish',nlme='Orthodont',rpart='kyphosis')
out <- list()
for(pkg in names(spec)) for(n in spec[[pkg]]) {
 key <- paste(pkg,n,sep='::')
 out[[key]] <- tryCatch({
   e<-new.env(); rd<-NULL
   if(dir.exists(file.path(extra,pkg))) {
     desc<-read.dcf(file.path(extra,pkg,'DESCRIPTION'))
     version<-desc[1,'Version']; lic<-desc[1,'License']
     files<-list.files(file.path(extra,pkg,'data'),full.names=TRUE)
     f<-files[tools::file_path_sans_ext(basename(files))==n]
     if(length(f)) {
       if(grepl('\\.(rda|rdata|RData)$',f[1])) load(f[1],envir=e)
       else if(grepl('\\.(txt|tab|csv)$',f[1])) assign(n,read.table(f[1],header=TRUE),envir=e)
     }
     if(!exists(n,e,inherits=FALSE) && pkg=='SensoMineR') {
       load(file.path(extra,pkg,'data/chocolates.rda'),envir=e)
     }
     if(pkg=='palmerpenguins') {
       load(file.path(extra,pkg,'R/sysdata.rda'),envir=e)
       assign(n,get(paste0(n,'_df'),e),envir=e)
     }
     rf<-file.path(extra,pkg,'man',paste0(n,'.Rd'))
     if(file.exists(rf)) rd<-tools::parse_Rd(rf)
   } else {
     if(!requireNamespace(pkg,quietly=TRUE)) stop('Pacote indisponível')
     data(list=n,package=pkg,envir=e)
     dd<-packageDescription(pkg);version<-dd$Version;lic<-dd$License
     rd<-tryCatch(utils:::.getHelpFile(do.call(utils::help,list(topic=n,package=pkg))),error=function(e)NULL)
   }
   if(!exists(n,e,inherits=FALSE))stop(paste('Objeto não encontrado; carregados:',paste(ls(e),collapse=', ')))
   x<-get(n,e);prefix<-paste(pkg,n,sep='__')
   path<-file.path(dest,'objetos_originais',paste0(prefix,'.rda'))
   save(list=n,envir=e,file=path,compress='xz',version=3)
   texto<-if(!is.null(rd))capture.output(tools::Rd2txt(rd,options=list(underline_titles=FALSE)))else 'Documentação não encontrada'
   writeLines(texto,file.path(dest,'documentacao',paste0(prefix,'.txt')),useBytes=TRUE)
   csvbytes<-NULL
   if(is.data.frame(x)||is.matrix(x)){
     csv<-file.path(dest,'csv_originais',paste0(prefix,'.csv'))
     tryCatch({write.csv(x,csv,row.names=FALSE,fileEncoding='UTF-8');csvbytes<-file.info(csv)$size},error=function(e)NULL)
   }
   list(pacote=pkg,versao=version,objeto=n,status='obtido',classe=class(x),linhas=NROW(x),colunas=NCOL(x),variaveis=if(is.list(x))names(x)else colnames(x),bytes_rda_xz=file.info(path)$size,bytes_memoria=as.numeric(object.size(x)),bytes_csv=csvbytes,licenca_pacote=lic,arquivo=path,
     alerta_origem=if(grepl('simulat',paste(texto,collapse=' '),ignore.case=TRUE))'Há menção a simulação: revisar antes de admitir'else if(grepl('Figure|approximately',paste(texto,collapse=' ')))'Possível reconstrução/digitalização de figura: conferir fonte'else '',
     resumo_numerico=if(is.data.frame(x))lapply(x,function(v)if(is.numeric(v))list(min=min(v,na.rm=TRUE),max=max(v,na.rm=TRUE),distintos=length(unique(v)),na=sum(is.na(v)))else list(niveis=unique(as.character(v)),na=sum(is.na(v))))else NULL)
 },error=function(err)list(pacote=pkg,objeto=n,status='pendente',erro=conditionMessage(err)))
 cat(key,out[[key]]$status,'\n')
}
originais<-list.files(file.path(root,'data'),pattern='\\.rda$',full.names=TRUE)
basebytes<-sum(file.info(originais)$size)
ok<-out[vapply(out,function(v)identical(v$status,'obtido'),logical(1))]
sumbytes<-sum(vapply(ok,function(v)v$bytes_rda_xz,numeric(1)))
jsonlite::write_json(list(conjuntos=out,resumo=list(objetos_atuais=length(originais),bytes_atuais=basebytes,candidatos_obtidos=length(ok),bytes_candidatos_xz=sumbytes,bytes_total_bruto=basebytes+sumbytes,limite_mb_decimal=1000000,limite_mib=1048576,observacao='Total bruto mantém conjuntos sobrepostos, variantes e candidatos que poderão ser recusados. Inclui dados de origem ainda em avaliação; não é o tamanho final do pacote nem de suas dependências.')),
 file.path(dest,'medicao_conjuntos.json'),pretty=TRUE,auto_unbox=TRUE,na='null')
cat('TOTAL',basebytes,'+',sumbytes,'=',basebytes+sumbytes,'bytes\n')
