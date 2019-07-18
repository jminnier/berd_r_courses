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


## ---- eval=FALSE---------------------------------------------------------
## # Use a relative path, "relative to" the project folder
## read_csv("mydata.csv") # looks in .Rproj folder


## ---- eval=FALSE---------------------------------------------------------
## # From the .Rmd folder, move up one folder then down to the data folder
## mydata <- read_csv("../data/report3_nhanes_data.csv")


## ------------------------------------------------------------------------
here::here()


## ------------------------------------------------------------------------
here::here("data","mydatafile.csv")


## ------------------------------------------------------------------------
here::here("data","raw-data","mydatafile.csv")


## ------------------------------------------------------------------------
names(knitr::knit_engines$get())


## ---- eval=FALSE---------------------------------------------------------
## library(rmarkdown)
## render("report1.Rmd")
## 
## # Render in a directory
## render(here::here("report3","report3.Rmd"))
## 
## # Render a single format
## render("report1.Rmd", output_format = "html_document")
## 
## # Render multiple formats
## render("report1.Rmd", output_format = c("html_document", "pdf_document"))
## 
## # Render to a different file name or folder
## render("report1.Rmd",
##        output_format = "html_document",
##        output_file = "report1_2019_07_18.html")
## 


## ---- eval=FALSE---------------------------------------------------------
## # makes an R file report1.R in same director
## knitr::purl("report1.Rmd")
## 
## # Can be more specific with output
## knitr::purl(here::here("report3","report3.Rmd"), # Rmd location
##             out = here::here("report3","report3_code_only.R")) # R output location


## ---- eval=FALSE---------------------------------------------------------
## rmarkdown::render(
##   "myreport.Rmd",
##   params = #<<
##     list(data = "newfile.csv",
##          year = "2019",
##          printcode = FALSE),
##   output_file = "report2019_newfile.html"
## )


## ---- eval=FALSE, echo=FALSE---------------------------------------------
## # RUN THESE AFTER KNITTING
## knitr::purl(here::here("03-rmarkdown","03_rmarkdown_slides.Rmd"),
##             out = here::here("03-rmarkdown","03_rmarkdown.R"))
## # remotes::install_github('rstudio/pagedown')
## pagedown::chrome_print(here::here("03-rmarkdown/03_rmarkdown_slides.html"))

