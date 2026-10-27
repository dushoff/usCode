library(readr)
library(dplyr)
library(broom)

penguins <- read_csv("data/penguinData.Rout.csv")
summary(penguins)

allMod <- lm(bill_length_mm ~ bill_depth_mm, data=penguins)
plot(allMod)
print(
	tidy(allMod, conf.int=TRUE)
	|> select(term, estimate, conf.low, conf.high)
)

spMod <- lm(bill_length_mm ~ bill_depth_mm + species, data=penguins)
plot(spMod)
print(
	tidy(allMod, conf.int=TRUE)
	|> select(term, estimate, conf.low, conf.high)
)
