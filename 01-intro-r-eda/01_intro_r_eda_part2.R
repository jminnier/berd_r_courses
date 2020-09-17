## ----setup, include=FALSE-----------------------------------------------------------------------
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


## ----xaringan-themer, include = FALSE-----------------------------------------------------------
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


## ---- include=FALSE-----------------------------------------------------------------------------
library(tidyverse)
library(janitor)
penguins <- read_csv(here::here("01-intro-r-eda","data","penguins.csv"))
mydata <- read_csv(here::here("01-intro-r-eda","data","yrbss.csv"))



## ---- eval = FALSE------------------------------------------------------------------------------
## library(tidyverse)
## library(janitor)
## penguins <- read_csv("penguins")


## ----child=here::here("01-intro-r-eda","child_pipe_summaries.Rmd")------------------------------

## -----------------------------------------------------------------------------------------------
penguins %>% head(n=3)      # prounounce %>% as "then"


## ---- eval=FALSE--------------------------------------------------------------------------------
## penguins %>% head(n=2) %>% summary()


## -----------------------------------------------------------------------------------------------
mean(penguins$body_mass_g)
median(penguins$body_mass_g)


## -----------------------------------------------------------------------------------------------
penguins %>%
  summarize(mean(body_mass_g), #<<
            median(body_mass_g)) #<<


## -----------------------------------------------------------------------------------------------
penguins %>%
  summarize(mean_mass = mean(body_mass_g), 
            mean_len = mean(bill_length_mm, na.rm = TRUE)) #<<


## -----------------------------------------------------------------------------------------------
# summary of all data as a whole
penguins %>% 
  summarize(mass_mean =mean(body_mass_g), #<<
            mass_sd = sd(body_mass_g),  #<<
            mass_cv = sd(body_mass_g)/mean(body_mass_g)) #<<


## -----------------------------------------------------------------------------------------------
# summary by group variable
penguins %>% 
  group_by(species) %>% #<<
  summarize(n_per_group = n(), 
            mass_mean =mean(body_mass_g),
            mass_sd = sd(body_mass_g),
            mass_cv = sd(body_mass_g)/mean(body_mass_g))


## -----------------------------------------------------------------------------------------------
penguins %>% 
  summarize(across(c(body_mass_g, bill_depth_mm), mean))


## -----------------------------------------------------------------------------------------------
penguins %>%
  summarize(across(where(is.numeric), mean, na.rm=TRUE))


## -----------------------------------------------------------------------------------------------
penguins %>% 
  summarize(across(c(body_mass_g, bill_depth_mm), 
                   c(m = mean, sd = sd))) #<<


## -----------------------------------------------------------------------------------------------
penguins %>%
  summarize(
    across(where(is.character), #<<
           n_distinct))


## -----------------------------------------------------------------------------------------------
penguins %>% count(island)


## -----------------------------------------------------------------------------------------------
penguins %>% count(species, island)


## -----------------------------------------------------------------------------------------------
# default table
penguins %>% tabyl(species)


## -----------------------------------------------------------------------------------------------
# output can be treated as tibble
penguins%>%tabyl(species)%>%select(-n)


## -----------------------------------------------------------------------------------------------
penguins %>% 
  tabyl(species) %>%
  adorn_totals("row") %>% #<<
  adorn_pct_formatting(digits=2)  #<<


## -----------------------------------------------------------------------------------------------
# default 2x2 table
penguins %>% 
  tabyl(species, sex) #<<


## -----------------------------------------------------------------------------------------------
penguins %>% tabyl(species, sex) %>% 
  adorn_percentages(denominator = "col") %>% #<<
  adorn_totals("row") %>% #<<
  adorn_pct_formatting(digits = 1) %>% #<<
  adorn_ns() #<<


## -----------------------------------------------------------------------------------------------
penguins %>% tabyl(species, island, sex)



## ----child=here::here("01-intro-r-eda","child_practice3.Rmd")-----------------------------------

## ---- include = FALSE---------------------------------------------------------------------------
penguins %>% summarize(n_distinct(year))

penguins %>% count(year)

penguins %>% 
  group_by(species, sex) %>%
  summarize(median(body_mass_g))

penguins %>% tabyl(island, year)



## ----child=here::here("01-intro-r-eda","child_wrangling.Rmd")-----------------------------------

## -----------------------------------------------------------------------------------------------
penguins %>% filter(bill_length_mm > 55)


