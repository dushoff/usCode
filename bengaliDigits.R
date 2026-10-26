library(readxl)
library(dplyr)

## We can read data directly from a spreadsheet, if it is neat enough 🙂
## Download from https://data.mendeley.com/datasets/v396kvjf6y/3

## Check the columns and the names!
dat <- (
	read_excel("data/bengaliDigits.xlsx")
)

summary(dat)
