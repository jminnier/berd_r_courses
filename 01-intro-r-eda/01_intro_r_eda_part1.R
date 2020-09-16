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


## ----child=here::here("01-intro-r-eda","child_intro.Rmd")--------------------------------------

## ---- eval = FALSE-----------------------------------------------------------------------------
## # only do this ONCE, use quotes
## install.packages("dplyr")


## ----------------------------------------------------------------------------------------------
# keep in Rmd
# run every time you open Rstudio
library(dplyr)    



## ----child=here::here("01-intro-r-eda","child_console.Rmd")------------------------------------

## ----prompt = TRUE, comment = NA---------------------------------------------------------------
10^2
3 ^ 7
6/9
9-43


## ----prompt = TRUE, comment = NA---------------------------------------------------------------
4^3-2* 7+9 /2


## ----prompt = TRUE, comment = NA---------------------------------------------------------------
x = 5
x
x <- 5
x


## ----prompt = TRUE, comment = NA---------------------------------------------------------------
a <- 3:10
a


## ----prompt = TRUE, comment = NA---------------------------------------------------------------
b <- c(5, 12, 2, 100, 8)
b


## ----prompt = TRUE, comment = NA---------------------------------------------------------------
x <- 5
x

x + 3

y <- x^2
y


## ----prompt = TRUE, comment = NA---------------------------------------------------------------
a <- 3:6
a

a+2; a*3

a*a


## ----prompt = TRUE, comment = NA---------------------------------------------------------------
hi <- "hello"
hi

greetings <- c("Guten Tag", "Hola", hi)
greetings


## ----prompt = TRUE, comment = NA---------------------------------------------------------------
mean(x = 1:4)


## ----prompt = TRUE, comment = NA---------------------------------------------------------------
seq(from = 1, to = 12, by = 3)
seq(by = 3, to = 12, from = 1)


## ----prompt = TRUE, comment = NA---------------------------------------------------------------
mean(1:4)


## ----prompt = TRUE, comment = NA---------------------------------------------------------------
seq(1,12,3)


## ----prompt = TRUE, comment = NA---------------------------------------------------------------
3 + (2*6
)


## ----error=TRUE, echo=FALSE--------------------------------------------------------------------
# this is not a console example, since the console will prompt for more code with +
# 3 + (2*6


## ----error=TRUE, prompt = TRUE, comment = NA---------------------------------------------------
hello


## ----error=TRUE, prompt = TRUE, comment = NA---------------------------------------------------
install.packages(dplyr) # need install.packages("dplyr")



## ----child=here::here("01-intro-r-eda","child_rmd.Rmd")----------------------------------------

## ---- eval=FALSE-------------------------------------------------------------------------------
## y <- 5
## y



## ----child=here::here("01-intro-r-eda","child_practice1.Rmd")----------------------------------

## ----eval=FALSE--------------------------------------------------------------------------------
## install.packages("tidyverse")
## install.packages("janitor")


## ---- eval=FALSE-------------------------------------------------------------------------------
## library(tidyverse)
## library(janitor)



## ----child=here::here("01-intro-r-eda","child_data_load.Rmd")----------------------------------

## ----------------------------------------------------------------------------------------------
library(tidyverse)
library(janitor)


## ---- eval=FALSE-------------------------------------------------------------------------------
## penguins <- read_csv("penguins.csv")


## ---- echo=FALSE-------------------------------------------------------------------------------
penguins <- read_csv(here::here("01-intro-r-eda","data","penguins.csv"))
mydata <- read_csv(here::here("01-intro-r-eda","data","yrbss.csv"))


## ---- eval=FALSE-------------------------------------------------------------------------------
## View(penguins)     # Run in console
## # Can also view the data by clicking on its name in the Environment tab


## ----------------------------------------------------------------------------------------------
penguins


## ----------------------------------------------------------------------------------------------
glimpse(penguins)   # structure of data


## ----------------------------------------------------------------------------------------------
summary(penguins)


## ----------------------------------------------------------------------------------------------
penguins


## ---- eval = FALSE-----------------------------------------------------------------------------
## View(penguins)


## ----------------------------------------------------------------------------------------------
dim(penguins)
nrow(penguins)
ncol(penguins)


## ----------------------------------------------------------------------------------------------
names(penguins)


## ----------------------------------------------------------------------------------------------
head(penguins)


## ----------------------------------------------------------------------------------------------
tail(penguins)


## ----------------------------------------------------------------------------------------------
head(penguins, 3)
tail(penguins, 1)


## ----------------------------------------------------------------------------------------------
# Second row, Third column
penguins[2, 3]


## ----------------------------------------------------------------------------------------------
# Second row
penguins[2,]


## ----------------------------------------------------------------------------------------------
# Third column
penguins[, 3]



## ----child=here::here("01-intro-r-eda","child_dollarsign.Rmd")---------------------------------

## ----------------------------------------------------------------------------------------------
penguins[, 4]


## ----------------------------------------------------------------------------------------------
penguins$bill_length_mm


## ----fig.height=2.5, fig.width=7---------------------------------------------------------------
hist(penguins$bill_length_mm)


## ----fig.height=2.5, fig.width=7---------------------------------------------------------------
hist(penguins$bill_length_mm, xlab = "Length (mm)", main="Penguin bills")


## ----fig.height=5, fig.width=5-----------------------------------------------------------------
boxplot(penguins$bill_length_mm)


## ----fig.height=5, fig.width=5-----------------------------------------------------------------
boxplot(penguins$bill_length_mm ~ 
          penguins$sex, 
  horizontal = TRUE, 
  xlab = "Length (mm)", ylab = "Sex",
  main = "Penguin bills by sex")


## ----fig.height=5, fig.width=5-----------------------------------------------------------------
plot(penguins$flipper_length_mm, 
     penguins$bill_length_mm)


## ----fig.height=5, fig.width=5-----------------------------------------------------------------
plot(penguins$flipper_length_mm, 
     penguins$bill_length_mm, 
   xlab = "Flipper", ylab = "Bill", 
   main = "Bill vs. flipper length")


## ----------------------------------------------------------------------------------------------
summary(penguins$flipper_length_mm)


## ----------------------------------------------------------------------------------------------
mean(penguins$flipper_length_mm)
sd(penguins$flipper_length_mm)


## ----------------------------------------------------------------------------------------------
min(penguins$flipper_length_mm)
max(penguins$flipper_length_mm)



## ----------------------------------------------------------------------------------------------
median(penguins$flipper_length_mm)


## ----------------------------------------------------------------------------------------------
quantile(penguins$flipper_length_mm, prob=c(0, .25, .5, .75, 1))  


## ----------------------------------------------------------------------------------------------
mean(penguins$bill_length_mm)


## ----------------------------------------------------------------------------------------------
mean(penguins$bill_length_mm, 
     na.rm = TRUE) #<<


## ----------------------------------------------------------------------------------------------
summary(penguins$bill_length_mm)



## ----child=here::here("01-intro-r-eda","child_practice2.Rmd")----------------------------------




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



## ---- eval=FALSE, echo=FALSE-------------------------------------------------------------------
## # RUN THESE AFTER KNITTING
## knitr::purl(here::here("01-intro-r-eda","01_intro_r_eda_part1.Rmd"),
##             out = here::here("01-intro-r-eda","01_intro_r_eda_part1.R"))
## # remotes::install_github('rstudio/pagedown')
## pagedown::chrome_print(here::here("01-intro-r-eda","01_intro_r_eda_part1.html"))

