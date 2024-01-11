"Arizona Department of Corrections, Rehabilitation & Reentry (ADCRR) Inmate Research"
"Differences Between Male & Female Inmates"
"June 13, 2023"
"Brenda Gary"

"Note: Infraction data sets only contain inmates that have received an infraction but does NOT include inmates that have received 0 infracs"

setwd("E:/AZData_Infractions")


"Load MasterStack_Infractions_Al5 into my workspace"
load(file = "E:/AZData_Infractions/Master_Stack_infractions_All5.RData")
# 1,074,949 observations & 5 variables

" Rename the data set"
infrac_5 <- Master_Stack_infractions_All5

#####
#summary(infrac_5)
# Violation.Date min 1/5/1990 & max 6/13/2019

#table(infrac_5$Infraction)
# There are 171 different infraction types

#table(infrac_5$Verdict)
# 17 blank, 9432 Dismiss-Counsel, 10634 Disms.-Proc.Err, 3682 Dismiss-Time frm, 392762 Guilty-Maj. Viol,
# 638005 Guilty-Min. viol, 3403 Infrml Resolutn, 16361 Not Glt-Maj.Vio, 606 Not Glt-Min. Vio, 
# 9 Not Referred, 36 Pending, 1 Refer Comm./DHO
#####
"/////////////////////////// Create the 'total number of infractions' variable ////////////////////////////////////////////////"

library(dplyr)

"Count the number of infractions committed by each inmate"
total_infractions <- infrac_5 %>% 
  group_by(ID) %>% 
  mutate(number_infractions = sum(!is.na(Infraction))) %>% 
  ungroup()
"1,074,949 observations & 6 variables"


"/////////////////////////// Condense 171 Infraction Types ////////////////////////////////////////////////"
library(forcats)

"Step 1: Convert the Infractions (character) to a Factor variable"
infrac_5$Infrac_Factor <- as.factor(infrac_5$Infraction) 


