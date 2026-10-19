## fev stands for forced exhalation volume, it's a measure of lung function
library(readr)
library(dplyr)
library(ggplot2); theme_set(theme_bw(base_size=15))
library(broom)

## Install library broom!

children <- read_csv("data/fevData.Rout.csv")

summary(children)

lMean <- lm(lungCapacity ~ 1, data=children)

plot(lMean)

summary(lMean)

print(tidy(lMean))
