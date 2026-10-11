# Somente leitura dos motores e cálculo em memória com bases reais candidatas.
# Não incorpora objetos ao pacote nem modifica TRILHA ou ClaRa.
Sys.setlocale('LC_CTYPE','Portuguese_Brazil.utf8')
source('D:/Claude/EAPA-Ecossistema/TRILHA/R/analises.R',encoding='UTF-8')
o<-as.data.frame(nlme::Orthodont)
f<-trilha_friedman(o,list(resposta='distance',condicao='age',bloco='Subject',posteste='holm',nivel_confianca=.95))
a<-trilha_anova_medidas_repetidas(o,list(resposta='distance',sujeito='Subject',momento='age'))
b<-MASS::bacteria
p<-reshape(b[b$week %in% c(0,11),c('ID','week','y')],idvar='ID',timevar='week',direction='wide')
p<-p[complete.cases(p),]
m<-trilha_mcnemar(p,list(variavel_1='y.0',variavel_2='y.11',correcao=TRUE))
s<-MASS::ships
s<-s[s$service>0,]
s$year<-factor(s$year);s$period<-factor(s$period)
params<-list(resposta='incidents',preditores=c('type','year','period'),offset='service',usar_offset=TRUE)
po<-trilha_regressao_contagem(s,params,familia='poisson')
nb<-trilha_regressao_contagem(datasets::InsectSprays,list(resposta='count',preditores='spray'),familia='binomial_negativa')
ip<-trilha_regressao_contagem(datasets::InsectSprays,list(resposta='count',preditores='spray'),familia='poisson')
stopifnot(nrow(p)==44,nrow(s)==34,all(table(o$Subject,o$age)==1),inherits(po$objeto,'glm'),inherits(nb$objeto,'negbin'),is.finite(m$objeto$p.value),is.finite(f$tabela[['Qui-quadrado de Friedman']]),is.finite(a$tabela$F[1]),isTRUE(nb$objeto$converged))
res<-list(friedman='OK: 27 sujeitos x 4 idades',repetidas='OK: grade completa; F da ocasiao finito, erro sem estatistica F por definicao',mcnemar=list(pares=nrow(p),p=m$objeto$p.value),contagem=list(ships_celulas=nrow(s),ships_poisson_dispersao=po$dispersao,ships_nb_limite='Ajuste NB com tipo + periodos em fatores emitiu aviso de limite de iteracoes para theta; nao adotar como exemplo NB garantido',insectsprays_poisson_dispersao=ip$dispersao,insectsprays_nb_theta=nb$objeto$theta,insectsprays_nb_convergiu=nb$objeto$converged),limite='Valida encaixe de entrada e cálculo, não garante pressupostos científicos. Nenhuma alteração de conjunto aplicada.')
jsonlite::write_json(res,'D:/Claude/EAPA-Ecossistema/EAPADados/dev/curadoria_2026/validacao_encaixe_trilha.json',auto_unbox=TRUE,pretty=TRUE)
print(res)