"Step 2: Collapse the 171 levels down to 14 infraction-type categories"
infrac_5$Infrac_Category <- fct_collapse(infrac_5$Infrac_Factor,
  Assault = c("AGGRAVATED ASSAULT ON I/M",	"AGGRAVATED ASSAULT ON STAFF",	"ASSAULT ON INMATE",	"ASSAULT ON STAFF",	"ASSAULT W/WEAPON",	"ASSLT STAFF THROWING SUBSTNCES",	"PHYSICAL ASSAULT",	"STRIKING  PERSON",	"STRIKING W/HARM"),
  Drugs_Alcohol = c("DRUG POS/MFG ETC",	"NARCOTICS POSS.",	"POSS/MANUF INTOXICTNG SUBSTNC",	"POSSESS DRUG PARAPHERNALIA",	"POSSESS DRUGS OR NARCOTICS",	"SELLING NARCOTIC",	"SMOKING MATERIALS",	"UNAUTHRZD SMOKING/TOBACCO USE"),
  Fighting = c("FIGHTING"),
  Order_Disobedience = c("ALTER APPEARANCE",	"ALTERING IDENTIFICATION",	"BEING ABSENT",	"COUNT DISRUPTN",	"DISOBEY VERBAL/WRITTEN ORDER",	"DISOBEYING ORDER",	"DISRUPT COUNT OR OUT OF PLACE",	"FAIL APPEARANCE",	"FAIL CLEANLINESS",	"FAIL TO CLEAN RM",	"FAIL TO DO WORK",	"FAIL TO OBEY ORD",	"FAIL TO REPORT",	"FAIL. OBEY RULES",	"FALSE REPORTING",	"GIVE/REC. TATTOO",	"HORSEPLAY",	"HORSEPLAYING",	"LYING TO OFFICIAL",	"MISUSE OF MAIL",	"MISUSE OF MEDICATION",	"MISUSE OF TELEPHONE",	"NOT IN AUTH AREA",	"OBSTRUCTING STAFF",	"POSITIVE OR REFUSAL OF U/A",	"POSS OF COMMUNICATION DEVICE",	"POSS. CONTRABAND",	"POSSESS NUISANCE CONTRABAND",	"POSSN CONTRABAND",	"PROMOT PRISON CONTRABAND",	"SMUGGLING CNTRBD",	"STAFF OBSTRUCTN",	"TATTOO,BRANDS,PIERCINGS,ETC.",	"THROWING ITEMS",	"THROWING OBJECTS",	"UNAUTH CONTACT",	"UNAUTH GATHERING",	"UNAUTH. JEWELRY",	"UNAUTHRZD ACCESS TO INTERNET",	"URIN/DEFC UNAUTH",	"USE PHONE/RADIO",	"VIO. FURLOUGH",	"VIO. GROOM RULE",	"VIO. VISIT. RGHT",	"VIOL OF DEPT/INST RULE",	"VIOL OF VISITATION RULES",	"VIOLATE GROOMING REQ'MNTS",	"VIOLATE RULES",	"VIOLATE SANITATION REQ'MNTS",	"VIOLATING LAWS",	"VIOLATION - MAIL",	"WEARING DISGUISE"),                           
  Other_Nonviolent = c("3 MINOR VIOL/90D",	"3 OR MORE VIO/90",	"BARTER/TRADE/SELL GOODS/SRVCS",	"BRIBERY",	"CARELESS BEHAVR.",	"CONSPIRACY GRP C",	"DEMONSTRATING",	"DISORDERLY CONDUCT",	"DISORDRLY CONDCT",	"DISRESPECT",	"DISRESPECT TO STAFF",	"ESCAPE",	"EXCES.POSS.ITEMS",	"EXCH. MONEY/PROP",	"FILING OF VEXATIOUS GRIEVANCE",	"FORGE/COUNTERFIT",	"FORGERY",	"FRAUD",	"GAMBLING",	"GAMBLING/POSS OF",	"GIVING FALSE DAT",	"HAND HOLDING",	"HARASSMENT",	"INFLUENCING A WITNESS",	"LITTERING",	"OBSCENE LANG/MAT",	"OFFERING A BRIBE",	"PART/PLAN DEMNST",	"SELL/TRADE SRVCS",	"SELLING PROTECT.",	"SMUGGLING",	"SOLICITING/FRAUD",	"STALKING I/M TO I/M",	"STALKING I/M TO STAFF",	"TAMPERING",	"TAMPERING W/PUBLIC RECORD",	"TAMPERING W/RESTRAINTS",	"TAMPERING W/SECURTY/SAFTY DEV",	"TRANSFER FUNDS",	"UNLAWFUL ASSEMBLY"),                             
  Other_Violent = c("ARSON",	"ATTEMPT TO COMMIT CL B FEL",	"ATTMPT TO COMMIT CLASS A FEL",	"CAUSE/SET A FIRE",	"CONSPIRACY GRP A",	"CONSPIRACY GRP B",	"CONSPIRACY TO COMMIT CL A FEL",	"CONSPIRACY TO COMMIT CL B FEL",	"DELIB. SET FIRE",	"HOMICIDE (NEGLIGENT)",	"INTENT DEATH/INJ",	"KIDNAPPING/HOSTAGE",	"MANSLAUGHTER",	"MURDER 1ST DEG",	"MURDER 2ND DEG",	"NEGLIGENT DEATH",	"TAKING A HOSTAGE"),   
  Property = c("CARLS. DEST.PROP",	"CARLS. OPER EQUP",	"CRIMINAL DAMAGE",	"DEST. PROP.<$100",	"DEST. PROP.>$100",	"EQUIP/MCH MISUSE",	"LOSS/DESTRC PROP",	"OPER UNAUTH TOOL",	"POSS. OF DEVICES",	"STEALING",	"TAMPER W/EQUIPMT",	"UNSAFE USE MACHINERY/EQUIPMNT"),
  Riot = c("PARTICIPATION IN A RIOT",	"RIOTING"),
  Sexual = c("ANY SEX ACT/STLK",	"ASSAULT (SEXUAL)",	"DISPLAY SEX EXPLICIT MATERIAL",	"INDECENT EXPOSUR",	"INDECENT EXPOSURE",	"SEX ASSAULT/VIOL",	"SEXUAL ASSAULT",	"SEXUAL CONTACT",	"SOLICITING SEX"),          
  Theft = c("THEFT/POSSESS STOLEN PROPERTY",	"THEFT/POSSN PROP"),    
  Threats = c("EXTORTION",	"EXTORTION/INTIMD",	"THREATEN HOMOSEX",	"THREATEN PERSON",	"THREATEN STAFF",	"THREATEN W/HARM",	"THREATEN W/WEAPN",	"THREATEN/INTIMIDATE(GANG)",	"THREATEN/INTIMIDATE(NON GANG)#",	"THREATENING OR INTIMIDATING",	"VERBALLY THREATN"),
  Weapons = c("POSS/MANUF WEAPN",	"POSSESSION OF A WEAPON",	"SHOOTING"),
  Work_Refusal = c("FEIGNING ILLNESS",	"MALINGERING",	"REFUSAL TO WORK",	"REFUSE PROGRAM OR JOB ASSIGN"),
  Blank = c(""))
            
