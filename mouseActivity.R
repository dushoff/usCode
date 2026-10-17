library(readr)
library(dplyr)
library(ggplot2); theme_set(theme_bw(base_size=15))
library(broom)

act <- read_csv("data/mouseActivityData.Rout.csv")
summary(act)

print(ggplot(act)
	+ aes(x=treat, y=activity)
	+ geom_point()
)

print(ggplot(act)
	+ aes(x=temp, y=activity)
	+ geom_point()
)

trMod <- lm(activity ~ treat, data=act)
summary(trMod)

(pars <- 
	tidy(trMod, conf.int=TRUE)
	|> select(term, estimate, conf.low, conf.high)
) |> print()


tempMod <- lm(activity ~ treat, data=act)
summary(tempMod)

(pars <- 
	tidy(tempMod, conf.int=TRUE)
	|> select(term, estimate, conf.low, conf.high)
) |> print()

