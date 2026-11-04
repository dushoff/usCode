library(readr)
library(dplyr)
library(broom)
library(ggplot2); theme_set(theme_bw(base_size=15))

penguins <- read_csv("data/penguinData.Rout.csv")

spMod <- lm(bill_length_mm ~ bill_depth_mm + species, data=penguins)
plot(spMod)
print(
	tidy(spMod, conf.int=TRUE)
	|> select(term, estimate, conf.low, conf.high)
)

spPlot <- (
	ggplot(augment(spMod, interval="confidence"))
	+ aes(bill_depth_mm, bill_length_mm, color=species, fill=species)
	+ geom_point(alpha=0.4)
	+ geom_line(aes(y=.fitted))
	+ geom_ribbon(aes(ymin=.lower, ymax=.upper), alpha=0.3, color=NA)
)
print(spPlot)

intMod <- lm(bill_length_mm ~ bill_depth_mm * species, data=penguins)
plot(intMod)
print(
	tidy(intMod, conf.int=TRUE)
	|> select(term, estimate, conf.low, conf.high)
)

intPlot <- (
	ggplot(augment(intMod, interval="confidence"))
	+ aes(bill_depth_mm, bill_length_mm, color=species, fill=species)
	+ geom_point(alpha=0.4)
	+ geom_line(aes(y=.fitted))
	+ geom_ribbon(aes(ymin=.lower, ymax=.upper), alpha=0.3, color=NA)
)
print(intPlot)

