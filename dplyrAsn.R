## Packages at the top
library(readr)
library(dplyr)

dat <- read_csv("data/oldRodents.csv")
summary(dat)
summary(dat |> mutate_if(is.character, as.factor))

## I wanted to remember to do this, but it's not really part of my script. 
## View(dat)

## I didn't notice, but a student pointed out to me, that not all animals in the rodent data are rodents!

## Here's how I did it

## Count animals _observed to_ weigh _more than_ 100g.

print(dat
	|> filter(weight>100)
	|> count()
)

## Count animals that either _do_ or _might_ weigh more than 100g.
print(dat
	|> filter_out(weight<=100)
	|> count()
)

## We should be able to confirm that this gives the same answer as explicitly asking if the animal was observed to be in our group _or_ the data was missing
print(dat
	|> filter(weight>100 | is.na(weight))
	|> count()
)

