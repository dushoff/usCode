## put all packages at the top, why?
library(readr)
library(dplyr)

## What does this do?
dat <- read_csv("data/riparianData.Rout.csv")

## Why is this commented out?
## summary(dat)
## summary(dat |> mutate_if(is.character, as.factor)) ## look at "factor view", maybe old-fashioned

## filter
print(dat)

## select

## mutate

## summarise

