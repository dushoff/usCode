## put all packages at the top, why?
library(readr)
library(dplyr)

## What does this do?
dat <- read_tsv("data/provinces.tsv")

## mutate
dat <- (dat
	|> mutate(
		totalArea = Land + Water
		, density = Population/totalArea
		, check = totalArea-Total
	)
)

summary(dat)

