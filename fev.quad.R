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

lAug <- augment(lHeight, interval="confidence")
print(ggplot(children)
	+ aes(height, lungCapacity)
	+ geom_point()
	+ geom_line(aes(y=.fitted), data=lAug)
	+ geom_ribbon(aes(ymin=.lower, ymax=.upper)
		, data=lAug
		, alpha=0.4 ## make ribbon translucent
	)
)

qHeight <- lm(lungCapacity ~ 1+poly(height, 2), data=children)
check_model(qHeight)
print(tidy(qHeight, conf.int=TRUE))

qAug <- augment(qHeight, interval="confidence")
summary(qAug)
print(ggplot(children)
	+ aes(height, lungCapacity)
	+ geom_point()
	+ geom_line(aes(y=.fitted), data=qAug)
	+ geom_ribbon(aes(ymin=.lower, ymax=.upper)
		, data=qAug
		, alpha=0.4 ## make ribbon translucent
	)
)

