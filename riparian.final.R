## Put all packages at the top:
#### People know what they need
#### will get an error quickly if they don't have everything
library(readr)
library(dplyr)

## Reads the file into a table, and puts it into the variable "dat"
dat <- read_csv("data/riparianData.Rout.csv")

## Why is this commented out?
summary(dat)
## summary(dat |> mutate_if(is.character, as.factor)) ## look at "factor view", maybe old-fashioned

## filter
## select
## We could also say conQuest <- (dat ... to store instead of examine
print(dat
	|> filter(conductivity > 500)
	|> select(transect_no, position, plant_species, conductivity)
)

## 53 positions measured > 10. What if want to know about NAs?
print(dat
	|> filter(position > 10)
	|> select(transect_no, position, plant_species, conductivity)
)

## A lot more than 53 _might be_ > 10
print(dat
	|> filter_out(position <= 10)
	|> select(transect_no, position, plant_species, conductivity)
)

## Check that it all seems to work
print(dat
	|> filter_out(position <= 10 | is.na(position))
	|> select(transect_no, position, plant_species, conductivity)
)

## mutate

## summarise

