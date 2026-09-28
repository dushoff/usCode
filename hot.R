## put all packages at the top 
#### People know what they need
#### will get an error quickly if they don't have everything
library(readr)
library(dplyr)

## Reads the file into a table, and puts it into the variable "riparian"
riparian <- read_csv("data/riparianData.Rout.csv")

## Why is this commented out?
summary(riparian)

## filter
print(riparian
	|> filter(conductivity>500)
	|> select(distance, transect_no, plant_number, conductivity)
)

## select

## mutate

## summarise
summary(riparian)

print(riparian
	|> filter(!is.na(position))
	|> summarise(position = mean(position), .by=plant_species)
)

library(ggplot2)
theme_set(theme_bw(base_size=14))

print(ggplot(riparian)
	+ aes(x=transect_no)
	+ geom_histogram()
)
