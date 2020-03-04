## ----setup, include=FALSE--------------------------------------------------------
options(htmltools.dir.version = FALSE)

library(tidyverse)
library(lubridate)
library(janitor)
library(emo)
library(here)
library(flipbookr) #devtools::install_github("EvaMaeRey/flipbookr")

library(ggridges)
library(gapminder)
library(GGally)
library(ggExtra)
library(ggthemes)
library(hrbrthemes)
library(ggrepel)
library(corrplot)
library(ggpubr)
library(pheatmap)
library(plotly)

filter = dplyr::filter # had to do this because flipbookr code couldn't find filter()
select = dplyr::select # pheatmap causing issues

figpath = here::here("04-ggplot","figs/")

knitr::opts_chunk$set(
  warning=FALSE, 
  message=FALSE, 
  #fig.width=6, #for flipbook
  #fig.height=4,
  #fig.path = figpath, # turn on only once to save images for visual toc, messed up flipbookr, also takes longer to run
  fig.align = "center",
  rows.print=7,
  echo=TRUE,
  highlight = TRUE,
  prompt = FALSE, # IF TRUE adds a > before each code input
  comment = "", # PRINTS IN FRONT OF OUTPUT, default is '##' which comments out output
  cache = TRUE, # MAYBE TURN ON FOR FLIPBOOK
  fig.retina = 3 # for flipbook
  #comment=NA
  )

# from https://github.com/EvaMaeRey/little_flipbooks_library/
make_html_picture_link <- function(path, link){
  cat(paste0('<a href="', link, '"><img src="', 
             path, '"width="150" height="150" title=' ,
             path, ' alt=', path,'></a>'))
}

# set ggplot theme
# theme_set(theme_bw(base_size = 24))


## ----xaringan-themer, include = FALSE--------------------------------------------
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
  text_font_size = "22px",
  code_font_size = "18px",
  header_h1_font_size = "45px",
  header_h2_font_size = "40px",
  header_h3_font_size = "35px",
  padding = "0em 2em 1em 2em",
  outfile = "css/xaringan-themer.css"
)


## ----data, echo=FALSE------------------------------------------------------------
gapminder2011 <- read_csv(here("04-ggplot", "data", "Gapminder_vars_2011.csv"))
gapminder2011_long <- read_csv(here("04-ggplot", "data", "Gapminder_vars_2011_long.csv"))
pasilla_data <- read_csv(here("04-ggplot","data","gene_expr_pasilla_results.csv"))


## ----echo=FALSE, eval=FALSE------------------------------------------------------
## names(gapminder2011)


## ---- results='asis', echo=FALSE, cache=FALSE------------------------------------
make_html_picture_link("figs/barplot_regions_out-1.png", "#barplot")
make_html_picture_link("figs/hist_LifeExp_out-1.png","#histogram")
make_html_picture_link("figs/density_LifeExp_out-1.png","#density")
make_html_picture_link("figs/ridges_LifeExp_out-1.png","#ridgeline")
make_html_picture_link("figs/boxplot_LifeExp_out-1.png","#boxplot")
make_html_picture_link("figs/scatter_FoodvsLifeExp_out-1.png","#scatterplot")
make_html_picture_link("figs/bubble_FemLitvsLifeExp_out-1.png","#bubbleplot")
make_html_picture_link("figs/lineplot_YearLifeExp_out-1.png","#lineplot")

make_html_picture_link("figs/margins_FoodvsLifeExp_out-1.png","#ggmarginal")
make_html_picture_link("figs/corrplotmix-1.png","#correlation")
make_html_picture_link("figs/facet_density_all_out-1.png","#facetdensity")
make_html_picture_link("figs/facet2x_density_all_out-1.png","#facethist")

make_html_picture_link("figs/volcanoplot_out-1.png","#volcano")
make_html_picture_link("figs/heatmap_out-1.png","#heatmap")
make_html_picture_link("figs/ggpubr_out-1.png","#sidebyside")


## ----barplot_regions_nice, eval=FALSE--------------------------------------------
## ggplot(data = gapminder2011,
##        aes(x = four_regions,
##            fill = eight_regions)) +
##   geom_bar() +
##   labs(x = "World Regions",
##        y = "Number of countries",
##        title = "Barplot") +
##   theme_bw() +
##   theme(
##     axis.text.x =
##       element_text(angle = -30, hjust = 0),
##     text = element_text(family = "Palatino")) +
##   scale_fill_viridis_d(name = "Subregions")


