## ----setup, include=FALSE------------------------------------------------
options(htmltools.dir.version = FALSE)

library(tidyverse)
library(lubridate)
library(janitor)

knitr::opts_chunk$set(
  warning=FALSE, 
  message=FALSE, 
  #fig.width=10.5, 
  #fig.height=4,
  fig.align = "center",
  rows.print=7,
  echo=TRUE,
  highlight = TRUE,
  prompt = FALSE, # IF TRUE adds a > before each code input
  comment = NA # PRINTS IN FRONT OF OUTPUT, default is '##' which comments out output
  )

# set ggplot theme
theme_set(theme_bw(base_size = 24))


## ----xaringan-themer, include = FALSE------------------------------------
# Use xaringan theme from first set


## ------------------------------------------------------------------------
# install.packages("tidyverse","janitor","glue")  
library(tidyverse)
library(lubridate)  
library(janitor)
library(glue)
demo_data <- read_csv("data/yrbss_demo.csv")
qn_data <- read_csv("data/yrbss_qn.csv")


## ------------------------------------------------------------------------
# mutate_all changes the data in all columns
demo_data %>% mutate_all(as.character) %>% head(2)


## ------------------------------------------------------------------------
# rename_all changes all column names
demo_data %>% rename_all(str_sub, end = 2) %>% head(3)


## ------------------------------------------------------------------------
# mutate_at changes the data in specified columns
demo_data %>% mutate_at(vars(contains("race"), sex), as.factor) %>% head(2)


## ------------------------------------------------------------------------
# rename_at changes specified column names
demo_data %>% rename_at(vars(record:grade),toupper) %>% head(3)


## ------------------------------------------------------------------------
demo_data %>% mutate_if(is.numeric, round, digits = 0) %>% head(3)


## ------------------------------------------------------------------------
demo_data %>% rename_if(is.character, str_sub, end = 2) %>% head(3)


## ------------------------------------------------------------------------
demo_data %>% add_row(record=100, age=NA, sex="Female", grade="9th") %>% #<<
  arrange(record) %>% head(3)


## ------------------------------------------------------------------------
demo_data %>% add_row(record=100:102, bmi=c(25,30,18)) %>% #<<
  arrange(record) %>% head(3)


## ------------------------------------------------------------------------
demo_data %>% add_column(study_date = "2019-04-10", .after="record") %>% #<<
  head(3)


## ------------------------------------------------------------------------
demo_data %>% add_column(id = 1:nrow(demo_data), .before="record") %>% #<<
  head(3)


## ------------------------------------------------------------------------
# default table
demo_data %>% tabyl(grade)


## ------------------------------------------------------------------------
# output can be treated as tibble
demo_data %>% tabyl(grade) %>% select(-n)


## ------------------------------------------------------------------------
demo_data %>%
  tabyl(grade) %>%
  adorn_totals("row") %>% #<<
  adorn_pct_formatting(digits=2)  #<<


## ------------------------------------------------------------------------
# default 2x2 table
demo_data %>% tabyl(grade, sex)


## ------------------------------------------------------------------------
demo_data %>% tabyl(grade, sex) %>%
  adorn_percentages(denominator = "col") %>% #<<
  adorn_totals("row") %>% #<<
  adorn_pct_formatting(digits = 1) %>% #<<
  adorn_ns() #<<


## ------------------------------------------------------------------------
# summary of all data as a whole
demo_data %>% 
  summarize(bmi_mean =mean(bmi,na.rm=TRUE), #<<
            bmi_sd = sd(bmi,na.rm=TRUE)) #<<


## ------------------------------------------------------------------------
# summary by group variable
demo_data %>% 
  group_by(grade) %>% #<<
  summarize(n_per_group = n(), 
            bmi_mean =mean(bmi,na.rm=TRUE),
            bmi_sd = sd(bmi,na.rm=TRUE))


## ---- echo=FALSE---------------------------------------------------------
data1 <- tibble(id = 1:2, name = c("Nina","Yi"), height=c(2, 1), age=c(4,2))
data2 <- tibble(id = 7:9, name = c("Bo","Al","Juan"), height=c(2, 1.7, 1.8), years=c(3,1,2))


## ------------------------------------------------------------------------
data1


## ------------------------------------------------------------------------
data2


## ------------------------------------------------------------------------
bind_rows(data1,data2, .id = "group") #<< 


## ------------------------------------------------------------------------
# datasets must have same number of rows to use bind_cols()
demo_sub <- demo_data %>% slice(1:20) # first 20 rows of demo_data
qn_sub <- qn_data %>% slice(1:20)     # first 20 rows of qn_data
bind_cols(demo_sub, qn_sub)           # blindly bind columns; 2nd record column got renamed #<<   


## ---- results="hold"-----------------------------------------------------
df1 <- tibble(a = c(1, 2), b = 2:1)
df2 <- tibble(a = c(1, 3), c = 10:11)
df1
df2


