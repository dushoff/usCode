library(dplyr)
library(tidyr)

set.seed(20261118)

## Experimental setup
treatment <- c("algae", "insects")
fishPerTank <- 10
numTanks <-4 ## tanks per treatment

## Parameters for growth
algae_growth <- 40
insect_effect <- 0
tankSD <- 0 ## variation among tanks
fishSD <- 2 ## variation among fish within a tank


treatEffect <- c(algae=algae_growth, insects=algae_growth+insect_effect) ## mean growth by treatment
## One row per tank, with a random tank effect
tanks <- (
	expand_grid(treatment=treatment, tankNum=1:numTanks)
	|> mutate(
		tank = paste(treatment, tankNum, sep="_")
		, tankEffect = rnorm(n(), mean=0, sd=tankSD)
	)
)

## One row per fish; growth = treatment mean + tank effect + fish noise
fish <- (
	tanks
	|> expand_grid(fish=1:fishPerTank)
	|> mutate(
		growth = treatEffect[treatment] + tankEffect
			+ rnorm(n(), mean=0, sd=fishSD)
	)
	|> select(treatment, tank, fish, growth)
)

print(fish)
summary(fish)

summary(lm(growth ~ treatment, data=fish))
