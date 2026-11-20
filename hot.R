library(readr)
library(dplyr)
library(ggplot2); theme_set(theme_bw(base_size=15))
library(performance)

children <- read_csv("data/fevData.Rout.csv")
summary(children)


quit()

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


