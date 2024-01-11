rm(list=ls())

load("C:/RData/gary5.RData")

rm(c,comm,demo,disp.app,disp.info,html.1,ndw,par.act,par.pla,pro.class,sent,work)


crime<-Reduce(function(x, y) merge(x, y, by="ID",all=TRUE), list(DEMO,COMM,SENT))
  write.csv(crime,file="c:/RData/crime5.csv")

displine<-Reduce(function(x, y) merge(x, y, by="ID",all=TRUE), list(DEMO,DISP.APP,DISP.INFO))
write.csv(displine,file="c:/RData/disp5.csv")

probate<-Reduce(function(x, y) merge(x, y, by="ID",all=TRUE), list(DEMO,PAR.ACT,PAR.PLA,PRO.CLASS))
write.csv(probate,file="c:/RData/prob5.csv")

employ<-Reduce(function(x, y) merge(x, y, by="ID",all=TRUE), list(DEMO,WORK))
write.csv(employ,file="c:/RData/employ5.csv")               

warrant<-Reduce(function(x, y) merge(x, y, by="ID",all=TRUE), list(DEMO,NDW))
write.csv(warrant,file="c:/RData/warr5.csv")

