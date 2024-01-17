#Script to compile release and classification for all prisoners

#Author: Jeremy Groves
#Date: January 17, 2024

rm(list=ls())
library(tidyverse)


#load data
load("./Build/Output/core_demo.RData")
load("./Build/Output/Class.RData")
load("./Build/Output/par_rel.RData")


core <- core.id %>%
  select(`Last Name`, `First Name`, ID) %>%
  distinct(.keep_all = TRUE)

rel <- parole %>%
  filter(Class == "R" | Type == "INITIAL CL.") %>%
  distinct(.keep_all = TRUE) %>%
  mutate(Date = as.Date(Cust.Date, format="%m/%d/%Y"))  %>%
  arrange(ID, Date) %>%
  mutate(IN = case_when(Type == "INITIAL CL." ~ 1,
                        TRUE ~ 0)) %>%
  group_by(ID) %>%
  mutate(period = cumsum(IN),
         date2 = lag(Date),
         dur = Date - date2) %>%
  select(-c(Appr.Date, Next)) %>%
  filter(period != 0)     #This removes cases where we have the exit date, but not entry date for that period

#Merging with prisoner classification data

temp <- class %>%
  mutate(Class.Date = as.Date(Date, format="%m/%d/%Y"),
         Date = Class.Date - 1) %>%
  right_join(rel, ., by=c("ID", "Date")) %>%
  filter(!is.na(Type))

temp2 <- class %>%
  mutate(Date = as.Date(Date, format="%m/%d/%Y")) %>%
  right_join(rel, ., by=c("ID", "Date")) %>%
  filter(!is.na(Type))



