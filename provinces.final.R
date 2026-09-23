## put all packages at the top, why?
library(readr)
library(dplyr)

## What does this do?
dat <- read_tsv("data/provinces.tsv")

## mutate
print(dat)

## summarise
