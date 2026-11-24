library(readr)
library(dplyr)
library(broom)
library(ggplot2); theme_set(theme_bw(base_size=15))

source("okabe.R")

children <- read_csv("data/fevData.Rout.csv")
summary(children)

######################################################################

## What proportion of smokers are above a given age? Or what age do we need to include to get 90% of smokers

print(children
	|> summarize(lowAge = quantile(age, 0.1))
)

print(children
	|> filter(currentSmoker)
	|> summarize(lowAge = quantile(age, 0.1))
)

studyChildren <- (children
	|> filter(age>=11)
)

######################################################################

hMod <- lm(log(lungCapacity) ~ 1 + poly(height, 1), data=studyChildren)
plot(hMod)

hPredict <- augment(hMod, interval="confidence", data=studyChildren)
summary(hPredict)

hPlot <- (ggplot(hPredict)
	+ aes(height, log(lungCapacity))
	+ geom_point()
	+ geom_line(aes(y=.fitted))
	+ geom_ribbon(aes(ymin=.lower, ymax=.upper)
		, alpha=0.4 ## make ribbon translucent
	)
)
print(hPlot)

aMod <- lm(log(lungCapacity) ~ 1 + poly(age, 2), data=studyChildren)
plot(aMod)

aPredict <- augment(aMod, interval="confidence", data=studyChildren)
summary(aPredict)

print(ggplot(aPredict)
	+ aes(age, log(lungCapacity))
	+ geom_point()
	+ geom_line(aes(y=.fitted))
	+ geom_ribbon(aes(ymin=.lower, ymax=.upper)
		, alpha=0.4 ## make ribbon translucent
	)
)

covMod <- lm(log(lungCapacity) ~ 1 + poly(age, 2)*sex + height*sex
	, data=studyChildren
)

plot(covMod)

mainMod <- lm(log(lungCapacity) 
	~ 1 + poly(age, 2)*sex + height*sex + currentSmoker
	, data=studyChildren
)

plot(mainMod)

coef(mainMod)
confint(mainMod)
