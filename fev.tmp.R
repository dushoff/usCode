## fev stands for forced exhalation volume, it's a measure of lung function
## It is measured in L over a period of 1s (units are a bit controversial!)
library(readr)
library(dplyr)
library(ggplot2); theme_set(theme_bw(base_size=15))
library(broom)
library(performance)

## Install library broom!

children <- read_csv("data/fevData.Rout.csv")

reg <- lm(lungCapacity ~ 1 + age, data=children)
plot(reg)
print(reg)
tidy(reg, conf.int=TRUE)
check_model(reg)

print(ggplot(children, aes(age, lungCapacity))
	+ geom_point(alpha=0.4)
	+ geom_smooth(method="lm")
)
