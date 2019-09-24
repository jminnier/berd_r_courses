## ----setup, include=FALSE------------------------------------------------
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
theme_set(theme_bw(base_size = 24))


## ----xaringan-themer, include = FALSE------------------------------------
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


## ----prompt = TRUE, comment = NA-----------------------------------------
7


## ----prompt = TRUE, comment = NA-----------------------------------------
3 + 5
"hello"

# this is a comment, nothing happens
# 5 - 8

# separate multiple commands with ;
3 + 5; 4 + 8


## ----prompt = TRUE, comment = NA-----------------------------------------
10^2
3 ^ 7
6/9
9-43


## ----prompt = TRUE, comment = NA-----------------------------------------
4^3-2* 7+9 /2


## ----prompt = TRUE, comment = NA-----------------------------------------
log(10)
log10(10)


## ----prompt = TRUE, comment = NA-----------------------------------------
exp(1)
exp(0)


## ----prompt = TRUE, comment = NA-----------------------------------------
log(exp(1))


## ----prompt = TRUE, comment = NA-----------------------------------------
mean(1:4)


## ----prompt = TRUE, comment = NA-----------------------------------------
seq(1,12,3)


## ----prompt = TRUE, comment = NA-----------------------------------------
mean(x = 1:4)


## ----prompt = TRUE, comment = NA-----------------------------------------
seq(from = 1, to = 12, by = 3)


## ----prompt = TRUE, comment = NA-----------------------------------------
x = 5
x
x <- 5
x


## ----prompt = TRUE, comment = NA-----------------------------------------
a <- 3:10
a


## ----prompt = TRUE, comment = NA-----------------------------------------
b <- c(5, 12, 2, 100, 8)
b


## ----prompt = TRUE, comment = NA-----------------------------------------
x <- 5
x

x + 3

y <- x^2
y


## ----prompt = TRUE, comment = NA-----------------------------------------
a <- 3:6
a

a+2; a*3

a*a


## ----prompt = TRUE, comment = NA-----------------------------------------
hi <- "hello"
hi

greetings <- c("Guten Tag", "Hola", hi)
greetings


## ----prompt = TRUE, comment = NA-----------------------------------------
x <- c(1, 2, NA, 5)
x
mean(x)
mean(x, na.rm=TRUE)


## ----prompt = TRUE, comment = NA-----------------------------------------
x <- c("a", "a", NA, "b")
table(x)
table(x, useNA = "always")


## ----prompt = TRUE, comment = NA-----------------------------------------
ls()


## ----prompt = TRUE, comment = NA-----------------------------------------
ls()
rm("greetings", hi)  # Can run with or without quotes
ls()


## ----prompt = TRUE, comment = NA-----------------------------------------
rm(list=ls())
ls()


## ----prompt = TRUE, comment = NA-----------------------------------------
3 + (2*6
)


## ----error=TRUE, echo=FALSE----------------------------------------------
# this is not a console example, since the console will prompt for more code with +
# 3 + (2*6


## ----error=TRUE, prompt = TRUE, comment = NA-----------------------------
hello


## ----error=TRUE, prompt = TRUE, comment = NA-----------------------------
install.packages(dplyr) # need install.packages("dplyr")


## ---- eval=FALSE---------------------------------------------------------
## y <- 5
## y


## ------------------------------------------------------------------------
df <- data.frame(
  IDs=1:3, 
  gender=c("male", "female", "Male"), 
  age=c(28, 35.5, 31),
  trt = c("control", "1", "1"),
  Veteran = c(FALSE, TRUE, TRUE)
  )
df


## ------------------------------------------------------------------------
str(df)


## ------------------------------------------------------------------------
df


## ------------------------------------------------------------------------
# Second row, Third column
df[2, 3]


## ------------------------------------------------------------------------
# Third column
df[, 3]


## ------------------------------------------------------------------------
# Second row
df[2,]


## ---- eval=FALSE---------------------------------------------------------
## mydata <- read.csv("data/yrbss_demo.csv")


## ---- echo=FALSE---------------------------------------------------------
mydata <- read.csv(here::here("01-getting-started-v2","data","yrbss_demo.csv"))


