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

#Commit Database

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


