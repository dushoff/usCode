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

## Remember if you just plot a model, you get diagnostic plots
plot(lMean)
summary(lMean)
print(tidy(lMean, conf.int=TRUE))

## Or use a quantitative predictor
lHeight <- lm(lungCapacity ~ 1+height, data=children)

## Remember if you just plot a model, you get diagnostic plots
plot(lHeight)
summary(lHeight)
print(tidy(lHeight, conf.int=TRUE))

## ggplot has a desire to show us nice curves with geom_smooth, it does this in a complicated way
## alpha is transparency, so we can see the fit better behind all the points
print(ggplot(children)
	+ aes(height, lungCapacity)
	+ geom_point(alpha=0.4)
	+ geom_smooth()
)

print(ggplot(children)
	+ aes(height, lungCapacity)
	+ geom_point(alpha=0.4)
	+ geom_smooth(method="lm"
		, formula=y~x
	)
)
