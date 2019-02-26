
# https://github.com/hadley/yrbss
# devtools::install_github("hadley/yrbss")

library(yrbss)
library(tidyverse)
library(openxlsx)

glimpse(survey)


# view(summarytools::dfSummary(survey))

mydata <- survey %>% select(record, age, sex, grade, race4, bmi, weight, q12, q31, qn24) %>%
  group_by(age, sex, grade, race4, q12, q31, qn24) %>%
  slice(3) %>%
  rename(id=record, 
         text_while_driving_30d = q12,
         smoked_ever = q31,
         bullied_past_12mo = qn24) %>%
  filter(!is.na(bmi)) %>%
  ungroup()


# view(summarytools::dfSummary(mydata))
# View(mydata)


set.seed(100)
mydata_sub <- mydata %>% sample_n(size = 20) %>% arrange(id)
# View(mydata_sub)

write_csv(mydata_sub, path = here::here("01-getting-started","data","yrbss20.csv"))
write_delim(mydata_sub, delim="\t", path = here::here("01-getting-started","data","yrbss20.txt"))
openxlsx::write.xlsx(mydata_sub, file = here::here("01-getting-started","data","yrbss20.xlsx"))
