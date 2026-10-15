library(readr)
library(dplyr)
library(ggplot2)

## Reads the file into a table, and puts it into the variable "riparian"
children <- read_csv("data/fevData.Rout.csv")

## Why is this commented out?
summary(children)

onesamp <- lm(height ~ 1, data=children)

confint(onesamp)

print(ggplot(children)
	+ aes(x=height)
	+ geom_histogram()
)

twosamp <- lm(height ~ 1, data=children)

confint(onesamp)

print(ggplot(children)
	+ aes(x=height)
	+ geom_histogram()
)


