library(readxl)
library(janitor)
library(dplyr)
library(broom)

dat <- (
	read_excel("data/bengaliDigits.xlsx")
	|> clean_names()
)

lengths <- (dat
	|> select(sex, r2d_mm, r4d_mm, l2d_mm, l4d_mm)
	|> mutate(rdiff=r4d_mm-r2d_mm)
	|> mutate(twoDiff=r2d_mm-l2d_mm)
)

summary(lengths)

## Rename and try the twoDiff model
pModel <- lm(rdiff~1, data=lengths)
tidy(pModel)

