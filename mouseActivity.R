library(readr)
library(dplyr)
library(ggplot2); theme_set(theme_bw(base_size=15))
library(broom)

act <- read_csv("data/mouseActivityData.Rout.csv")
summary(act)

## A two-group model asks what can we tell about the difference between two groups:

twoGroup <- lm(activity~treat, data=act)

plot(twoGroup)

print(
	tidy(twoGroup, conf.int=TRUE)
	|> select(term, estimate, conf.low, conf.high)
)

## This is an older plot function that we used in a hurry
hist(residuals(twoGroup))

## Fit the same model using the continuous predictor

twoCont <- lm(activity~temp, data=act)
plot(twoCont)

print(
	tidy(twoCont, conf.int=TRUE)
	|> select(term, estimate, conf.low, conf.high)
)