## ----barplot_regions_out, ref.label="barplot_regions", echo=FALSE, fig.keep = "first"----


## ----barplot_regions, include=FALSE----------------------------------------------
ggplot(data = gapminder2011) +
  aes(x = four_regions) +
  geom_bar() +
  aes(fill = eight_regions) +
  scale_fill_discrete(
    name = "Subregions"
    ) +
  labs(x = "World Regions",
       y = "Number of countries",
       title = "Barplot") + 
  theme_bw() + 
  theme(axis.text.x=element_text(
    angle = -30, hjust = 0)) +
  scale_fill_viridis_d(name = "Subregions") +
  theme(
    text = element_text(family = "Palatino"))


## ----hist_LifeExp_nice, eval = FALSE---------------------------------------------
## ggplot(data = gapminder2011,
##        aes(x = LifeExpectancyYrs,
##            fill = four_regions)) +
##   geom_histogram() +
##   scale_fill_discrete(
##     name = "Regions",
##     labels = c("Africa", "Americas",
##                "Asia", "Europe")
##   ) +
##   labs(
##     x = "Life Expectancy (years)",
##     title = "Histogram"
##     ) +
##   ggthemes::theme_economist() +
##   theme(
##     legend.position="bottom"
##   )


## ----hist_LifeExp_out, ref.label="hist_LifeExp_nice", echo=FALSE-----------------


## ----hist_LifeExp, include = FALSE-----------------------------------------------
ggplot(data = gapminder2011) + 
  aes(x = LifeExpectancyYrs) + 
  geom_histogram() + 
  aes(fill = four_regions) +   
  scale_fill_discrete(
    name = "Regions",
    labels = c("Africa", "Americas", 
               "Asia", "Europe")
  ) + 
  labs(
    x = "Life Expectancy (years)",   
    title = "Histogram"
    ) + 
  ggthemes::theme_economist() +
  theme(
    legend.position="bottom"
  ) 


## ----density_LifeExp_nice, eval = FALSE------------------------------------------
## ggplot(data = gapminder2011,
##        aes(x = LifeExpectancyYrs,
##            fill = four_regions)) +
##   geom_density(alpha = 0.4) +
##   scale_fill_discrete(
##     name = "Regions",
##     labels = c("Africa", "Americas",
##                "Asia", "Europe")
##   ) +
##   labs(
##     x = "Life Expectancy (years)",
##     title = "Density Plot"
##   )+
##   hrbrthemes::theme_ipsum() +
##   theme(
##     legend.position=c(.2,.8)
##   )


## ----density_LifeExp_out, ref.label="density_LifeExp_nice", echo=FALSE-----------


## ----density_LifeExp, include = FALSE--------------------------------------------
ggplot(data = gapminder2011) + 
  aes(x = LifeExpectancyYrs) + 
  geom_density() +
  aes(fill = four_regions) +
  aes(alpha=.4) +   
  scale_fill_discrete(
    name = "Regions",
    labels = c("Africa", "Americas", 
               "Asia", "Europe")
  ) +
  scale_alpha(
    guide = "none"
  ) +
  hrbrthemes::theme_ipsum() +
  theme(
    legend.position=c(.2,.8)
    ) + 
  labs(
    x = "Life Expectancy (years)",   
    title = "Density Plot"
    )


## ----ridges_LifeExp_nice, eval = FALSE-------------------------------------------
## # library(ggridges)
## ggplot(data = gapminder2011,
##        aes(x = LifeExpectancyYrs,
##            y = four_regions,
##            fill = four_regions)) +
##   geom_density_ridges(alpha = 0.4) +
##   ggthemes::theme_clean() +
##   theme(legend.position="none") +
##   labs(
##     x = "Life Expectancy (years)",
##     y = "Regions",
##     title = "Ridgeline Density Plot"
##     )


## ----ridges_LifeExp_out, ref.label="ridges_LifeExp_nice", echo=FALSE-------------


