## ----setup, include=FALSE----------------------------------------------------------------------
options(htmltools.dir.version = FALSE)

library(tidyverse)
library(lubridate)
library(janitor)
library(emo)
library(here)

knitr::opts_chunk$set(
  warning=FALSE, 
  message=FALSE, 
  #fig.width=10.5, 
  #fig.height=4,
  fig.align = "center",
  rows.print=7,
  echo=TRUE,
  highlight = TRUE,
  # prompt = TRUE, # IF TRUE adds a > before each code input
  # comment = NA # PRINTS IN FRONT OF OUTPUT, default is '##' which comments out output
  comment = '##'
  )

# set ggplot theme
# theme_set(theme_bw(base_size = 24))


## ----xaringan-themer, include = FALSE----------------------------------------------------------
# creates xaringan theme
# devtools::install_github("gadenbuie/xaringanthemer")
library(xaringanthemer)
mono_light(
  base_color =  "#3A6185", ## OHSU Marquam
  code_highlight_color = "#cbdded",
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


## ---- include=FALSE----------------------------------------------------------------------------
library(tidyverse)
library(janitor)
penguins <- read_csv(here::here("01-intro-r-eda","data","penguins.csv"))
mydata <- read_csv(here::here("01-intro-r-eda","data","yrbss.csv"))



## ----child=here::here("01-intro-r-eda","child_pipe_summaries.Rmd")-----------------------------

## ----------------------------------------------------------------------------------------------
penguins %>% head(n=3)      # prounounce %>% as "then"


## ---- eval=FALSE-------------------------------------------------------------------------------
## penguins %>% head(n=2) %>% summary()


## ----------------------------------------------------------------------------------------------
mean(penguins$body_mass_g)
median(penguins$body_mass_g)


## ----------------------------------------------------------------------------------------------
penguins %>%
  summarize(mean(body_mass_g), #<<
            median(body_mass_g)) #<<


## ----------------------------------------------------------------------------------------------
penguins %>%
  summarize(mean_mass = mean(body_mass_g), 
            mean_len = mean(bill_length_mm, na.rm = TRUE)) #<<


## ----------------------------------------------------------------------------------------------
# summary of all data as a whole
penguins %>% 
  summarize(mass_mean =mean(body_mass_g), #<<
            mass_sd = sd(body_mass_g),  #<<
            mass_cv = sd(body_mass_g)/mean(body_mass_g)) #<<


## ----------------------------------------------------------------------------------------------
# summary by group variable
penguins %>% 
  group_by(species) %>% #<<
  summarize(n_per_group = n(), 
            mass_mean =mean(body_mass_g),
            mass_sd = sd(body_mass_g),
            mass_cv = sd(body_mass_g)/mean(body_mass_g))


## ----------------------------------------------------------------------------------------------
penguins %>% 
  summarize(across(c(body_mass_g, bill_depth_mm), mean))


## ----------------------------------------------------------------------------------------------
penguins %>%
  summarize(across(where(is.numeric), mean, na.rm=TRUE))


## ----------------------------------------------------------------------------------------------
penguins %>% 
  summarize(across(c(body_mass_g, bill_depth_mm), 
                   c(m = mean, sd = sd))) #<<


## ----------------------------------------------------------------------------------------------
penguins %>%
  summarize(
    across(where(is.character), #<<
           n_distinct))


## ----------------------------------------------------------------------------------------------
penguins %>% count(island)


## ----------------------------------------------------------------------------------------------
penguins %>% count(species, island)


## ----------------------------------------------------------------------------------------------
# default table
penguins %>% tabyl(species)


## ----------------------------------------------------------------------------------------------
# output can be treated as tibble
penguins%>%tabyl(species)%>%select(-n)


## ----------------------------------------------------------------------------------------------
penguins %>% 
  tabyl(species) %>%
  adorn_totals("row") %>% #<<
  adorn_pct_formatting(digits=2)  #<<


## ----------------------------------------------------------------------------------------------
# default 2x2 table
penguins %>% 
  tabyl(species, sex) #<<


## ----------------------------------------------------------------------------------------------
penguins %>% tabyl(species, sex) %>% 
  adorn_percentages(denominator = "col") %>% #<<
  adorn_totals("row") %>% #<<
  adorn_pct_formatting(digits = 1) %>% #<<
  adorn_ns() #<<


## ----------------------------------------------------------------------------------------------
penguins %>% tabyl(species, island, sex)



## ----child=here::here("01-intro-r-eda","child_practice3.Rmd")----------------------------------

## ---- include = FALSE--------------------------------------------------------------------------
penguins %>% summarize(n_distinct(year))

penguins %>% count(year)

penguins %>% 
  group_by(species, sex) %>%
  summarize(median(body_mass_g))

penguins %>% tabyl(island, year)



## ----child=here::here("01-intro-r-eda","child_wrangling.Rmd")----------------------------------

## ----------------------------------------------------------------------------------------------
mydata %>% filter(bmi > 20)


## ---- eval=FALSE-------------------------------------------------------------------------------
## mydata %>% filter(age == "14 years old")
## mydata %>% filter(bmi/weight_kg < 0.5)    # can do math
## mydata %>% filter((bmi < 15) | (bmi > 25))
## mydata %>% filter(bmi < 20, weight_kg < 60, sex == "Female") # filter on multiple variables
## 
## mydata %>% filter(id == 923122)      # note the use of == instead of just =
## mydata %>% filter(sex == "Female")
## mydata %>% filter(!(grade == "9th"))
## mydata %>% filter(grade %in% c("10th", "11th"))
## 
## mydata %>% filter(is.na(bmi))
## mydata %>% filter(!is.na(bmi))


## ----------------------------------------------------------------------------------------------
mydata %>% select(id, grade)


## ---- eval=FALSE-------------------------------------------------------------------------------
## mydata %>% select(id:sex)
## mydata %>% select(one_of(c("age","weight_kg")))
## 
## mydata %>% select(-grade,-sex)
## mydata %>% select(-(id:sex))
## 
## mydata %>% select(contains("race"))
## mydata %>% select(starts_with("r"))
## mydata %>% select(-contains("r"))
## 
## mydata %>% select(id, race4, everything())


## ----------------------------------------------------------------------------------------------
mydata_new <- mydata %>% select(id:sex)
mydata_new


## ----------------------------------------------------------------------------------------------
# This does not save the new name
mydata %>% rename(record = id)


## ----------------------------------------------------------------------------------------------
mydata <- mydata %>% rename(record = id)
mydata


## ----------------------------------------------------------------------------------------------
newdata <- mydata %>% 
   mutate(height_m = sqrt(weight_kg / bmi))   # use = (not <- or ==) to define new variable

newdata %>% select(bmi, weight_kg, height_m)


## ---- eval=FALSE-------------------------------------------------------------------------------
## mydata %>% mutate(bmi_high = (bmi > 30))
## 
## mydata %>% mutate(male = (sex == "Male"))
## mydata %>% mutate(male = 1 * (sex == "Male"))
## 
## mydata %>% mutate(grade_num = as.numeric(str_remove(grade, "th")))



## ----child=here::here("01-intro-r-eda","child_practice3.Rmd")----------------------------------

## ---- include = FALSE--------------------------------------------------------------------------
penguins %>% summarize(n_distinct(year))

penguins %>% count(year)

penguins %>% 
  group_by(species, sex) %>%
  summarize(median(body_mass_g))

penguins %>% tabyl(island, year)



## ----child=here::here("01-intro-r-eda","child_wrangling2.Rmd")---------------------------------

## ---- eval=FALSE-------------------------------------------------------------------------------
## save(mydata, file = "data/mydata.RData")  # saving mydata within the data folder


## ---- eval=FALSE-------------------------------------------------------------------------------
## load("data/mydata.RData")


## ---- eval=FALSE-------------------------------------------------------------------------------
## write.csv(mydata, file = "data/mydata.csv", col.names = TRUE, row.names = FALSE)


## ----------------------------------------------------------------------------------------------
mydata %>% drop_na()


## ----------------------------------------------------------------------------------------------
data_dups <- tibble(
  name = c("Ana","Bob","Cara", "Ana"),
  race = c("Hispanic","Other", "White", "Hispanic")
)


## ----------------------------------------------------------------------------------------------
data_dups


## ----------------------------------------------------------------------------------------------
data_dups %>% distinct()


## ----------------------------------------------------------------------------------------------
mydata %>% arrange(bmi, weight_kg) %>% head(n=3)

mydata %>% arrange(desc(bmi), weight_kg) %>% head(n=3)


## ----------------------------------------------------------------------------------------------
mydata %>% 
  group_by(grade) %>% 
  summarize(n_per_group = n(), 
            bmi_mean =mean(bmi),
            bmi_sd = sd(bmi, na.rm = TRUE)) %>%
  mutate(bmi_cv = bmi_sd/bmi_mean) %>% #<<
  filter(bmi_cv > .2)  #<<



## ----child=here::here("01-intro-r-eda","child_ggplot.Rmd")-------------------------------------

## ---- out.height="400px"-----------------------------------------------------------------------
ggplot(data = penguins, 
       aes(x = flipper_length_mm, 
           y = bill_length_mm)) +
  geom_point() #<<


## ---- out.height="400px"-----------------------------------------------------------------------
ggplot(data = penguins, 
       aes(x = flipper_length_mm)) +
  geom_histogram() #<<


## ----scatter_nice, eval=FALSE------------------------------------------------------------------
## ggplot(data = penguins,
##        aes(x = flipper_length_mm,
##            y = bill_length_mm,
##            color = species)) + #<<
##   geom_point()+
##   labs( #<<
##     title = "Flipper and bill length",
##     subtitle = "Dimensions for Adelie, Chinstrap and Gentoo Penguins at Palmer Station LTER",
##     x = "Flipper length(mm)",
##     y = "Bill length(mm)") +
##   scale_color_viridis_d(name = "Penguin species") + #<<
##   theme_bw() #<<


## ----scatter_nice_out, ref.label="scatter_nice", echo=FALSE, fig.keep = "first"----------------


## ----hist_nice, eval=FALSE---------------------------------------------------------------------
## ggplot(data = penguins,
##        aes(x = flipper_length_mm,
##            fill = species)) + #<<
##   geom_histogram(
##     alpha = 0.5,
##     position = "identity") +
##   labs(title = "Penguin flipper length",
##        x = "Flipper length(mm)",
##        y = "Frequency") +
##   scale_fill_viridis_d( #<<
##     name = "Penguin species") + #<<
##   theme_minimal()


## ----hist_nice_out, ref.label="hist_nice", echo=FALSE, fig.keep = "first"----------------------


## ----box_nice, eval=FALSE----------------------------------------------------------------------
## ggplot(data = penguins,
##        aes(x = species,
##            y = flipper_length_mm)) +
##   geom_boxplot(color="darkgrey",
##                width = 0.3,
##                show.legend = FALSE) +
##   geom_jitter(aes(color = species),
##               alpha = 0.5,
##               show.legend = FALSE,
##               position = position_jitter(width = 0.2, seed = 0)) +
##   scale_color_manual(values = c("darkorange","purple","cyan4")) +
##   theme_minimal() +
##   labs(x = "Species",
##        y = "Flipper length (mm)")


## ----box_nice_out, ref.label="box_nice", echo=FALSE, fig.keep = "first"------------------------


## ---- out.height="400px"-----------------------------------------------------------------------
ggplot(data = penguins,
       aes(x = species, 
           fill = sex)) +
  geom_bar()


## ---- out.height="400px"-----------------------------------------------------------------------
ggplot(data = penguins,
       aes(x = species, 
           fill = sex)) +
  geom_bar(position = "dodge")


## ----bar_pct-----------------------------------------------------------------------------------
pct_data <- penguins %>% 
  count(species, sex) %>% 
  group_by(species) %>% 
  mutate(pct = 100*n/sum(n))
pct_data


## ---- out.height="380px"-----------------------------------------------------------------------
ggplot(data = pct_data, 
       aes(x = species, y = pct, 
           fill = sex)) +
  geom_col()+ #<<
  ylab("Percent")


## ----bar_pct_calc------------------------------------------------------------------------------
pct_data <- penguins %>% 
  count(species, sex) %>% 
  group_by(species) %>% 
  mutate(pct = 100*n/sum(n))
pct_data


## ---- out.height="380px"-----------------------------------------------------------------------
ggplot(data = pct_data, 
       aes(x = species, y = pct, 
           fill = sex)) +
  geom_col(position = "dodge") + #<<
  ylab("Percent")



## ----child=here::here("01-intro-r-eda","child_factors.Rmd")------------------------------------




## ----child=here::here("01-intro-r-eda","child_closing.Rmd")------------------------------------

## ---- eval = FALSE-----------------------------------------------------------------------------
## install.packages("dplyr")   # only do this ONCE, use quotes


## ----------------------------------------------------------------------------------------------
library(dplyr)    # run this every time you open Rstudio


## ----------------------------------------------------------------------------------------------
dplyr::arrange(mydata, bmi)


## ---- eval=FALSE-------------------------------------------------------------------------------
## install.packages("remotes")


## ---- eval=FALSE-------------------------------------------------------------------------------
## # https://github.com/hadley/yrbss
## remotes::install_github("hadley/yrbss")
## 
## # Load it the same way
## library(yrbss)


## ---- eval=FALSE, echo=FALSE-------------------------------------------------------------------
## # RUN THESE AFTER KNITTING
## knitr::purl(here::here("01-getting-started-v2","01_getting_started_slides.Rmd"),
##             out = here::here("01-getting-started-v2","01_getting_started_slides.R"))
## # remotes::install_github('rstudio/pagedown')
## pagedown::chrome_print(here::here("01-getting-started-v2","01_getting_started_slides.html"))



## ---- eval=FALSE, echo=FALSE-------------------------------------------------------------------
## # RUN THESE AFTER KNITTING
## knitr::purl(here::here("01-intro-r-eda","01_intro_r_eda_part2.Rmd"),
##             out = here::here("01-intro-r-eda","01_intro_r_eda_part2.R"))
## # remotes::install_github('rstudio/pagedown')
## pagedown::chrome_print(here::here("01-intro-r-eda","01_intro_r_eda_part2.html"))

