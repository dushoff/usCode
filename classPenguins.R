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
augAll <- augment(allMod, interval="confidence")

## sometimes need to think carefully about which aesthetic mappings go where; color applies to the points, but not the fit
print(ggplot(penguins)
	+ aes(bill_depth_mm, bill_length_mm)
	+ geom_point(aes(color=species))
	+ geom_line(aes(y=.fitted), data=augAll)
	+ geom_ribbon(aes(ymin=.lower, ymax=.upper)
		, data=augAll
		, alpha=0.4 ## make ribbon translucent
	)
)

######################################################################

spMod <- lm(bill_length_mm ~ bill_depth_mm + species, data=penguins)
check_model(spMod)
print(
	tidy(spMod, conf.int=TRUE)
	|> select(term, estimate, conf.low, conf.high)
)

## use augment (from broom) to attach estimates to the original data!
augSp <- augment(spMod, interval="confidence")

## sometimes need to think carefully about which aesthetic mappings go where; color applies to the points, but not the fit
print(ggplot(penguins)
	+ aes(bill_depth_mm, bill_length_mm, color=species)
	+ geom_point()
	+ geom_line(aes(y=.fitted), data=augSp)
	+ geom_ribbon(aes(ymin=.lower, ymax=.upper, fill=species)
		, data=augSp
		, alpha=0.4 ## make ribbon translucent
	)
)