## ---- eval=FALSE--------------------------------------------------------------------------------
## penguins %>% filter(island == "Torgersen")
## penguins %>% filter(bill_length_mm/bill_depth_mm > 3)    # can do math
## penguins %>% filter((body_mass_g < 3000) | (body_mass_g > 6000))
## 
## # filter on multiple variables:
## penguins %>% filter(body_mass_g < 3000, bill_depth_mm < 20, sex == "female")
## penguins %>% filter(body_mass_g < 3000 & bill_depth_mm < 20 & sex == "female")
## penguins %>% filter(body_mass_g < 3000 | bill_depth_mm < 20 | sex == "female")
## 
## penguins %>% filter(year == 2008)      # note the use of == instead of just =
## penguins %>% filter(sex == "female")
## 
## penguins %>% filter(!(species == "Adelie"))
## penguins %>% filter(species %in% c("Chinstrap", "Gentoo"))
## 
## penguins %>% filter(is.na(sex))
## penguins %>% filter(!is.na(sex))


## -----------------------------------------------------------------------------------------------
penguins %>% select(id, island, species, body_mass_g)


## ---- eval=FALSE--------------------------------------------------------------------------------
## penguins %>% select(id:bill_length_mm)
## 
## penguins %>% select(where(is.character))
## penguins %>% select(where(is.numeric))
## 
## penguins %>% select(-id,-species)
## penguins %>% select(-(id:island))
## 
## penguins %>% select(contains("bill"))
## penguins %>% select(starts_with("s"))
## penguins %>% select(-contains("mm"))
## 


## -----------------------------------------------------------------------------------------------
penguins %>% relocate(year, body_mass_g)


## ---- eval=FALSE--------------------------------------------------------------------------------
## penguins %>% relocate(species:bill_length_mm)
## 
## penguins %>% relocate(where(is.character))
## penguins %>% relocate(where(is.numeric))
## 
## penguins %>% relocate(flipper_length_mm,.before = bill_length_mm)
## penguins %>% relocate(species, .after = island)
## penguins %>% relocate(species, .after = last_col())


## -----------------------------------------------------------------------------------------------
penguins_sub <- penguins %>% select(id:island, sex)
penguins_sub


## -----------------------------------------------------------------------------------------------
penguins <- penguins %>% 
   mutate(bill_ratio = bill_length_mm / bill_depth_mm)   #<<
# use = (not <- or ==) to define new variable

penguins %>% select(bill_ratio, bill_length_mm, bill_depth_mm)


## ---- eval=FALSE--------------------------------------------------------------------------------
## penguins <- penguins %>% mutate(bill_long = (bill_length_mm > 45))
## 
## penguins <- penguins %>% mutate(male = (sex == "male"))
## penguins <- penguins %>% mutate(male2 = 1 * (sex == "male"))


## -----------------------------------------------------------------------------------------------
# This does not save the new name
penguins %>% rename(record = id)


## -----------------------------------------------------------------------------------------------
penguins <- penguins %>% #<<
    rename(record = id)
penguins



## ----child=here::here("01-intro-r-eda","child_practice4.Rmd")-----------------------------------




## ----child=here::here("01-intro-r-eda","child_ggplot.Rmd")--------------------------------------

## ---- out.height="400px"------------------------------------------------------------------------
ggplot(data = penguins, 
       aes(x = flipper_length_mm, 
           y = bill_length_mm)) +
  geom_point() #<<


## ---- out.height="400px"------------------------------------------------------------------------
ggplot(data = penguins, 
       aes(x = flipper_length_mm)) +
  geom_histogram() #<<


## ----scatter_nice, eval=FALSE-------------------------------------------------------------------
## ggplot(data = penguins,
##        aes(x = flipper_length_mm,
##            y = bill_length_mm,
##            color = species)) + #<<
##   geom_point()+
##   labs( #<<
##     title = "Flipper & bill length",
##     subtitle = "Palmer Station LTER",
##     x = "Flipper length(mm)",
##     y = "Bill length(mm)") +
##   scale_color_viridis_d( #<<
##     name = "Penguin species") +
##   theme_bw() #<<


## ----scatter_nice_out, ref.label="scatter_nice", echo=FALSE, fig.keep = "first"-----------------


## ----hist_nice, eval=FALSE----------------------------------------------------------------------
## ggplot(data = penguins,
##        aes(x = flipper_length_mm,
##            fill = species)) + #<<
##   geom_histogram(
##     alpha = 0.5,
##     position = "identity") +
##   labs(
##     title = "Flipper length",
##     x = "Flipper length(mm)",
##     y = "Frequency") +
##   scale_fill_viridis_d( #<<
##     name = "Penguin species") + #<<
##   theme_minimal()


## ----hist_nice_out, ref.label="hist_nice", echo=FALSE, fig.keep = "first"-----------------------


## ----box_nice, eval=FALSE-----------------------------------------------------------------------
## ggplot(data = penguins,
##        aes(x = species,
##            y = flipper_length_mm)) +
##   geom_boxplot(color="darkgrey",
##                width = 0.3,
##                show.legend = FALSE) +
##   geom_jitter(
##     aes(color = species),
##     alpha = 0.5,
##     show.legend = FALSE,
##     position = position_jitter(
##       width = 0.2, seed = 0)) +
##   scale_color_manual(
##     values = c("darkorange","purple",
##                "cyan4")) +
##   theme_minimal() +
##   labs(x = "Species",
##        y = "Flipper length (mm)")


