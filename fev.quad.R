## see also fev.R
library(readr)
library(dplyr)
library(ggplot2); theme_set(theme_bw(base_size=15))

## Install library broom if necessary
library(broom)

## Same for performance
library(performance);

children <- read_csv("data/fevData.Rout.csv")

summary(children)

lHeight <- lm(lungCapacity ~ 1+height, data=children)
check_model(lHeight)
print(tidy(lHeight, conf.int=TRUE))