## ----ridges_LifeExp, include = FALSE---------------------------------------------
# library(ggridges)
ggplot(data = gapminder2011) + 
  aes(x = LifeExpectancyYrs) + 
  aes(y = four_regions) + 
  geom_density_ridges() +
  aes(fill = four_regions) +
  aes(alpha = 0.4) +  
  ggthemes::theme_clean() + 
  theme(legend.position = "none") + 
  labs(
    x = "Life Expectancy (years)",   
    y = "Regions",
    title = "Ridgeline Density Plot"
    )


## ----boxplot_LifeExp_nice, eval = FALSE------------------------------------------
## ggplot(data = gapminder2011,
##        aes(y = LifeExpectancyYrs,
##            x = four_regions,
##            fill = four_regions)) +
##   geom_boxplot(alpha = 0.3) +
##   coord_flip() +
##   theme_fivethirtyeight() +
##   scale_fill_fivethirtyeight() +
##   theme(legend.position = "none") +
##   geom_jitter(
##     width = .1,
##     alpha = 0.3
##     ) +
##   geom_violin(
##     colour = "grey",
##     alpha = .2
##   ) +
##   labs(
##     x = "World Region",
##     y = "Life Expectancy (years)",
##     title = "Boxplot")


## ----boxplot_LifeExp_out, ref.label="boxplot_LifeExp_nice", echo=FALSE-----------


## ----boxplot_LifeExp, include = FALSE--------------------------------------------
ggplot(data = gapminder2011) + 
  aes(y = LifeExpectancyYrs) + 
  geom_boxplot() + 
  aes(x = four_regions) +   
  aes(fill = four_regions) +
  aes(alpha=.3) +   
  coord_flip() +   
  theme_fivethirtyeight() +
  scale_fill_fivethirtyeight() + 
  theme(legend.position = "none") + 
  geom_jitter(
    width = .1, 
    alpha = 0.3  
    ) +
  geom_violin(
    colour = "grey",
    alpha = .2
  ) + 
  labs(
    x = "World Region",    
    y = "Life Expectancy (years)",   
    title = "Boxplot")


## ----scatter_FoodvsLifeExp_nice, eval = FALSE------------------------------------
## ggplot(data = gapminder2011,
##        aes(x = FoodSupplykcPPD,
##            y = LifeExpectancyYrs,
##            color = four_regions)) +
##   geom_point(alpha = 0.4) +
##   geom_smooth(se = FALSE)+
##   geom_smooth(method = lm) +
##   theme_minimal() +
##   scale_color_colorblind(
##     name = "Regions",
##     labels = c("Africa", "Americas",
##                "Asia", "Europe")
##   ) +
##   labs(
##     x = "Daily Food Supply Per Person (kc)",
##     y = "Life Expectancy (years)",
##     title = "Scatterplot"
##     )


## ----scatter_FoodvsLifeExp_out, ref.label="scatter_FoodvsLifeExp_nice", echo=FALSE----


## ----scatter_FoodvsLifeExp, include = FALSE--------------------------------------
ggplot(data = gapminder2011) + 
  aes(x = FoodSupplykcPPD) + 
  aes(y = LifeExpectancyYrs) + 
  geom_point() +
  aes(color = four_regions) +
  aes(alpha=.4) +   
  scale_color_colorblind(
    name = "Regions",
    labels = c("Africa", "Americas", 
               "Asia", "Europe")
  ) +
  scale_alpha(
    guide = "none"
  ) +
  geom_smooth(
    se = FALSE
  ) +
  geom_smooth(
    method = lm
  ) +
  theme_minimal() +
  labs(
    x = "Daily Food Supply Per Person (kc)",   
    y = "Life Expectancy (years)",   
    title = "Scatterplot"
    )


## ----bubble_FemLitvsLifeExp_nice, eval = FALSE-----------------------------------
## ggplot(data = gapminder2011,
##        aes(x = FoodSupplykcPPD,
##            y = LifeExpectancyYrs,
##            color = four_regions,
##            size = population)) +
##   geom_point(alpha = 0.4) +
##   scale_color_colorblind(
##     name = "Regions",
##     labels = c("Africa", "Americas",
##                "Asia", "Europe")
##   ) +
##   scale_size(
##     name = "Population Size (millions)",
##     breaks = c(1e08,5e08,1e09),
##     labels = c(100,500,1000)
##   ) +
##   hrbrthemes::theme_ipsum() +
##   labs(
##     x = "Daily Food Supply PP (kc)",
##     y = "Life Expectancy (years)",
##     title = "Bubbleplot"
##     )


