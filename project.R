library(readr)
library(dplyr)
library(splines)
library(broom)
library(ggplot2); theme_set(theme_bw(base_size=15))
## library(performance)

children <- read_csv("data/fevData.Rout.csv")
summary(children)

## A spline is a way of making a curve that's more stable than a polynomial. 
## Interpreting splines can by hard, we're not worried because our main interest in height is to control for it, not what actually does
hmod <- lm(log(lungCapacity) ~ 1 + ns(age, 2), data=children)
augHmod <- augment(hmod, interval="confidence", data=children)

summary(augHmod)

print(ggplot(augHmod)
	+ aes(age, log(lungCapacity))
	+ geom_point()
	+ geom_line(aes(y=.fitted))
	+ geom_ribbon(aes(ymin=.lower, ymax=.upper), alpha=0.4)
)
