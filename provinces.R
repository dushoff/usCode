## put all packages at the top, why?
library(readr)
library(dplyr)

## What does this do?
dat <- read_csv("data/provinces.tsv")

## Why is this commented out?
summary(dat)
## summary(dat |> mutate_if(is.character, as.factor))

## filter
print(dat)

## select