"1,074,949 obs. & 7 vars."
#summary(infrac_5)
# 1st infra recorded: 1/5/1990 & last recorded: 6/13/2019

#table(infrac_5$Infrac_Collapse)
#There are 9 obs. listed in 'Blank' category

            
                                          
"//////////////////////// Remove Obs. That Have 'Blank' Infrac Info //////////////////////////////////////////////////////"
#There are 9 observations labeled as Blank -- Remove them
infrac_5.1 <- subset(infrac_5, Infrac_Category!= "Blank")
"1,074,940 obs. & 7 vars."

"////////////////////// Create Infraction Category Dummy Variables /////////////////////////////////////////////////"
"Can create interaction terms between (male x other_violent), etc. -- for future use"

infrac_5.1$assault <- ifelse(infrac_5.1$Infrac_Category == "Assault", 1, 0)
infrac_5.1$drugs_alcohol <- ifelse(infrac_5.1$Infrac_Category == "Drugs_Alcohol", 1, 0)
infrac_5.1$fighting <- ifelse(infrac_5.1$Infrac_Category == "Fighting", 1, 0)
infrac_5.1$order_disobedience <- ifelse(infrac_5.1$Infrac_Category == "Order_Disobedience", 1, 0)
infrac_5.1$other_nonviolent <- ifelse(infrac_5.1$Infrac_Category == "Other_Nonviolent", 1, 0)
infrac_5.1$other_violent <- ifelse(infrac_5.1$Infrac_Category == "Other_Violent", 1, 0)
infrac_5.1$property <- ifelse(infrac_5.1$Infrac_Category == "Property", 1, 0)
infrac_5.1$riot <- ifelse(infrac_5.1$Infrac_Category == "Riot", 1, 0)
infrac_5.1$sexual <- ifelse(infrac_5.1$Infrac_Category == "Sexual", 1, 0)
infrac_5.1$theft <- ifelse(infrac_5.1$Infrac_Category == "Theft", 1, 0)
infrac_5.1$threats <- ifelse(infrac_5.1$Infrac_Category == "Threats", 1, 0)
infrac_5.1$weapons <- ifelse(infrac_5.1$Infrac_Category == "Weapons", 1, 0)
infrac_5.1$work_refusal <- ifelse(infrac_5.1$Infrac_Category == "Work_Refusal", 1, 0)

"1,074,940 obs. & 20 vars."


" //////////////////// Save As R Data File //////////////////////////////////////////////////////////////////////"

"Rename the dataset"
Master_Infractions_frequencyANDcategories_dv <- infrac_5.1


"Save this Master File of the DemoSentenceCrime Data Set"
save(Master_Infractions_frequencyANDcategories_dv, file = "Master_Infractions_frequencyANDcategories_dv.Rdata")



