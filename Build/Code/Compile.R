#Compiles the five group saves of the web scrape and removes duplicated observations.
#Creates 5 RData files to be used for data building and analysis:
#  DEMO: Demographics
#  CLASS: Prisoner Classifications
#  CRIME: Offense and Sentencing Data
#  INFRACT: Infractions while being held data
#  PAROLE: Information on parole and also has release and enter dates
#  WORK: Data on work assignments while incarcerated

#Author: Jeremy Groves
#Date: January 16, 2024

rm(list=ls())

library(tidyverse)

#Read in Data to create ID list

load("./Build/Output/gary.RData")
  demo1<-DEMO
load("./Build/Output/gary2.RData")
  demo2<-DEMO
load("./Build/Output/gary3.RData")
  demo3<-DEMO
load("./Build/Output/gary4.RData")
  demo4<-DEMO
load("./Build/Output/gary5.RData")
  demo5<-DEMO

  
core.id <- rbind(demo1, demo2, demo3, demo4, demo5)
  
core.id <- core.id %>%
  distinct(ID, .keep_all = TRUE) %>%
  rename(Height = `Height (inches)`) %>%
  filter(Weight > 100.00,
         Height > 50)

save(core.id, file="./Build/Output/core_demo.RData")


#Classification

load("./Build/Output/gary.RData")
data1<-PRO.CLASS
load("./Build/Output/gary2.RData")
data2<-PRO.CLASS
load("./Build/Output/gary3.RData")
data3<-PRO.CLASS
load("./Build/Output/gary4.RData")
data4<-PRO.CLASS
load("./Build/Output/gary5.RData")
data5<-PRO.CLASS


core <- rbind(data1, data2, data3, data4, data5)
names(core) <- c("Date","Class","Cust.R","Inst.R","ID")

class <- core %>%
  filter(!is.na(Cust.R)) %>%
  filter(!is.na(Inst.R)) %>%
  distinct(ID, Date, Cust.R, Inst.R, .keep_all = TRUE)

save(class, file="./Build/Output/Class.RData")

#Commit and Sentencing Data

load("./Build/Output/gary.RData")
data1<-COMM
load("./Build/Output/gary2.RData")
data2<-COMM
load("./Build/Output/gary3.RData")
data3<-COMM
load("./Build/Output/gary4.RData")
data4<-COMM
load("./Build/Output/gary5.RData")
data5<-COMM


core <- rbind(data1, data2, data3, data4, data5)
names(core) <- c("Offense", "Sentence", "County", "Case_Num", "Date", "Status", "Crime", "Info", "Class",
                 "Rulling", "verified", "ID")
offend<-core %>%
  distinct(.keep_all = TRUE)

load("./Build/Output/gary.RData")
data1<-SENT
load("./Build/Output/gary2.RData")
data2<-SENT
load("./Build/Output/gary3.RData")
data3<-SENT
load("./Build/Output/gary4.RData")
data4<-SENT
load("./Build/Output/gary5.RData")
data5<-SENT

core <- rbind(data1, data2, data3, data4, data5)
names(core) <- c("Offense", "Sentence", "Admit.Date", "Consec_Concur", "Rele.Date", "Super.End", "Expire", "Max", "ID")

sent <- core %>%
  distinct(.keep_all = TRUE)


crime <- offend %>%
  left_join(., sent, by=c("ID", "Offense", "Sentence")) %>%
  distinct(.keep_all = TRUE)

save(crime, file="./Build/Output/Offense.RData")


#Infraction Appeals
#Does not appear to connect to infractions data below.

load("./Build/Output/gary.RData")
data1<-DISP.APP
load("./Build/Output/gary2.RData")
data2<-DISP.APP
load("./Build/Output/gary3.RData")
data3<-DISP.APP
load("./Build/Output/gary4.RData")
data4<-DISP.APP
load("./Build/Output/gary5.RData")
data5<-DISP.APP


core <- rbind(data1, data2, data3, data4, data5)
names(core) <- c("Date", "Outcome","Finding", "As.Of", "ID")


appeal <- core %>%
  distinct(.keep_all = TRUE)
save(appeal, file="./Build/Output/Appeal.RData")

#Infractions Data

load("./Build/Output/gary.RData")
data1<-DISP.INFO
load("./Build/Output/gary2.RData")
data2<-DISP.INFO
load("./Build/Output/gary3.RData")
data3<-DISP.INFO
load("./Build/Output/gary4.RData")
data4<-DISP.INFO
load("./Build/Output/gary5.RData")
data5<-DISP.INFO

core <- rbind(data1, data2, data3, data4, data5)
names(core) <- c("Viol.Date", "Infract","Verd.Date", "Verdict", "ID")

infract<-core %>%
  distinct(.keep_all=TRUE)
save(infract, file="./Build/Output/infractions.RData")

#Parole and Release Data
#This can help identify the entry and release dates.

load("./Build/Output/gary.RData")
data1<-PAR.PLA
load("./Build/Output/gary2.RData")
data2<-PAR.PLA
load("./Build/Output/gary3.RData")
data3<-PAR.PLA
load("./Build/Output/gary4.RData")
data4<-PAR.PLA
load("./Build/Output/gary5.RData")
data5<-PAR.PLA

core <- rbind(data1, data2, data3, data4, data5)
names(core) <- c("Cust.Date", "Type","Appr.Date", "Next","Class", "ID")

parole<-core %>%
  distinct(.keep_all=TRUE)

save(parole, file="./Build/Output/infractions.RData")

#Work Assignment Data

load("./Build/Output/gary.RData")
data1<-WORK
load("./Build/Output/gary2.RData")
data2<-WORK
load("./Build/Output/gary3.RData")
data3<-WORK
load("./Build/Output/gary4.RData")
data4<-WORK
load("./Build/Output/gary5.RData")
data5<-WORK

core <- rbind(data1, data2, data3, data4, data5)
names(core) <- c("Date", "Assign", "Work.Type", "Rating", "Hours", "Rate", "SP", "ID")

work<-core %>%
  distinct(.keep_all=TRUE)

save(work, file="./Build/Output/infractions.RData")

