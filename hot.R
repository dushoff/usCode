## put all packages at the top 
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
print(dat
	|> filter(conductivity>500)
	|> select(distance, transect_no, plant_number, conductivity)
)

## select

## mutate

## summarise
summary(dat)

print(dat
	|> filter(!is.na(position))
	|> summarise(position = mean(position), .by=plant_species)
)

library(ggplot2)
theme_set(theme_bw())

print(ggplot(dat)
	+ aes(x=wet, y=plant_species)
	+ geom_boxplot()
	+ scale_x_log10()
)