## ----bubble_FemLitvsLifeExp_out, ref.label="bubble_FemLitvsLifeExp_nice", echo=FALSE----


## ----bubble_FemLitvsLifeExp, include = FALSE-------------------------------------
ggplot(data = gapminder2011) + 
  aes(x = FoodSupplykcPPD) + 
  aes(y = LifeExpectancyYrs) + 
  geom_point() +
  aes(color = four_regions) +
  aes(alpha=.4) +   
  aes(size = population) +
  scale_color_colorblind(
    name = "Regions",
    labels = c("Africa", "Americas", 
               "Asia", "Europe")
  ) +
  scale_size(
    name = "Population Size (millions)",
    breaks = c(1e08,5e08,1e09),
    labels = c(100,500,1000)
  ) +
  scale_alpha(
    guide = "none"
  ) +
  hrbrthemes::theme_ipsum() +
  labs(
    x = "Daily Food Supply PP (kc)",  
    y = "Life Expectancy (years)",   
    title = "Bubbleplot"
    )


## ----lineplot_YearLifeExp_nice, eval = FALSE-------------------------------------
## ggplot(data = gapminder,
##        aes(x = year,
##            y = lifeExp,
##            color = continent,
##            group = country)) +
##   geom_point(alpha = 0.4) +
##   geom_line(alpha = 0.7) +
##   scale_color_colorblind(
##     name = "Continents"
##   ) +
##   ggthemes::theme_clean() +
##   labs(
##     x = "Year",
##     y = "Life Expectancy (years)",
##     title = "Lineplot"
##     )


## ----lineplot_YearLifeExp_out, ref.label="lineplot_YearLifeExp_nice", echo=FALSE----


## ----lineplot_YearLifeExp, include = FALSE---------------------------------------
ggplot(data = gapminder) + 
  aes(x = year) + 
  aes(y = lifeExp) + 
  geom_point() +
  aes(color = continent) +
  aes(alpha=.4) +
  geom_line(
    alpha = .7
  ) +
  aes(group = country) +
  scale_color_colorblind(
    name = "Continents"
  ) +
  scale_alpha(
    guide = "none"
  ) +
  ggthemes::theme_clean() + 
  labs(
    x = "Year",   
    y = "Life Expectancy (years)",   
    title = "Lineplot"
    )


## ----margins_FoodvsLifeExp, fig.width=10, fig.height=5---------------------------
# library(ggExtra)

p <- ggplot(data = gapminder2011,
        aes(x = FoodSupplykcPPD, 
            y = LifeExpectancyYrs,
            color = four_regions,
            alpha=.4)) +
  geom_point() +
  scale_color_discrete(
    name = "Regions",
    labels = c("Africa", "Americas", 
               "Asia", "Europe")) +
  scale_alpha(guide = "none") +
  theme(legend.position="bottom") +
  labs(
    x = "Daily Food Supply Per Person (kc)",   
    y = "Life Expectancy (years)",   
    title = "Scatterplot"
    )


## ----margins_FoodvsLifeExp_out, fig.width=10, fig.height=5-----------------------
ggMarginal(p,
  type = "density",
  margins = "both",
  groupColour = TRUE,
  groupFill = TRUE
)


## --------------------------------------------------------------------------------
M <- cor(gapminder2011 %>% 
           select(FoodSupplykcPPD:WaterSourcePrct),
         use = "complete.obs" # specified since there are missing values
         )
M


## ----fig.height=4----------------------------------------------------------------
library(corrplot)
corrplot(M, method = "number")


## ----fig.width=10, fig.height=3--------------------------------------------------
corrplot(M, method = "ellipse")


## ---- fig.height=2---------------------------------------------------------------
corrplot.mixed(M)


## ----corrplotmix, include=FALSE, fig.width=8, fig.height=8-----------------------
corrplot.mixed(M)


## ----fig.width=10, fig.height=5--------------------------------------------------
# library(GGally)
gapminder2011 %>% 
  select(FoodSupplykcPPD:WaterSourcePrct) %>% 
  ggcorr()


