## Packages at the top
library(readr)
library(dplyr)

dat <- read_csv("data/oldRodents.csv")

## Some ways of examining the data
## You could also just click
## I didn't want these as part of my script;
## I just paste them into the console
## View(dat)
## summary(dat)
## summary(dat |> mutate_if(is.character, as.factor))

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

## This is the right answer to the wrong question, though!
## Since not all of the animals are rodents, we should have done this.

rDat <- dat |> filter(taxa=="Rodent")
print(rDat
	|> filter(weight>100)
	|> count()
)

## Count animals that either _do_ or _might_ weigh more than 100g.
print(rDat
	|> filter_out(weight<=100)
	|> count()
)

## The first answer is the same!
## This is because they did not weigh non-rodents for this rodent study
## The second answer is different (the way I did it when setting the homework is wrong, and counted a bunch of non-measured non-rodents).
