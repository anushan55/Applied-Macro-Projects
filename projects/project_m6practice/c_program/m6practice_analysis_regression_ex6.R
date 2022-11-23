# TARGET: 
# INDATA: 
# OUTDATA/ OUTPUT:

################################################################################################################+
# INTRO	script-specific ####

#clear gobal environment of all but uppercase objects (globals, myfunctions, scalars)
CLEARCOND()

#adapt scriptname/ rfilename and extension if NOT executed in batch mode
MAINNAME_check <- rstudioapi::getActiveDocumentContext()$path #returns path+name of script currently executed (no outsourcing to program possible)
if ( !grepl("00_execute",MAINNAME_check)) {
  MAINNAME <- sub(".*/|^[^/]*$", "", MAINNAME_check)
  MAINNAME <- substr(MAINNAME,1,nchar(MAINNAME)-2) #cut off .R
}
######################+
#release unused memory 
gc()

################################################################################################################+
# MAIN PART ####

#Load scenario 1 
df<-LOAD(dfinput=paste0(DFBASE,"_ex6_Education parents"),pattdir=A)
colnames(df)

colnames(df)<-(sub("m6practice_databasics_ex6_Education.parents.edu_parents", "edu_parents",colnames(df)))
colnames(df)<-sub("m6practice_databasics_ex6_Education.parents.edu", "edu",colnames(df))
colnames(df)<-sub("m6practice_databasics_ex6_Education.parents.u", "u",colnames(df))
colnames(df)<-sub("m6practice_databasics_ex6_Education.parents.income", "income",colnames(df))
colnames(df)<-sub("m6practice_databasics_ex6_Education.parents.ADMIN_ID", "ADMIN_ID",colnames(df))

#df<-read_dta(paste0(A,"GoodBad_Control (simulated) - Education parents.dta"))


# run regression equation - Scenario 1 
s1_reg1<- lm(income ~ edu, data = df)
s1_reg2<- lm(income ~ edu+edu_parents, data = df)
summary (s1_reg1) 
summary(s1_reg2)

#Load scenario 2 
df<-LOAD(dfinput=paste0(DFBASE,"_ex6_age"),pattdir=A)

colnames(df)

# run regression equation - Scenario 2 
s2_reg1<- lm(income ~ edu, data = df)
s2_reg2<- lm(income ~ edu+age, data = df)
summary (s2_reg1) 
summary(s2_reg2)

#Load scenario 3 
df<-LOAD(dfinput=paste0(DFBASE,"_ex6_WorkType Blue or White"),pattdir=A)

colnames(df)

colnames(df)<-(sub("m6practice_databasics_ex6_WorkType.Blue.or.White.edu", "edu",colnames(df)))
colnames(df)<-sub("m6practice_databasics_ex6_WorkType.Blue.or.White.work_type", "work_type",colnames(df))
colnames(df)<-sub("m6practice_databasics_ex6_WorkType.Blue.or.White.u", "u",colnames(df))
colnames(df)<-sub("m6practice_databasics_ex6_WorkType.Blue.or.White.income", "income",colnames(df))
colnames(df)<-sub("m6practice_databasics_ex6_WorkType.Blue.or.White.ADMIN_ID", "ADMIN_ID",colnames(df))



# run regression equation - Scenario 3 
s3_reg1<- lm(income ~ edu, data = df)
s3_reg2<- lm(income ~ edu+work_type, data = df)
summary (s3_reg1) 
summary(s3_reg2)

#Load scenario 4
df<-LOAD(dfinput=paste0(DFBASE,"_ex6_Interest in Politics"), pattdir=A)

colnames(df)

colnames(df)<-sub("m6practice_databasics_ex6_Interest.in.Politics.edu", "edu", colnames(df))
colnames(df)<-sub("m6practice_databasics_ex6_Interest.in.Politics.ability_unobs" , "ability_unobs", colnames(df))
colnames(df)<-sub("m6practice_databasics_ex6_Interest.in.Politics.interest_politics", "interest_politics", colnames(df))
colnames(df)<-sub("m6practice_databasics_ex6_Interest.in.Politics.u", "u",colnames(df))
colnames(df)<-sub("m6practice_databasics_ex6_Interest.in.Politics.income", "income",colnames(df))
colnames(df)<-sub("m6practice_databasics_ex6_Interest.in.Politics.ADMIN_ID", "ADMIN_ID",colnames(df))



# run regression equation - Scenario 4 
s4_reg1<- lm(income ~ edu, data = df)
s4_reg2<- lm(income ~ edu+interest_politics, data = df)
summary (s4_reg1) 
summary(s4_reg2)


#Load scenario 5
df<-LOAD(dfinput=paste0(DFBASE,"_ex6_happiness schooling income"), pattdir=A)

colnames(df)

colnames(df)<-sub("m6practice_databasics_ex6_happiness.schooling.income.schooling", "schooling",colnames(df))
colnames(df)<-sub("m6practice_databasics_ex6_happiness.schooling.income","income", colnames(df))
colnames(df)<-sub("m6practice_databasics_ex6_happiness.schooling.income.u" ,"u",colnames(df))
colnames(df)<-sub("m6practice_databasics_ex6_happiness.schooling.income.happiness", "happiness",colnames(df))
colnames(df)<-sub("m6practice_databasics_ex6_happiness.schooling.income.ADMIN_ID", "ADMIN_ID",colnames(df))



# run regression equation - Scenario 5
s5_reg1<- lm(income.happiness~schooling, data = df)
s5_reg2<- lm(income.happiness~schooling+income.income, data = df)
summary (s5_reg1) 
summary(s5_reg2)

#export
stargazer(s1_reg1,s1_reg2,type="text")
stargazer(s2_reg1,s2_reg2,type="text")
stargazer(s3_reg1,s3_reg2,type="text")
stargazer(s4_reg1,s4_reg2,type="text")
stargazer(s5_reg1,s5_reg2,type="text")

stargazer(s1_reg1,s1_reg2,
          s2_reg1,s2_reg2,
          s3_reg1,s3_reg2,
          s4_reg1,s4_reg2, type= "text")