## ----fig.width=10, fig.height=5--------------------------------------------------
# library(GGally)
gapminder2011 %>% 
  select(FoodSupplykcPPD:WaterSourcePrct) %>% 
  ggpairs()


## ----facet_density_all_nice, eval = FALSE----------------------------------------
## ggplot(data = gapminder2011_long,
##        aes(x = Values,
##            color = four_regions)) +
##   facet_wrap(
##     ~ Measures,
##     scales = "free",
##     ncol = 2) +
##   geom_density() +
##   ggthemes::theme_few() +
##   theme(
##     legend.position="top"
##     )  +
##   scale_color_discrete(
##     name = "Regions",
##     labels = c("Africa", "Americas",
##                "Asia", "Europe")
##   ) +
##   labs(
##     x = "",
##     title = "Faceted Density Plots"
##     )


## ----facet_density_all_out, ref.label="facet_density_all_nice", echo=FALSE-------


## ----facet_density_all, include = FALSE------------------------------------------
ggplot(data = gapminder2011_long) + 
  aes(x = Values) + 
  geom_density() + 
  facet_wrap( 
    ~ Measures, 
    scales = "free", 
    ncol = 2) + 
  aes(color = four_regions) + 
  ggthemes::theme_few() + 
  theme( 
    legend.position="top" 
    )  + 
  scale_color_discrete( 
    name = "Regions", 
    labels = c("Africa", "Americas",  
               "Asia", "Europe") 
  ) + 
  labs( 
    x = "",    
    title = "Faceted Density Plots" 
    )


## ----facet2x_density_all_nice, eval = FALSE, fig.width=10, fig.height=5----------
## ggplot(data = gapminder2011_long) +
##   geom_histogram(aes(x = Values)) +
##   facet_grid(
##     four_regions ~ Measures,
##     scales = "free_x"
##     ) +
##   ggthemes::theme_igray() +
##   theme(
##     strip.text.y = element_text(size=10,
##                                 angle=45,
##                                 face = "bold"),
##     strip.text.x = element_text(size=6),
##     axis.text.x = element_text(angle=45,
##                                hjust=1)
##   ) +
##   labs(
##     x = "",
##     title = "Faceted Density Plots"
##     )


## ----facet2x_density_all_out, ref.label="facet2x_density_all_nice", echo=FALSE----


## ----facet2x_density_all, include = FALSE, fig.width=10, fig.height=5------------
ggplot(data = gapminder2011_long) + 
  aes(x = Values) +
  facet_grid(
    four_regions ~ Measures, 
    scales = "free_x"
    ) + 
  geom_histogram() +
  ggthemes::theme_igray() + 
  theme(
    strip.text.y = element_text(size=10, 
                                angle=45, 
                                face = "bold"),
    strip.text.x = element_text(size=6),
    axis.text.x = element_text(angle=45, 
                               hjust=1)
    ) + 
  labs(
    x = "",   
    title = "Faceted Density Plots"
    )


## --------------------------------------------------------------------------------
glimpse(pasilla_data)


## ----volcanoplot_nice, include = TRUE--------------------------------------------
# Create subset for labeling
pasilla_data_top = pasilla_data %>%
  filter(-log10(padj) > 10, 
         abs(log2FoldChange) > 2.5)

ggplot(data = pasilla_data,
       aes(x = log2FoldChange,
           y = log10(padj))) +
  geom_point() + 
  scale_y_reverse() +
  aes(color = padj < 0.05) +
  ggrepel::geom_text_repel(
    data = pasilla_data_top, 
    aes(label = gene), color = "black",
    box.padding = 0.5, min.segment.length = 0) +
  xlim(c(-7,7)) + 
  geom_vline(xintercept = c(-2.5, 2.5), 
             lty = "dashed", color="grey") + 
  ggthemes::theme_clean() + 
  labs(
    x = bquote(~Log[2]~ "fold change"),
    y = bquote(~Log[10]~adjusted~italic(P)),
    title = "Volcano Plot - Gene Expression of Pasilla Data"
  )


## ----volcanoplot_out, ref.label="volcanoplot", echo=FALSE------------------------


