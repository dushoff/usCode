## put all packages at the top, why?
library(readr)
library(dplyr)

dat <- read_csv("data/oldRodents.csv")

## Why is this commented out?
## summary(dat)
## summary(dat |> mutate_if(is.character, as.factor))

## filter
print(dat)

## select
