# Arizona Department of Corrections, Rehabilitation & Reentry (ADCRR) Inmate Research
# Male vs. Female Inmates 
# May 26, 2023
# Brenda Gary


"//////////////////////// Load the DSC Data Set & Remove Irrelevant Variables /////////////////////////////////////////////////"
setwd("D:/PhD/Research!/Male_Female/Empirical/AZMergedDemoSentenceCrime_MF/Originals/gary_CopyCSV_MF")

"DEMO SENTENCE CRIME DATA"
load("D:/PhD/Research!/Male_Female/Empirical/AZMergedDemoSentenceCrime_MF/Originals/gary_CopyCSV_MF/Master_DSC_Final_v2iii.RData")
"555,730 observations & 55 variables"

" Rename the data set"
DSC <- Master_DSC_Final_v2iii

#summary(DSC)

"//////////////////////// Load the  Data Set /////////////////////////////////////////////////"
setwd("D:/PhD/Research!/AZData_Infractions")

"Load MasterStack_Infractions_Al5 into my workspace"
load(file = "D:/PhD/Research!/AZData_Infractions/Master_Infractions_NumberInfracs.RData")
"1,074,949 observations & 6 variables"

" Rename the data set"
infrac_5 <- Master_Infractions_NumberInfracs

#summary(infrac_5)
# num_infractions.1 -- min = 1
# num_infractions.1 -- max = 391
# num_infractions.1 -- median = 21.18
# num_infractions.1 -- NA's = 0
"//////////////////////// Merge the Data Set /////////////////////////////////////////////////"

"Update - 5/27/23"
# Left join to retain all rows from the "DSC.1" data set
merged_data <- merge(DSC, infrac_5, by = "ID", all.x = TRUE)
"4,536,030 obs. & 41 vars."

#summary(merged_data)
# number_infracs -- min = 1
# number_infracs -- max = 391
# number_infracs -- median = 26.35
# number_infracs -- NA's = 129,358
"There could be 129,358 obs. that have 0 infractions"

"//////////////////////// Add the 0 Infraction Obs. To Data Set /////////////////////////////////////////////////"
# Rename the merged data set
merged_data.1 <- merged_data 

# Replace missing values with 0's & 'None' for infraction type
merged_data.1$num_infractions.1 <- ifelse(is.na(merged_data.1$num_infractions.1), 0, merged_data.1$num_infractions.1)
merged_data.1$Infraction <- ifelse(is.na(merged_data.1$Infraction), "None", merged_data.1$Infraction)


#summary(merged_data.1)
# number_infracs -- min = 0
# number_infracs -- max = 391
# number_infracs -- median = 25.6
# number_infracs -- NA's = 0
"Now back to 0 NA's"

"//////////////////////// View the Merge the Data Set /////////////////////////////////////////////////"

table(infrac_5$num_infractions.1)
# 112 obs have 112 infractions, 113 obs. have 113 infractions, up to 391 obs. have 391 infractions. Why?

table(merged_data.1$num_infractions.1)
# There are 129,358 obs. that have 0 infractions , ie, none

"//////////////////////// Remove Duplicates /////////////////////////////////////////////////"
# Remove duplicate obs.
merged_data.2 <- unique(merged_data.1)
# Issues with removing dups -- no matter if I used the distinct or unique functions.
# Code does not run after letting "run" for 25 & 45 minutes, etc - a merged_data.2 data frame is not created.
# Why? File too large to remove all the dups? 

# Verify # of remaining unique obs.
nrow(merged_data.2)



