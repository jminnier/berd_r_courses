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
  #comment=NA
  )

# set ggplot theme
theme_set(theme_bw(base_size = 24))

## ----xaringan-themer, include = FALSE------------------------------------
# creates xaringan theme
# devtools::install_github("gadenbuie/xaringanthemer")
library(xaringanthemer)
mono_light(
  base_color =  "#3A6185", ## OHSU Marquam
  code_highlight_color = "#c0e8f5",
  link_color = "#38BDDE",
  header_font_google = google_font("Josefin Sans"),
  text_font_google   = google_font("Montserrat", "300", "300i","400i","700"),
  code_font_google   = NULL,
  text_font_size = "24px",
  code_font_size = "20px",
  header_h1_font_size = "45px",
  header_h2_font_size = "40px",
  header_h3_font_size = "35px",
  padding = "0em 2em 1em 2em",
  outfile = "css/xaringan-themer.css"
)

## ---- eval=FALSE---------------------------------------------------------
## y <- iris %>% count(Species)
## y

## ------------------------------------------------------------------------
data.frame(name = c("Sarah","Ana","Jose"), 
           rank = 1:3,
           age = c(35.5, 25, 58),
           city = c(NA,"New York","LA"))

## ------------------------------------------------------------------------
tibble(name = c("Sarah","Ana","Jose"), 
       rank = 1:3,
       age = c(35.5, 25, 58),
       city = c(NA,"New York","LA"))

## ------------------------------------------------------------------------
mydata_df <- read.csv("data/small_data.csv")
mydata_df

## ------------------------------------------------------------------------
mydata_tib <- read_csv("data/small_data.csv")
mydata_tib

## ---- results=FALSE------------------------------------------------------
mydata <- read_csv("data/small_data.csv")
mydata
glimpse(mydata)
str(mydata)
head(mydata)
summary(mydata)
class(mydata)

## ------------------------------------------------------------------------
untidy_data <- tibble(
  name = c("Ana","Bob","Cara"),
  wt_07_01_2018 = c(100, 150, 140),
  wt_08_01_2018 = c(104, 155, 138),
  wt_09_01_2018 = c(NA, 160, 142)
)
untidy_data

## ------------------------------------------------------------------------
untidy_data %>% gather(key = "date", value = "weight", -name) %>%
  mutate(date = str_remove(date,"wt_"),
         date = dmy(date))

## ------------------------------------------------------------------------
untidy_data <- tibble(
  name = c("Ana","Bob","Cara"),
  meds = c("advil 500mg 2xday","tylenol 1000mg 1xday", "advil 200mg 3xday")
)
untidy_data

## ------------------------------------------------------------------------
untidy_data %>% 
  separate(col = meds, into = c("med_name","dose_mg","times_per_day"), sep=" ") %>%
  mutate(times_per_day = as.numeric(str_remove(times_per_day, "xday")),
         dose_mg = as.numeric(str_remove(dose_mg, "mg")))

## ---- eval=FALSE---------------------------------------------------------
## h(g(f(mydata)))

## ---- eval=FALSE---------------------------------------------------------
## fout <- f(mydata)
## gout <- g(fout)
## h(gout)

## ---- eval=FALSE---------------------------------------------------------
## mydata %>%
##   f() %>%
##   g() %>%
##   h()

## ------------------------------------------------------------------------
mydata_new <- mydata %>% select(id, weight_kg, bmi) %>%
  mutate(height_m = sqrt(weight_kg /bmi))
mydata_new %>% head(n=3)

## ---- results=FALSE------------------------------------------------------
demo_data <- read_csv("data/yrbss_demo.csv")
qn_data <- read_csv("data/yrbss_qn.csv")

glimpse(demo_data)
glimpse(qn_data)

## ---- eval = FALSE-------------------------------------------------------
## select(.data = demo_data, "record")
## select(demo_data, "record")
## select(demo_data, record)
## demo_data %>% select(record)

