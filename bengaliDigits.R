library(readxl)
library(dplyr)
library(janitor)
library(broom)

## We can read data directly from a spreadsheet, if it is neat enough 🙂
## Download from https://data.mendeley.com/datasets/v396kvjf6y/3

## Check the columns and the names!
dat <- (
	read_excel("data/bengaliDigits.xlsx")
)
## summary(dat)

analyze <- (dat
	|> clean_names()
	|> mutate(
		leftDiff = l2d_mm - l4d_mm
		, rightDiff = r2d_mm - r4d_mm
	)
)

summary(analyze)

rdMod <- lm(rightDiff ~ 1, data=analyze)

plot(rdMod)

print(
	tidy(rdMod, conf.int=TRUE)
	|> select(term, estimate, conf.low, conf.high)
)


ldMod <- lm(leftDiff ~ 1, data=analyze)

plot(ldMod)

print(
	tidy(ldMod, conf.int=TRUE)
	|> select(term, estimate, conf.low, conf.high)
)

## How big are these differences? We could:
#### divide them by mean finger length
#### divide by a standard deviation of finger lengths
#### Think about ratios (differences on the log scale!)

analyze <- (analyze
	|> mutate(leftLogRat = log(l2d_mm) - log(l4d_mm))
)

ratMod <- lm(leftLogRat ~ 1, data=analyze)

plot(ratMod)

print(
	tidy(ratMod, conf.int=TRUE)
	|> select(term, estimate, conf.low, conf.high)
)