## ----box_nice_out, ref.label="box_nice", echo=FALSE, fig.keep = "first"-------------------------


## ---- out.height="400px"------------------------------------------------------------------------
ggplot(data = penguins,
       aes(x = species, 
           fill = sex)) +
  geom_bar()


## ---- out.height="400px"------------------------------------------------------------------------
ggplot(data = penguins,
       aes(x = species, 
           fill = sex)) +
  geom_bar(position = "dodge")


## ----bar_pct------------------------------------------------------------------------------------
pct_data <- penguins %>% 
  count(species, sex) %>% 
  # filter(!is.na(sex)) %>%
  group_by(species) %>% 
  mutate(pct = 100*n/sum(n))
pct_data


## ---- out.height="380px"------------------------------------------------------------------------
ggplot(data = pct_data, 
       aes(x = species, y = pct, 
           fill = sex)) +
  geom_col()+ #<<
  ylab("Percent")


## ----bar_pct_calc-------------------------------------------------------------------------------
pct_data <- penguins %>% 
  count(species, sex) %>% 
  # filter(!is.na(sex)) %>%
  group_by(species) %>% 
  mutate(pct = 100*n/sum(n))
pct_data


## ---- out.height="380px"------------------------------------------------------------------------
ggplot(data = pct_data, 
       aes(x = species, y = pct, 
           fill = sex)) +
  geom_col(position = "dodge") + #<<
  ylab("Percent")



## ----child=here::here("01-intro-r-eda","child_practice5.Rmd")-----------------------------------

## ---- include = FALSE---------------------------------------------------------------------------

ggplot(data = penguins, 
       aes(x = bill_length_mm, 
           y = bill_depth_mm)) + 
  geom_point()+
  geom_smooth(method="lm")+
  labs( #<<
    title = "Flipper & bill length",
    subtitle = "Palmer Station LTER",
    x = "Flipper length(mm)", 
    y = "Bill length(mm)") + 
  scale_color_viridis_d( 
    name = "Penguin species") + 
  theme_bw() #<<

ggplot(data = penguins, 
       aes(x = bill_length_mm, 
           y = bill_depth_mm,
           color = species)) + 
  geom_point()+
  geom_smooth(method="lm")+
  labs( 
    title = "Flipper & bill length",
    subtitle = "Palmer Station LTER",
    x = "Flipper length(mm)", 
    y = "Bill length(mm)") + 
  scale_color_viridis_d( 
    name = "Penguin species") + 
  theme_bw() #<<



## ----child=here::here("01-intro-r-eda","child_factors.Rmd")-------------------------------------

## -----------------------------------------------------------------------------------------------
penguins <- penguins %>%
  mutate(sex_fac = factor(sex)) #<<
levels(penguins$sex_fac)  # factor levels are in alphanumeric order by default
penguins %>% select(sex, sex_fac) %>% summary()  # character vs. factor types
penguins %>% select(sex, sex_fac) %>% str()  # str for structure


## -----------------------------------------------------------------------------------------------
penguins <- penguins %>%
  mutate(species_fac = factor(species)) #<<

summary(penguins$species_fac)  # levels are in alphanumeric order by default

penguins <- penguins %>%
  mutate(species_fac = fct_relevel(species_fac,   #<<
                                   c("Adelie", "Gentoo", "Chinstrap"))) #<<

summary(penguins$species_fac)  # levels are specified order


## -----------------------------------------------------------------------------------------------
penguins <- penguins %>%
  mutate(species_fac2 = fct_collapse(species_fac, # collapse levels #<<
                                    Adelie = c("Adelie"), #<<
                                    Other = c("Gentoo", "Chinstrap")) #<<
         )

penguins %>% select(species_fac, species_fac2) %>% summary()
penguins %>% tabyl(species_fac, species_fac2) 



## ----child=here::here("01-intro-r-eda","child_closing.Rmd")-------------------------------------

## ---- eval=FALSE--------------------------------------------------------------------------------
## save(penguins, file = "penguins.RData")  # saving mydata within the data folder


## ---- eval=FALSE--------------------------------------------------------------------------------
## load("penguins.RData")


## ---- eval=FALSE--------------------------------------------------------------------------------
## write_csv(mydata, path = "mydata.csv")



## ---- eval=FALSE, echo=FALSE--------------------------------------------------------------------
## # RUN THESE AFTER KNITTING
## knitr::purl(here::here("01-intro-r-eda","01_intro_r_eda_part2.Rmd"),
##             out = here::here("01-intro-r-eda","01_intro_r_eda_part2.R"))
## # remotes::install_github('rstudio/pagedown')
## pagedown::chrome_print(here::here("01-intro-r-eda","01_intro_r_eda_part2.html"))