## ---- echo = FALSE-------------------------------------------------------
demo_data %>% select(record)

## ------------------------------------------------------------------------
demo_data %>% filter(bmi > 20)

## ------------------------------------------------------------------------
demo_data[demo_data$grade=="9th",]

## ------------------------------------------------------------------------
demo_data %>% filter(grade=="9th")

## ---- eval=FALSE---------------------------------------------------------
## demo_data %>% filter(record==506901)
## demo_data %>% filter(sex=="Male")
## demo_data %>% filter(grade %in% c("10th","11th"))
## demo_data %>% filter(!(grade=="9th"))
## demo_data %>% filter(bmi < 20, stweight < 50, sex=="Female") # filter on multiple
## demo_data %>% filter(is.na(bmi))
## demo_data %>% filter(!is.na(bmi))
## demo_data %>% filter(bmi < 5)
## demo_data %>% filter(bmi/stweight < 0.5) # can do math
## demo_data %>% filter((bmi<15)|(bmi>50))

## ------------------------------------------------------------------------
demo_data %>% select(record, grade)

## ------------------------------------------------------------------------
demo_data[, c("record","age","sex")]

## ---- results="hold"-----------------------------------------------------
demo_data %>% select(record, age, sex)
demo_data %>% select(record:sex)

## ---- eval=FALSE---------------------------------------------------------
## demo_data %>% select(-grade,-sex)
## demo_data %>% select(record:sex)
## demo_data %>% select(-(record:sex))
## demo_data %>% select(contains("race"))
## demo_data %>% select(record, race4, race7, everything())
## demo_data %>% select(one_of(c("age","stweight")))
## demo_data %>% select(starts_with("r"))
## demo_data %>% select(-contains("r"))
## demo_data %>% select(1:3)

## ------------------------------------------------------------------------
demo_data %>% rename(id = record)

## ----eval=FALSE----------------------------------------------------------
## demo_data %>% select_if(is.numeric)
## demo_data %>% rename_if(is.character, toupper) # toupper() is a function
## demo_data %>% rename_all(toupper)
## demo_data %>% rename_at(vars(contains("race")), toupper)
## demo_data %>% rename_if(is.numeric, funs(paste0(.,"_num")))

## ---- include=FALSE------------------------------------------------------
newdata <- demo_data %>%
  rename_all(toupper) %>%
  select_if(is.character) %>%
  filter(RACE7%in%c("Asian","Native Hawaiin/other PI"), GRADE=="9th") %>%
  filter(AGE!="12 years old or younger") %>%
  select(-RACE4)
dim(newdata)

## ------------------------------------------------------------------------
newdata <- demo_data %>% 
  select(record, bmi:stweight) %>%
  mutate(height_m = sqrt(stweight /bmi))
newdata

## ---- eval=FALSE---------------------------------------------------------
## demo_data %>% mutate(bmi_high = bmi > 30)
## demo_data %>% mutate(male = 1*(sex=="Male"))
## demo_data %>% mutate(grade_num = as.numeric(str_remove(grade,"th")))

## ------------------------------------------------------------------------

demo_data2 <- demo_data %>%
  mutate(
    age_int = case_when(
      age=="12 years old or younger" ~ 12,
      age=="18 years old or older" ~ 18,
      TRUE ~ as.numeric(str_remove(age, " years old"))
  ))
demo_data2 %>% tabyl(age,age_int)

## ------------------------------------------------------------------------
demo_data %>% distinct()

## ------------------------------------------------------------------------
demo_data %>% na.omit()

## ---- eval=FALSE, echo=FALSE---------------------------------------------
## # RUN THESE AFTER KNITTING
## knitr::purl(here::here("02-data-wrangling-tidyverse/02_data_wrangling_slides.Rmd"), out = here::here("02-data-wrangling-tidyverse/02_data_wrangling_slides.R"))
## pagedown::chrome_print(here::here("02-data-wrangling-tidyverse/02_data_wrangling_slides.Rmd"))

