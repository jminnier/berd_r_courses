
# This is an R script including R code to install packages we will use.
# You can run the entire script by clicking "Source" up above this textbox.
# Or, you can run each line by placing your cursor on the first line,
# and using the shortcut ctrl-enter (PC) or cmd-enter (mac)

# Even if you have these packages already installed, it's best to run this to update

# This is the first line of R code, you will see output in the console window
install.packages("pacman")

# Orange/red colored messages are ok! Ignore the output unless you see "Error"

# We are installing the pacman package which we will use to install more packages.

# This will likely take a long time to run if you do not have tidyverse installed
# or haven't updated in a while
pacman::p_load(tidyverse, 
               janitor, 
               rmarkdown, update = TRUE)

# If you are asked
# "Do you want to install from sources the package which needs compilation? (Yes/no/cancel) "
# You can type "no" (without quotes) in the console window, and press enter

# If you are asked "do you want to use your own personal library" or something to that effect, say "yes"

# *OPTIONAL* 
# For knitting to pdf, you may want to install a tex client
pacman::p_load(tinytex)
tinytex::install_tinytex()



