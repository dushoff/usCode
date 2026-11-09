library(readr)
library(dplyr)
library(performance)
library(broom)
library(ggplot2); theme_set(theme_bw(base_size=15))

source("okabe.R")

penguins <- read_csv("data/penguinData.Rout.csv")
summary(penguins)

allMod <- lm(bill_length_mm ~ bill_depth_mm, data=penguins)
check_model(allMod)
print(
	tidy(allMod, conf.int=TRUE)
	|> select(term, estimate, conf.low, conf.high)
)

## use augment (from broom) to attach estimates to the original data!
summary(augment(allMod, interval="confidence"))

######################################################################

spMod <- lm(bill_length_mm ~ bill_depth_mm + species, data=penguins)
check_model(spMod)
print(
	tidy(spMod, conf.int=TRUE)
	|> select(term, estimate, conf.low, conf.high)
)

