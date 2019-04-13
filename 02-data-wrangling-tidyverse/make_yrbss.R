
# https://github.com/hadley/yrbss
# devtools::install_github("hadley/yrbss")

library(yrbss)
library(tidyverse)
library(openxlsx)

glimpse(survey)


# summarytools::view(summarytools::dfSummary(survey))

mydata <- survey %>% 
  select(record, age, sex, grade, race4, race7, bmi, 
                            stweight, q8, q12, q31, qn24) %>%
  group_by(age, sex, grade, race7, q8, q12, q31, qn24) %>%
  slice(1:10) %>% ungroup() %>%
  mutate_if(is.factor,as.character)
set.seed(5)
mydata <- mydata %>% sample_n(20000)

mydata %>% tabyl(age)

demo_data <- mydata %>% 
  select(record:stweight)


demo_data2 <- demo_data %>%
  mutate(
    age_int = case_when(
      age=="12 years old or younger" ~ 12,
      age=="18 years old or older" ~ 18,
      TRUE ~ as.numeric(str_replace(age, " years old",""))
  ))
demo_data2 %>% tabyl(age,age_int)

# mutate take th off of grade
# calculate height from bmi and weight
# make new age
# dichotomize bmi

set.seed(10)
qn_data <- mydata %>%
  select(record, q8:qn24) %>%
  sample_n(10000)

qn_data %>%
  rename(how_often_bicycle_helmet = q8,
         text_while_driving_30d = q12,
         smoked_ever = q31,
         bullied_past_12mo = qn24)

alldata <- left_join(demo_data, qn_data)

# view(summarytools::dfSummary(mydata))
# View(mydata)

write_csv(demo_data, path = here::here("02-data-wrangling-tidyverse","data","yrbss_demo.csv"))
write_delim(demo_data, delim="\t", path = here::here("02-data-wrangling-tidyverse","data","yrbss_demo.txt"))
openxlsx::write.xlsx(demo_data, file = here::here("02-data-wrangling-tidyverse","data","yrbss_demo.xlsx"))

write_csv(qn_data, path = here::here("02-data-wrangling-tidyverse","data","yrbss_qn.csv"))
