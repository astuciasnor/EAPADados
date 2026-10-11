Sys.setlocale('LC_CTYPE','Portuguese_Brazil.utf8')
root <- 'D:/Claude/EAPA-Ecossistema/EAPADados/dev/curadoria_2026'
spec <- list(datasets=c('ToothGrowth','sleep','Orange','co2','InsectSprays','chickwts','quakes'), nlme='Orthodont', MASS=c('ships','bacteria'), rpart='kyphosis')
out <- list()
for(p in names(spec))for(n in spec[[p]]) {
 e<-new.env();data(list=n,package=p,envir=e);x<-e[[n]]
 out[[paste(p,n,sep='::')]]<-list(pacote=p,versao=as.character(packageVersion(p)),nome=n,linhas=NROW(x),colunas=NCOL(x),variaveis=names(x),na=sum(is.na(x)),niveis=if(is.data.frame(x))lapply(x,function(v)if(is.factor(v))levels(v)else NULL)else NULL)
 h<-utils:::.getHelpFile(do.call(utils::help,list(topic=n,package=p)));writeLines(capture.output(tools::Rd2txt(h)),file.path(root,paste0('fonte_',p,'_',n,'.txt')),useBytes=TRUE)
}
jsonlite::write_json(out,file.path(root,'candidatos_r_verificados.json'),pretty=TRUE,auto_unbox=TRUE)
for(n in names(out))cat(n,out[[n]]$linhas,'x',out[[n]]$colunas,'NA',out[[n]]$na,'\n')
b <- MASS::bacteria
for(w in c(0,11)) cat('bacteria semana',w,'n=',sum(b$week==w),'\n')
p <- reshape(b[b$week %in% c(0,11),c('ID','week','y')], idvar='ID',timevar='week',direction='wide')
cat('bacteria pares 0/11=',sum(complete.cases(p)),'\n');print(table(p$y.0,p$y.11))
s<-MASS::ships;cat('ships exposicao zero',sum(s$service==0),'\n')
m<-glm(incidents~type+factor(year)+factor(period)+offset(log(service)), data=s[s$service>0,],family=poisson())
cat('ships dispersao Poisson=',sum(residuals(m,type='pearson')^2)/df.residual(m),'\n')
print(table(nlme::Orthodont$Subject,nlme::Orthodont$age)[1:2,])

