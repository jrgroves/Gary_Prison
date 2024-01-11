rm(list=ls())

library(xlsx)

for(i in seq(1:5)){
  
data<-load(paste0("./data/gary",i,".RData"))

data.1<-merge(COMM,SENT,by=c("ID","Commit#"),all=TRUE)
data.1<-merge(DEMO,data.1,by="ID",all=TRUE)
  data.1$Sentence<-NULL
  data.1$`Sentence yy/mm/dd.y`<-NULL
  c<-strsplit(data.1$`Sentence yy/mm/dd.x`,"/",fixed=TRUE)
  d<-as.data.frame(t(as.data.frame(c)))
    row.names(d)<-NULL
    names(d)<-c("Years","Months","Days")
    d$Years<-as.numeric(gsub(" Y","",d$Years))
    d$Months<-as.numeric(gsub(" M","",d$Months))
    d$Days<-as.numeric(gsub(" D","",d$Days))
    
  data.1<-cbind(data.1,d)
  
  
write.csv2(data.1,file=paste0("./data/gary",i,".csv"))

}