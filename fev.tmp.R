## fev stands for forced exhalation volume, it's a measure of lung function
## It is measured in L over a period of 1s (units are a bit controversial!)
library(readr)
library(dplyr)
library(ggplot2); theme_set(theme_bw(base_size=15))
library(broom)
library(performance)
library(splines)

## Install library broom!

children <- read_csv("data/fevData.Rout.csv")

reg <- lm(lungCapacity ~ 1 + age, data=children)
plot(reg)
print(reg)
tidy(reg, conf.int=TRUE)
check_model(reg)

print(ggplot(children, aes(age, lungCapacity))
	+ geom_point(alpha=0.4)
	+ geom_smooth(method="lm"
		, formula = y ~ bs(x, 3)
	)
)

## Compare age effect with and without controlling for height
regH <- lm(lungCapacity ~ 1 + age + height, data=children)

## By hand: tidy both models and stack them
coefs <- bind_rows(
	tidy(reg, conf.int=TRUE) |> mutate(model="age only")
	, tidy(regH, conf.int=TRUE) |> mutate(model="age + height")
) |> filter(term != "(Intercept)")

print(ggplot(coefs, aes(estimate, term, colour=model))
	+ geom_pointrange(aes(xmin=conf.low, xmax=conf.high)
		, position=position_dodge(width=0.4)
	)
	+ geom_vline(xintercept=0, linetype="dashed")
	+ labs(x="Effect on lungCapacity (L per unit)", y=NULL)
)

## Same thing with the dotwhisker package
library(dotwhisker)
print(dwplot(list("age only"=reg, "age + height"=regH))
	+ geom_vline(xintercept=0, linetype="dashed")
)
