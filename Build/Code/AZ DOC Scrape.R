rm(list=ls())

#load Libraries
library(rvest)
library(stringr)
library(plyr)

inmate<-c(80038,286975:330000)

#load the base URL
  url.1<-"https://inmatedatasearch.azcorrections.gov/PrintInmate.aspx?ID="


#Scrape Code
  
    for(IDS in inmate){
  
   #Load any outside data to guide search or generate data to guide search
    url.2<-str_pad(IDS,6,pad="0")

    #read URL into R

    html.1<-read_html(paste0(url.1,url.2))

    data<-html.1 %>%
      html_nodes("table") %>%
      html_table(fill=TRUE)

    n<-length(data)
  
    if(n<=6) next #stops loop if there is not sufficient lines to have DEMO data
  
    #Create the DEMO, COMM, and SENT datafiles
    ID<-as.data.frame(data[[4]])
    ID<-as.numeric(gsub("Inmate ","",ID[2,]))
  
    demo<-as.data.frame(data[[5]])
    demo$ID<-ID
  
    x<-6:10
      for(val in x){
        b<-as.data.frame(data[[val]])
        demo<-cbind(demo,b)
        rm(b)
      }
  
  ifelse(url.2==str_pad(inmate[1],6,pad="0"),DEMO<-demo,DEMO<-rbind(DEMO,demo))
  
  if(n<12) next
  
  x<-12:n
  for(val in x){
    c<-as.data.frame(data[[val]])
    c$ID<-ID
    
    ifelse(names(c[1,])[1]=="Commit#" & ncol(c)==12,comm<-c,
         ifelse(names(c[1,])[1]=="Commit#" & ncol(c)==9,sent<-c,
                ifelse(names(c[1,])[1]=="Violation Date",disp.info<-c,
                       ifelse(names(c[1,])[1]=="Appeal Date",disp.app<-c,
                              ifelse(names(c[1,])[1]=="Complete Date",pro.class<-c,
                                     ifelse(names(c[1,])[1]=="Hearing Date",par.act<-c,
                                            ifelse(names(c[1,])[1]=="Custody Date",par.pla<-c,
                                                   ifelse(names(c[1,])[1]=="Eval Date",work<-c,
                                                          ifelse(names(c[1,])[1]=="Detainer Date",ndw<-c,next)))))))))

  }

  l1<-c("comm","sent","disp.info","disp.app","pro.class","par.act","par.pla","work","ndw")
  l2<-c("COMM","SENT","DISP.INFO","DISP.APP","PRO.CLASS","PAR.ACT","PAR.PLA","WORK","NDW")
  
  x<-1:length(l1)
  for(val in x){
    ifelse(url.2==str_pad(inmate[1],6,pad="0"),
      ifelse(exists(eval(l1[val])) && is.data.frame(get(eval(l1[val])))==TRUE,
             assign(eval(l2[val]),get(l1[val])),
             next),
      ifelse(exists(eval(l1[val])) && is.data.frame(get(eval(l1[val])))==TRUE,
             assign(eval(l2[val]),rbind(get(l2[val]),get(l1[val]))),
             next))
  }

rm(ID)
}


save.image(file="c:/RData/gary5.RData")


