## Smoking as a _response_: logistic regression
## see also fev.R
library(readr)
library(dplyr)
library(broom)
library(ggplot2); theme_set(theme_bw(base_size=15))

source("okabe.R")

children <- read_csv("data/fevData.Rout.csv")
summary(children)

children <- children |> filter (age >= 10)

cSelect <- c("term", "estimate", "conf.low", "conf.high")

## Raw proportions: almost nobody smokes before age 10
print(children
	|> group_by(sex, age)
	|> summarise(smokers=sum(currentSmoker), n=n(), .groups="drop")
	|> mutate(prop=smokers/n)
	, n=Inf
)

######################################################################

## The linear-model machine works on the log-odds scale
## family=binomial means: logit link, binomial noise
smokeMod <- glm(currentSmoker ~ sex*age, family=binomial, data=children)
print(
	tidy(smokeMod, conf.int=TRUE)
	|> select(any_of(cSelect))
)

## Predictions: compute on the link (log-odds) scale, where the CIs make sense,
## then back-transform with plogis
ageRange <- range(children$age)
predFrame <- expand.grid(
	sex = c("female", "male")
	, age = seq(ageRange[[1]], ageRange[[2]], length.out=101)
)

preds <- (
	augment(smokeMod, newdata=predFrame, type.predict="link", se_fit=TRUE)
	|> mutate(
		logOdds = .fitted
		, lwr = .fitted - 1.96*.se.fit
		, upr = .fitted + 1.96*.se.fit
	)
)

## On the log-odds scale: straight lines (this is what we fit)
print(ggplot(preds)
	+ aes(age, logOdds, color=sex)
	+ geom_line()
	+ geom_ribbon(aes(ymin=lwr, ymax=upr, fill=sex), alpha=0.3, color=NA)
	+ ylab("log odds of smoking")
)

## On the probability scale: S-curves, data shown as jittered 0s and 1s
print(ggplot(preds)
	+ aes(age, plogis(logOdds), color=sex)
	+ geom_jitter(aes(age, as.numeric(currentSmoker))
		, data=children
		, width=0.2, height=0.03, alpha=0.3
	)
	+ geom_line()
	+ geom_ribbon(aes(ymin=plogis(lwr), ymax=plogis(upr), fill=sex)
		, alpha=0.3, color=NA
	)
	+ ylab("probability of smoking")
)

######################################################################

## What is "the effect of sex"? With an interaction, it depends on age.
## The sexmale coefficient above is the difference at age 0 -- not useful.

## Option 1: center the predictor (mean age of the children in the sample)
meanAge <- mean(children$age)
print(meanAge)
centerMod <- glm(currentSmoker ~ sex*I(age-meanAge), family=binomial, data=children)
print(
	tidy(centerMod, conf.int=TRUE)
	|> select(any_of(cSelect))
)

## Option 2: average over the population (the children we actually have)
## Predict each child as female, and as male, then average
asFemale <- mutate(children, sex="female")
asMale <- mutate(children, sex="male")

## On the log-odds scale, the model is linear in age, so this matches Option 1
print(mean(
	predict(smokeMod, newdata=asMale) - predict(smokeMod, newdata=asFemale)
))

## On the probability scale, it does not (and arguably this is what we care about)
print(mean(
	predict(smokeMod, newdata=asMale, type="response")
	- predict(smokeMod, newdata=asFemale, type="response")
))

## For comparison: the probability difference at the mean age
print(diff(predict(smokeMod
	, newdata=data.frame(sex=c("female", "male"), age=meanAge)
	, type="response"
)))

## Same questions for the age effect (slope on log-odds scale)
## Centered sex (equal weights) vs. population sex ratio
ageSlopes <- c(
	female = coef(smokeMod)[["age"]]
	, male = coef(smokeMod)[["age"]] + coef(smokeMod)[["sexmale:age"]]
)
print(ageSlopes)
print(mean(ageSlopes))
print(weighted.mean(ageSlopes, table(children$sex)[names(ageSlopes)]))