## ---- eval=FALSE---------------------------------------------------------
## View(mydata)
## # Can also view the data by clicking on its name in the Environment tab


## ------------------------------------------------------------------------
summary(mydata)


## ------------------------------------------------------------------------
dim(mydata)
nrow(mydata)
ncol(mydata)


## ------------------------------------------------------------------------
names(mydata)


## ------------------------------------------------------------------------
str(mydata)   # structure of data


## ------------------------------------------------------------------------
head(mydata)
head(mydata, 2)


## ------------------------------------------------------------------------
tail(mydata)


## ------------------------------------------------------------------------
mydata[, 6]


## ------------------------------------------------------------------------
mydata$bmi


## ----fig.height=2.5, fig.width=7-----------------------------------------
hist(mydata$bmi)


## ----fig.height=2.5, fig.width=7-----------------------------------------
hist(mydata$bmi, xlab = "BMI", main="BMIs of students")


## ----fig.height=5, fig.width=5-------------------------------------------
boxplot(mydata$bmi)


## ----fig.height=5, fig.width=5-------------------------------------------
boxplot(mydata$bmi ~ mydata$sex, 
  horizontal = TRUE, 
  xlab = "BMI", ylab = "sex",
  main = "BMIs of students by sex")


## ----fig.height=5, fig.width=5-------------------------------------------
plot(mydata$weight_kg, mydata$bmi)


## ----fig.height=5, fig.width=5-------------------------------------------
plot(mydata$weight_kg, mydata$bmi, 
   xlab = "weight (kg)", ylab = "BMI", 
   main = "BMI vs. Weight")


## ------------------------------------------------------------------------
summary(mydata$bmi)


## ------------------------------------------------------------------------
mean(mydata$bmi)
sd(mydata$bmi)


## ------------------------------------------------------------------------
min(mydata$bmi)
max(mydata$bmi)



## ------------------------------------------------------------------------
median(mydata$bmi)


## ------------------------------------------------------------------------
quantile(mydata$bmi, prob=c(0, .25, .5, .75, 1))  


## ------------------------------------------------------------------------
mydata$height_m <- sqrt( mydata$weight_kg / mydata$bmi)
mydata$height_m
dim(mydata); names(mydata)


## ------------------------------------------------------------------------
mydata[, c(2, 6)] # 2nd & 6th columns


## ------------------------------------------------------------------------
mydata[, c("age", "bmi")]


## ------------------------------------------------------------------------
mydata[mydata$age == "14 years old",]


## ------------------------------------------------------------------------
mydata[mydata$bmi < 19,]


## ------------------------------------------------------------------------
mydata[mydata$age == "15 years old", c("age", "grade", "race4")]


## ------------------------------------------------------------------------
mydata[mydata$bmi < 19, c("age", "sex", "bmi")]


## ---- eval=FALSE---------------------------------------------------------
## save(mydata, file = "data/mydata.RData")


## ---- eval=FALSE---------------------------------------------------------
## load("data/mydata.RData")


## ---- eval=FALSE---------------------------------------------------------
## write.csv(mydata, file = "data/mydata.csv", col.names = TRUE, row.names = FALSE)


## ---- eval = FALSE-------------------------------------------------------
## install.packages("dplyr")   # only do this ONCE, use quotes


## ------------------------------------------------------------------------
library(dplyr)    # run this every time you open Rstudio


## ------------------------------------------------------------------------
dplyr::arrange(mydata, bmi)


## ---- eval=FALSE---------------------------------------------------------
## install.packages("remotes")


## ---- eval=FALSE---------------------------------------------------------
## # https://github.com/hadley/yrbss
## remotes::install_github("hadley/yrbss")
## 
## # Load it the same way
## library(yrbss)


## ---- eval=FALSE, echo=FALSE---------------------------------------------
## # RUN THESE AFTER KNITTING
## knitr::purl(here::here("01-getting-started-v2","01_getting_started_slides.Rmd"),
##             out = here::here("01-getting-started-v2","01_getting_started_slides.R"))
## # remotes::install_github('rstudio/pagedown')
## pagedown::chrome_print(here::here("01-getting-started-v2","01_getting_started_slides.html"))

