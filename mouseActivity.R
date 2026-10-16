library(readr)
library(dplyr)
library(ggplot2); theme_set(theme_bw(base_size=15))

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
confint(trMod)

