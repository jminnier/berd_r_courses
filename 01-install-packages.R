
# This is an R script including R code to install packages we will use.
# You can run the entire script by clicking "Source" up above this textbox.
# Or, you can run each line by placing your cursor on the first line,
# and using the shortcut ctrl-enter (PC) or cmd-enter (mac)

# Even if you have these packages already installed, it's best to run this to update

# This is the first line of R code, you will see output in the console window
install.packages("pacman")

# This will likely take a long time to run if you do not have tidyverse installed
pacman::p_load(tidyverse, janitor, tinytex, update = TRUE)

# If you are asked
# "Do you want to install from sources the package which needs compilation? (Yes/no/cancel) "
# You can type no in the console


# For knitting to pdf
tinytex::install_tinytex()

# Test some installations by loading packages
library(tidyverse)
library(lubridate)
library(readxl)
library(janitor)
