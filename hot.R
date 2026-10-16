library(readr)
library(dplyr)
library(ggplot2); theme_set(theme_bw(base_size=15))

children <- read_csv("data/fevData.Rout.csv")

## Why is this commented out?
summary(children)

onesamp <- lm(height ~ 1, data=children)

summary(onesamp)
confint(onesamp)
plot(onesamp)

print(ggplot(children)
	+ aes(x=height)
	+ geom_histogram()
)

twosamp <- lm(height ~ 1+sex, data=children)

confint(twosamp)

print(ggplot(children)
	+ aes(x=height, fill=sex)
	+ geom_histogram()
	+ facet_wrap(~sex)
)


