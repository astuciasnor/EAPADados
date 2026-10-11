Sys.setlocale('LC_CTYPE','Portuguese_Brazil.utf8')
root <- 'D:/Claude/EAPA-Ecossistema/EAPADados'
dest <- file.path(root,'nova_estetegia_levantamento/levantamento_tecnico')
motor <- new.env()
source(file.path(root,'R/relatos_crescimento.R'),local=motor,encoding='UTF-8')
fallback <- new.env()
source(file.path(dirname(root),'TRILHA/inst/app/templates/funcoes_crescimento.R'),local=fallback,encoding='UTF-8')
spec <- list(WhiteGrunt2=c('age','tl'),Cabezon=c('age','length'),RuffeSLRH92=c('age','length'),BlackDrum2001=c('otoage','tl'))
out<-list(); desenhos<-list()
for(n in names(spec)){
 e<-new.env();load(file.path(dest,'objetos_originais',paste0('FSAdata__',n,'.rda')),envir=e)
 d<-get(n,e);x<-spec[[n]][1];y<-spec[[n]][2]
 grupos<-list(todos=d)
 if(n=='WhiteGrunt2')for(s in unique(d$sex))grupos[[s]]<-d[d$sex==s,,drop=FALSE]
 for(g in names(grupos)){
   dados<-grupos[[g]];avisos<-character()
   out[[paste(n,g,sep='::')]]<-tryCatch({
     r<-withCallingHandlers(motor$ajustar_curva(dados,y,x,'von_bertalanffy'),warning=function(w){avisos<<-c(avisos,conditionMessage(w));invokeRestart('muffleWarning')})
     f<-fallback$ajustar_curva(dados,y,x,'von_bertalanffy')
     desenhos[[paste(n,g,sep='::')]]<-list(d=dados,x=x,y=y,r=r)
     list(conjunto=n,grupo=g,n_original=nrow(dados),n_ajuste=r$n,ausencias_excluidas_so_no_calculo=nrow(dados)-r$n,idade_min=min(r$x),idade_max=max(r$x),idades_distintas=length(unique(r$x)),comprimento_min=min(r$y),comprimento_max=max(r$y),parametros=as.list(r$params),pseudo_r2=r$pseudo_r2,rse=r$rse,shapiro_p=r$sh_p,convergiu=isTRUE(r$modelo$convInfo$isConv),mesmo_fallback=isTRUE(all.equal(r$params,f$params)),avisos=avisos)
   },error=function(err)list(conjunto=n,grupo=g,erro=conditionMessage(err)))
 }
}
jsonlite::write_json(out,file.path(dest,'validacao_von_bertalanffy.json'),auto_unbox=TRUE,pretty=TRUE,na='null')
png(file.path(dest,'comparacao_von_bertalanffy.png'),width=1600,height=1200,res=150)
par(mfrow=c(2,2),mar=c(4,4,3,1),oma=c(2,0,0,0))
for(n in names(spec)){
 p<-desenhos[[paste(n,'todos',sep='::')]]
 if(is.null(p)){plot.new();title(n);next}
 plot(p$r$x,p$r$y,pch=16,col=adjustcolor('#176B80',alpha.f=.45),xlab='Idade (anos)',ylab=if(n=='Cabezon')'Comprimento (cm)'else 'Comprimento (mm)',main=n)
 xx<-seq(min(p$r$x),max(p$r$x),length.out=200);cc<-p$r$params
 lines(xx,cc['Linf']*(1-exp(-cc['k']*(xx-cc['t0']))),col='#CB6537',lwd=2)
 legend('bottomright',legend=paste('n =',p$r$n,'; pseudo-R² =',round(p$r$pseudo_r2,3)),bty='n',cex=.8)
}
dev.off()
for(n in names(out))cat(n,jsonlite::toJSON(out[[n]],auto_unbox=TRUE),'\n')