## ----volcanoplot, include=FALSE--------------------------------------------------
ggplot(data = pasilla_data,
       aes(x = log2FoldChange,
           y = log10(padj))) +
  geom_point() + 
  scale_y_reverse() +
  aes(color = padj < 0.05) +
  ggrepel::geom_text_repel(
    data = pasilla_data_top, 
    aes(label = gene), color = "black",
    box.padding = 0.5,
    min.segment.length = 0) +
  xlim(c(-7,7)) + 
  geom_vline(xintercept = c(-2.5, 2.5), 
             lty = "dashed", color="grey") + 
  ggthemes::theme_clean() + 
  labs(
    x = bquote(~Log[2]~ "fold change"),
    y = bquote(~Log[10]~adjusted~italic(P)),
    title = "Volcano Plot - Gene Expression of Pasilla Data"
  )


## ----pasilla_heat, cache=FALSE---------------------------------------------------
pasilla_heat <- pasilla_data %>%
  select(treated1:untreated4)
# subtract off gene-specific means
pasilla_heat <- pasilla_heat - rowMeans(pasilla_heat)
# calculate standard deviation of each centered gened
sd_gene <- apply(pasilla_heat,1,sd)
# select top 500 most variable
pasilla_heat <- pasilla_heat[order(sd_gene, decreasing = TRUE)[1:500],]
head(pasilla_heat)


## ----heatmap, eval=FALSE---------------------------------------------------------
## pheatmap::pheatmap(mat = pasilla_heat,
##                    show_rownames = FALSE)


## ----heatmap_out, ref.label="heatmap", echo=FALSE--------------------------------


## ----ggpubr----------------------------------------------------------------------
p1 <- ggplot(data = pasilla_data,
       aes(x = log2FoldChange,
           y = -log10(padj),
           color = log10(baseMean))) +
  geom_point() + 
  geom_vline(xintercept = c(-2.5, 2.5), 
             lty = 2, color="grey") + 
  theme_few() + scale_color_viridis_c() + 
  labs(x = bquote(~Log[2]~ "fold change"),
       y = bquote(~Log[10]~adjusted~italic(P)),
       title = "Volcano Plot")
p2 <- ggplot(data = pasilla_data,
       aes(x = baseMean,
           y = log2FoldChange,
           color = log10(baseMean))) +
  geom_point() + 
  scale_x_log10() + 
  geom_hline(yintercept = 0, color = "red") + 
  theme_few() + scale_color_viridis_c() + 
  labs(y = bquote(~Log[2]~ "fold change"),
       x = bquote(~Log[10]~ "mean expression"),
       title = "MA Plot")


## ----ggpubr_out,out.height="80%", out.width="80%", fig.width=6, fig.height=6-----
ggpubr::ggarrange(p1, p2, labels = "AUTO",
  common.legend = TRUE, legend = "bottom")


## ----ggplotly--------------------------------------------------------------------
# Save ggplot
p1 <- ggplot(
  data = pasilla_data,
  aes(x = log2FoldChange,
      y = -log10(padj),
      color = log10(baseMean),
      key = gene) #<<
) +
  geom_point() +
  geom_vline(
    xintercept = c(-2.5, 2.5), 
    lty = 2, color="grey") + 
  theme_few() + 
  scale_color_viridis_c()


## ---- eval = FALSE---------------------------------------------------------------
## plotly::ggplotly(p1) #<<


## ----ggplotly_interactive, echo = FALSE------------------------------------------
plotly::ggplotly(p1)


## --------------------------------------------------------------------------------
ggsave(plot = p1,
       filename = "figs/volcanoplot_small.png", 
       height = 4, 
       width = 4, 
       units = "in",
       dpi = 100)


## --------------------------------------------------------------------------------
ggsave(plot = p1,
       filename = "figs/volcanoplot_large.png", 
       height = 10, 
       width = 10, 
       units = "in",
       dpi = 300)


## ---- eval=FALSE, echo=FALSE-----------------------------------------------------
## # RUN THESE AFTER KNITTING
## knitr::purl(here::here("04-ggplot","04_ggplot_slides.Rmd"),
##             out = here::here("04-ggplot","04_ggplot.R"))
## # remotes::install_github('rstudio/pagedown')
## pagedown::chrome_print(here::here("04-ggplot/04_ggplot_slides.html"))

