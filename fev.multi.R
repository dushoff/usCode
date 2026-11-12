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

cSelect <- c("term", "estimate", "conf.low", "conf.high")

## What is the effect of smoking on lung capacity?
lSmoke <- lm(lungCapacity ~ 1+currentSmoker+age, data=children)
## check_model(lSmoke)
print(
	tidy(lSmoke, conf.int=TRUE)
	|> select(any_of(cSelect))
)

print(ggplot(children)
	+ aes(currentSmoker, lungCapacity)
	+ geom_boxplot()
)

## What is the effect of age on lung capacity?
## Total effect

ageMod <- lm(lungCapacity ~ 1 + age, data=children)
check_model(ageMod)
print(
	tidy(ageMod, conf.int=TRUE)
	|> select(any_of(cSelect))
)

ageHeightMod <- lm(lungCapacity ~ 1 + age + height, data=children)
check_model(ageHeightMod)
print(
	tidy(ageHeightMod, conf.int=TRUE)
	|> select(any_of(cSelect))
)

