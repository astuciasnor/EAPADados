Sys.setlocale('LC_CTYPE', 'Portuguese_Brazil.utf8')
root <- 'D:/Claude/EAPA-Ecossistema/EAPADados'
out <- list()
for (f in list.files(file.path(root,'data'), pattern='\\.rda$', full.names=TRUE)) {
 e <- new.env(); ns <- load(f,e)
 for(n in ns) {
  x <- e[[n]]
  cols <- if(is.data.frame(x)) lapply(names(x),function(k) {v<-x[[k]]; list(nome=k,classe=paste(class(v),collapse='/'),na=sum(is.na(v)),distintos=length(unique(v)),min=if(is.numeric(v)) suppressWarnings(min(v,na.rm=TRUE)) else NULL,max=if(is.numeric(v)) suppressWarnings(max(v,na.rm=TRUE)) else NULL,niveis=if(is.factor(v)) levels(v) else if(is.character(v)&&length(unique(v))<=25) unique(v) else NULL)}) else list()
  out[[n]]<-list(nome=n,arquivo=basename(f),classe=class(x),linhas=NROW(x),colunas=NCOL(x),bytes=unname(file.info(f)$size),duplicadas=if(is.data.frame(x))sum(duplicated(x)) else NA,colunas_detalhe=cols)
 }
}
jsonlite::write_json(out,file.path(root,'dev/curadoria_2026/inventario_tecnico.json'),pretty=TRUE,auto_unbox=TRUE,na='null')
for(z in out)cat(z$nome,'|',z$linhas,'x',z$colunas,'| dup:',z$duplicadas,'|',paste(vapply(z$colunas_detalhe,function(a)paste0(a$nome,if(a$na>0)paste0('[NA=',a$na,']')else ''),''),collapse=', '),'\n')

