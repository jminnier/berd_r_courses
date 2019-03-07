## ----setup, include=FALSE------------------------------------------------
options(htmltools.dir.version = FALSE)

library(tidyverse)

knitr::opts_chunk$set(
  warning=FALSE, 
  message=FALSE, 
  fig.width=10.5, 
  fig.height=4,
  fig.align = "center",
  rows.print=16,
  echo=TRUE,
  highlight = TRUE,
  prompt = TRUE, # IF TRUE adds a > before each code input
  comment=NA # PRINTS IN FRONT OF OUTPUT, default is '##' which comments out output
  #comment=NA
  )

theme_set(theme_bw(base_size = 24))

## ------------------------------------------------------------------------
7
3 + 5
"hello"

# this is a comment, nothing happens
# 5 - 8

## ------------------------------------------------------------------------
10^2
3 ^ 7
6/9
9-43

## ------------------------------------------------------------------------
4^3-2* 7+9 /2

## ------------------------------------------------------------------------
log(10)
log10(10)

## ------------------------------------------------------------------------
exp(1)
exp(0)

## ------------------------------------------------------------------------
log(exp(1))

## ------------------------------------------------------------------------
x = 5
x
x <- 5
x

## ------------------------------------------------------------------------
a <- 3:10
a

## ------------------------------------------------------------------------
b <- c(5, 12, 2, 100, 8)
b

## ------------------------------------------------------------------------
x <- 5
x

x + 3

y <- x^2
y

## ------------------------------------------------------------------------
a <- 3:6
a

a+2

a*3

a*a

## ------------------------------------------------------------------------
hi <- "hello"
hi

greetings <- c("Guten Tag", "Hola", hi)
greetings

## ------------------------------------------------------------------------
ls()

## ------------------------------------------------------------------------
ls()
rm("greetings", hi)  # Can run with or without quotes
ls()

## ------------------------------------------------------------------------
rm(list=ls())
ls()

## ------------------------------------------------------------------------
3 + (2*6
)

## ----error=TRUE, echo=FALSE----------------------------------------------
# this is not a console example, since the console will prompt for more code with +
# 3 + (2*6

## ----error=TRUE----------------------------------------------------------
hello

## ------------------------------------------------------------------------
df <- data.frame(IDs=1:3, 
                 gender=c("male", "female", "Male"), 
                 age=c(28, 35.5, 31),
                 trt = c("control", "1", "1"),
                 Veteran = c(FALSE, TRUE, TRUE))
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

## ------------------------------------------------------------------------
mydata <- read.csv(url("http://bit.ly/berd_data_csv"))

## ---- eval=FALSE---------------------------------------------------------
## View(mydata)
## # Can also view the data by clicking on its name in the Environment tab

## ------------------------------------------------------------------------
summary(mydata)

## ------------------------------------------------------------------------
dim(mydata)
nrow(mydata)
ncol(mydata)

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
hist(mydata$bmi, xlab = "BMI", main="BMI's of students")

## ----fig.height=5, fig.width=5-------------------------------------------
boxplot(mydata$bmi)

## ----fig.height=5, fig.width=5-------------------------------------------
boxplot(mydata$bmi ~ mydata$sex, 
  horizontal = TRUE, 
  xlab = "BMI", ylab = "sex",
  main = "BMI's of students by sex")

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

## ------------------------------------------------------------------------
save(mydata, file = "mydata.RData")

## ------------------------------------------------------------------------
load("mydata.RData")

## ------------------------------------------------------------------------
write.csv(mydata, file = "mydata.csv", col.names = TRUE, row.names = FALSE)

## ---- eval = FALSE-------------------------------------------------------
## # Install a package from CRAN (main package repository)
## install.packages("tidyverse") # only do this ONCE
## # Load the package
## library(tidyverse)

## ---- eval=FALSE---------------------------------------------------------
## install.packages("devtools") # only do this ONCE
## library(devtools)
## # Install a package from github (often in development, no testing)
## # https://github.com/hadley/yrbss
## install_github("hadley/yrbss")
## library(yrbss)

## ---- include=FALSE------------------------------------------------------
#knitr::purl("01-getting-started/01_getting_started_slides.Rmd", out = "01-getting-started/01_getting_started_slides.R")
#knitr::purl("01_getting_started_slides.Rmd")