## ------------------------------------------------------------------------
left_join(df1, df2)


## ------------------------------------------------------------------------
colnames(demo_data)
colnames(qn_data)
intersect(colnames(demo_data), colnames(qn_data)) #<<


## ------------------------------------------------------------------------
merged_data <- 
  full_join(demo_data, qn_data, 
            by = "record")

# Check dimensions of original and new datasets


## ------------------------------------------------------------------------
dim(demo_data); dim(qn_data); dim(merged_data) 


## ------------------------------------------------------------------------
merged_data


## ---- include=FALSE------------------------------------------------------
qn_data2 <- qn_data %>% add_column(qn_yes = 1)
all_data <- left_join(demo_data, qn_data2)
all_data %>% tabyl(qn_yes)
all_data %>% tabyl(qn_yes,grade)


## ------------------------------------------------------------------------
BP_wide <- tibble(id = letters[1:4],
                     sex = c("F", "M", "M", "F"),
                     SBP_v1 = c(130, 120, 130, 119),
                     SBP_v2 = c(110, 116, 136, 106),
                     SBP_v3 = c(112, 122, 138, 118))
BP_wide


## ------------------------------------------------------------------------
BP_wide


## ------------------------------------------------------------------------
BP_long <- BP_wide %>% 
  gather(key = "visit", value = "SBP", 
         SBP_v1:SBP_v3)
BP_long


## ------------------------------------------------------------------------
BP_long


## ------------------------------------------------------------------------
BP_wide2 <- BP_long %>% 
  spread(key = "visit", value = "SBP")
BP_wide2


## ------------------------------------------------------------------------
BP_long


## ------------------------------------------------------------------------
BP_long2 <- BP_long %>% 
  mutate(visit = 
           str_replace(visit,"SBP_v","")) 
BP_long2


## ------------------------------------------------------------------------
head(BP_long2, 2)
BP_wide3 <- BP_long2 %>% 
  spread(key = "visit", value = "SBP")
BP_wide3


## ------------------------------------------------------------------------
BP_wide4 <- BP_long2 %>% 
  spread(key = "visit", value = "SBP",
         sep="_") # specify separating character
BP_wide4


## ------------------------------------------------------------------------
DBP_wide <- tibble(id = letters[1:4],
                  sex = c("F", "M", "M", "F"),
                  v1.DBP = c(88, 84, 102, 70),
                  v2.DBP = c(78, 78, 96, 76),
                  v3.DBP = c(94, 82, 94, 74),
                  age=c(23, 56, 41, 38)
                  )


## ---- include=FALSE------------------------------------------------------
DBP_long <- DBP_wide %>%
  gather(key = "visit", value = "DBP", 
         v1.DBP, v2.DBP, v3.DBP) %>%
  mutate(visit = 
           str_replace(visit,c("v"), "")) %>%
  mutate(visit = 
           str_replace(visit,".DBP",""))  
DBP_long

DBP_wide2 <- DBP_long %>% 
  spread(key = "visit", value = "DBP",
         sep=".") # specify separating character
DBP_wide2


BP_both_long <- left_join(BP_long2, DBP_long, by = c("id", "sex", "visit"))
BP_both_long


## ------------------------------------------------------------------------
mydata <- tibble(id = 7:9, 
                 name = c("Bo","Al","Juan"), 
                 height = c(2, NA, 1.8), 
                 years = c(51,35,NA))
mydata


## ------------------------------------------------------------------------
mydata %>% drop_na()


## ------------------------------------------------------------------------
mydata %>% drop_na(height)


## ------------------------------------------------------------------------
mydata


## ------------------------------------------------------------------------
mydata %>% 
  mutate(height = replace_na(height, "Unknown"), #<<
         years = replace_na(years, 0) ) #<<


## ------------------------------------------------------------------------
qn_data %>% 
  mutate_at(vars(starts_with("q")), #<<
            .funs = list(~replace_na(.,"No answer"))) %>% #<<
  tabyl(q8, q31)


## ------------------------------------------------------------------------
all_data %>% tabyl(race4)
all_data %>%
  mutate(race4 = na_if(race4, "All other races")) %>% #<<
  tabyl(race4)


## ---- eval=FALSE---------------------------------------------------------
## smalldata <- read_csv("data/small_data.csv",
##                       na = c("","9999","NA")) # specify your own missing values #<<


## ---- eval=FALSE---------------------------------------------------------
## # replace all "" with NA
## all_data %>%
##   mutate_if(is.character, .funs = na_if(.,"")) #<<
## 
## # replace all 9999's with NA
## all_data %>%
##   mutate_if(is.numeric, .funs = na_if(.,9999)) #<<


## ------------------------------------------------------------------------
mydata <- tibble(name = c("J.M.","Ella","Jay"), state = c("New Mexico","New York","Oregon"))


## ------------------------------------------------------------------------
mydata %>% filter(str_detect(name,"J"))       


