## fev stands for forced exhalation volume, it's a measure of lung function
## It is measured in L over a period of 1s (units are a bit controversial!)
library(readr)
library(dplyr)
library(ggplot2); theme_set(theme_bw(base_size=15))

## Install library broom if necessary
library(broom)

children <- read_csv("data/fevData.Rout.csv")

summary(children)

## It doesn't matter which “kind” of lm you are doing
## Just tell R what predictors you want
lMean <- lm(lungCapacity ~ 1, data=children)

plot(lMean)

summary(lMean)

print(tidy(lMean, conf.int=TRUE))
