# Arizona Department of Corrections, Rehabilitation & Reentry (ADCRR) Inmate Research
# Differences Between Male & Female Inmates
# April 14, 2023
# Brenda Gary


setwd("D:/PhD/Research!/AZData_Infractions")


"Load MasterStack_Infractions_Al5 into my workspace"
load(file = "D:/PhD/Research!/AZData_Infractions/Master_Stack_infractions_All5.RData")
# 1,074,949 observations & 5 variables

" Rename the data set"
infrac_5 <- Master_Stack_infractions_All5


summary(infrac_5)
# Violation.Date min 1/5/1990 & max 6/13/2019


table(infrac_5$Infraction)
# There are 171 different infraction types


table(infrac_5$Verdict)
# 17 blank, 9432 Dismiss-Counsel, 10634 Disms.-Proc.Err, 3682 Dismiss-Time frm, 392762 Guilty-Maj. Viol,
# 638005 Guilty-Min. viol, 3403 Infrml Resolutn, 16361 Not Glt-Maj.Vio, 606 Not Glt-Min. Vio, 
# 9 Not Referred, 36 Pending, 1 Refer Comm./DHO

# /////////////////////////// Create the 'total number of infractions' variable /////////////////////////////////////////////////////////////////////////////

library(dplyr)

"Count the number of infractions committed by each inmate"
total_infractions <- infrac_5 %>% 
  group_by(ID) %>% 
  mutate(num_infractions.1 = sum(!is.na(Infraction))) %>% 
  ungroup()
"1,074,949 observations & 6 variables"

" //////////////////// Save As R Data File //////////////////////////////////////////////////////////////////////"

"Rename the dataset"
Master_Infractions_NumberInfracs <- total_infractions


"Save this Master File of the DemoSentenceCrime Data Set"
save(Master_Infractions_NumberInfracs, file = "Master_Infractions_NumberInfracs.RData")