## ------------------------------------------------------------------------
mydata %>% mutate(
  new_state = str_detect(state,"New"))    


## ------------------------------------------------------------------------
mydata %>% mutate(state_old = str_replace_all(state, "New", "Old"))


## ------------------------------------------------------------------------
mydata %>% mutate(
  name2 = str_replace(name, "l", "-"),           # first instance
  name3 = str_replace_all(name, "l", "-"),       # all instances
  name4 = str_replace_all(name, fixed("."), "")) # special characters with fixed()


## ------------------------------------------------------------------------
mydata %>% mutate(
  short_name  = str_sub(name, start = 1, end = 2),   # specify start to end
  short_name2 = str_sub(name, end = 2),              # specify only end
  short_state = str_sub(state, end = -3)             # negative endices, from end
  )


## ------------------------------------------------------------------------
all_data %>%
  mutate(info = glue("Student {record} is {age} with BMI = {round(bmi,1)}")) %>% #<<
  select(record, info) %>% head(5)


## ------------------------------------------------------------------------
demo_data %>% 
  group_by(sex) %>%
  summarize(n_sex = n(),
            bmi_mean = mean(bmi,na.rm=TRUE),
            bmi_sd = sd(bmi,na.rm=TRUE)) %>%
  mutate(bmi_mean_se = glue("{round(bmi_mean,1)} ({signif(bmi_sd/sqrt(n_sex),2)})")) #<<


## ------------------------------------------------------------------------
timedata <- 
 tibble(name = c("Yi","Bo","DJ"), 
        dob=c("10/31/1952","1/12/1984","2/02/2002"))
timedata %>% 
  mutate(dob_date = mdy(dob),
         dob_wrong = dmy(dob)) # wrong order


## ------------------------------------------------------------------------
timedata %>% mutate(
  dob = mdy(dob),                            # convert to a date
  dob_year = year(dob),                      # extract the year
  time_since_birth = dob %--% today(),       # create an "interval"
  age = time_since_birth %/% years(1),       # modulus on "years"
  dobplus = dob + days(10)                   # add 10 days
  )                  


## ------------------------------------------------------------------------
mydata <- tibble(
  id = 1:4, 
  grade=c("9th","10th","11th","9th")) %>%
  mutate(grade_fac = factor(grade)) #<<
levels(mydata$grade_fac)
mydata %>% arrange(grade_fac)


## ------------------------------------------------------------------------
mydata <- mydata %>% 
  mutate(
    grade_fac = #<<
      fct_relevel(grade_fac, #<<
                  c("9th","10th","11th"))) #<<
levels(mydata$grade_fac)
mydata %>% arrange(grade_fac)


## ------------------------------------------------------------------------
mydata <- tibble(loc = c("SW","NW","NW","NE","SE","SE"))

mydata %>% mutate(
  loc_fac = factor(loc),
  loc2 = fct_collapse(loc_fac,                         # collapse levels #<<
                      south = c("SW","SE"), #<<
                      north = c("NE","NW")), #<<
  loc3 = fct_lump(loc_fac, n=2, other_level = "other") # most common 2 levels + other
  )


## ------------------------------------------------------------------------
mydata <- tibble("First Name"= c("Yi","DJ"), "last init" = c("C","R"),
                 "% in" = c(0.1, 0.5), "ñ$$$"= 1:2, " "=3:2,"     hi"=c("a","b"), 
                 "null"=c(NA,NA))
mydata
mydata %>% clean_names() %>%        # in the janitor package #<<
  remove_empty(c("rows","cols"))    # also useful


## ------------------------------------------------------------------------
library(readxl)
read_excel("data/messy_names.xlsx", .name_repair = janitor::make_clean_names)


## ------------------------------------------------------------------------
messy_data <- tibble(NAME = c("J N","A C","D E"), 
                     `months follow up` = c("", 10, 11), 
                     `Date of visit` = c("July 31, 2003", "Nov 12, 2005", "Aug 3, 2007"))


## ---- echo=FALSE---------------------------------------------------------
clean_data <- messy_data %>% 
  clean_names() %>%
  mutate(
    months_follow_up = replace_na(months_follow_up,""),
    months_follow_up = as.numeric(months_follow_up),
    date_of_visit = mdy(date_of_visit),
    date_last_visit = date_of_visit + months(months_follow_up)) %>%
  drop_na(months_follow_up) %>%
  mutate(name = str_replace_all(name," ",""))


## ---- eval=FALSE, echo=FALSE---------------------------------------------
## # RUN THESE AFTER KNITTING
## # create R file
## knitr::purl(here::here("02-data-wrangling-tidyverse/02_data_wrangling_slides_part2.Rmd"), out = here::here("02-data-wrangling-tidyverse/02_data_wrangling_slides_part2.R"))
## # remotes::install_github('rstudio/pagedown')
## pagedown::chrome_print(here::here("02-data-wrangling-tidyverse/02_data_wrangling_slides_part2.html"))

